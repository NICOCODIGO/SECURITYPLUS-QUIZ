package com.secplus.me;

import java.sql.Timestamp;
import java.sql.Types;
import java.time.Instant;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

import com.secplus.me.MeViews.AnswerView;
import com.secplus.me.MeViews.AttemptUpload;
import com.secplus.me.MeViews.AttemptView;
import com.secplus.me.MeViews.DailyView;
import com.secplus.me.MeViews.DomainSlice;

/**
 * Every read and write of one account's study data.
 *
 * **SQL rather than JPA, on purpose.** The rest of the server uses JPA because
 * questions and users are ordinary entity graphs. These tables are not: three
 * of them have composite primary keys, every write wants Postgres's
 * `on conflict` to be idempotent, and the per-domain breakdown is a `group by`
 * aggregate rather than a mapped field. Expressing that through entities means
 * `@IdClass` ceremony plus native queries anyway. JdbcClient says what is
 * actually happening, and SchemaMigrationTests already uses it.
 *
 * **Every statement filters on user_id.** It is the only ownership check in the
 * system — there is no row-level security behind it — so a query that forgets
 * it hands one account another's history.
 */
@Repository
public class MeStore {

	private final JdbcClient db;

	MeStore(DataSource dataSource) {
		this.db = JdbcClient.create(dataSource);
	}

	/* ------------------------------------------------------------ attempts -- */

	public List<AttemptView> attempts(UUID userId) {
		List<AttemptView> rows = db.sql("""
				select id, submitted_at, type, score, questions_count, duration_seconds, domain_title
				from attempts
				where user_id = :userId
				order by submitted_at
				""")
			.param("userId", userId)
			.query((rs, n) -> new AttemptView(
					rs.getObject("id", UUID.class),
					rs.getObject("submitted_at", OffsetDateTime.class).toInstant().toString(),
					rs.getString("type"),
					rs.getInt("score"),
					rs.getInt("questions_count"),
					(Integer) rs.getObject("duration_seconds"),
					rs.getString("domain_title"),
					List.of(), List.of()))
			.list();

		if (rows.isEmpty()) {
			return rows;
		}

		Map<UUID, List<AnswerView>> answers = answersByAttempt(userId);
		Map<UUID, List<DomainSlice>> breakdown = breakdownByAttempt(userId);

		return rows.stream()
			.map(a -> new AttemptView(a.id(), a.date(), a.type(), a.score(), a.questionsCount(),
					a.durationSeconds(), a.domainTitle(),
					breakdown.getOrDefault(a.id(), List.of()),
					answers.getOrDefault(a.id(), List.of())))
			.toList();
	}

	/**
	 * Answers for every attempt in one query rather than one per attempt.
	 *
	 * `legacy_hash` is what the browser keys answers by, so that is selected
	 * back out rather than the uuid. A question reworded since has a null
	 * `question_id` and therefore no hash; the inner join drops those rows,
	 * because the client can do nothing with an answer it cannot match to a
	 * question it holds.
	 */
	private Map<UUID, List<AnswerView>> answersByAttempt(UUID userId) {
		Map<UUID, List<AnswerView>> out = new HashMap<>();
		db.sql("""
				select aa.attempt_id, q.legacy_hash, aa.is_correct
				from attempt_answers aa
				join attempts a on a.id = aa.attempt_id
				join questions q on q.id = aa.question_id
				where a.user_id = :userId
				order by aa.attempt_id, aa.position
				""")
			.param("userId", userId)
			.query((rs, n) -> out
				.computeIfAbsent(rs.getObject("attempt_id", UUID.class), k -> new ArrayList<>())
				.add(new AnswerView(rs.getString("legacy_hash"), rs.getBoolean("is_correct"))))
			.list();
		return out;
	}

	/** Grouped by filed_domain to match what the browser computed — see MeViews.DomainSlice. */
	private Map<UUID, List<DomainSlice>> breakdownByAttempt(UUID userId) {
		Map<UUID, List<DomainSlice>> out = new HashMap<>();
		db.sql("""
				select aa.attempt_id,
				       q.filed_domain,
				       count(*) as total,
				       count(*) filter (where aa.is_correct) as correct
				from attempt_answers aa
				join attempts a on a.id = aa.attempt_id
				join questions q on q.id = aa.question_id
				where a.user_id = :userId
				group by aa.attempt_id, q.filed_domain
				order by aa.attempt_id, q.filed_domain
				""")
			.param("userId", userId)
			.query((rs, n) -> {
				int total = rs.getInt("total");
				int correct = rs.getInt("correct");
				return out
					.computeIfAbsent(rs.getObject("attempt_id", UUID.class), k -> new ArrayList<>())
					.add(new DomainSlice(rs.getInt("filed_domain"),
							total == 0 ? 0 : Math.round(correct * 100f / total), correct, total));
			})
			.list();
		return out;
	}

	/**
	 * Stores one attempt, idempotently.
	 *
	 * The id is minted by the client, so posting the same attempt twice inserts
	 * nothing the second time rather than duplicating somebody's history. That
	 * is the whole dedupe strategy: no natural key, no timestamp matching.
	 * Returns true when a row was actually written.
	 */
	public boolean saveAttempt(UUID userId, AttemptUpload attempt) {
		int inserted = db.sql("""
				insert into attempts (id, user_id, type, score, questions_count,
				                      duration_seconds, domain_title, server_graded, submitted_at)
				values (:id, :userId, :type, :score, :count, :duration, :title, false, :at)
				on conflict (id) do nothing
				""")
			.param("id", attempt.id())
			.param("userId", userId)
			.param("type", attempt.type())
			.param("score", attempt.score())
			.param("count", attempt.questionsCount())
			.param("duration", attempt.durationSeconds(), Types.INTEGER)
			.param("title", attempt.domainTitle(), Types.VARCHAR)
			.param("at", Timestamp.from(Instant.parse(attempt.date())))
			.update();

		// Already stored. Leave its answers alone rather than rewriting them.
		if (inserted == 0) {
			return false;
		}

		Map<String, UUID> ids = resolveHashes(attempt.answers().stream().map(AnswerView::id).toList());
		List<AnswerView> answers = attempt.answers();

		for (int position = 0; position < answers.size(); position++) {
			AnswerView answer = answers.get(position);
			db.sql("""
					insert into attempt_answers (attempt_id, position, question_id,
					                             chosen_choice_id, is_correct)
					values (:attempt, :position, :question, null, :ok)
					on conflict (attempt_id, position) do nothing
					""")
				.param("attempt", attempt.id())
				.param("position", position)
				// Null when the question was reworded since. The column is
				// nullable precisely so old history survives an edit.
				.param("question", ids.get(answer.id()), Types.OTHER)
				// chosen_choice_id is always null: the browser records only
				// whether the answer was right, never which option was picked.
				.param("ok", answer.ok())
				.update();
		}
		return true;
	}

	/** Bulk hash to uuid, so a 90-question mock costs one lookup rather than ninety. */
	private Map<String, UUID> resolveHashes(List<String> hashes) {
		if (hashes.isEmpty()) {
			return Map.of();
		}
		Map<String, UUID> out = new LinkedHashMap<>();
		db.sql("select legacy_hash, id from questions where legacy_hash in (:hashes)")
			.param("hashes", hashes)
			.query((rs, n) -> out.put(rs.getString("legacy_hash"), rs.getObject("id", UUID.class)))
			.list();
		return out;
	}

	/* --------------------------------------------------------------- flags -- */

	public List<String> flags(UUID userId) {
		return db.sql("""
				select q.legacy_hash from flagged_questions f
				join questions q on q.id = f.question_id
				where f.user_id = :userId
				order by q.legacy_hash
				""").param("userId", userId).query(String.class).list();
	}

	/**
	 * Replaces the whole set, because that is what the browser holds: a Set it
	 * rewrites on every toggle.
	 *
	 * Unresolvable hashes are **dropped**, not stored as null. Unlike
	 * attempt_answers, `flagged_questions.question_id` is `not null`, so a flag
	 * on a since-reworded question cannot be represented at all.
	 */
	public void replaceFlags(UUID userId, List<String> hashes) {
		db.sql("delete from flagged_questions where user_id = :userId")
			.param("userId", userId)
			.update();

		if (hashes.isEmpty()) {
			return;
		}
		for (UUID questionId : resolveHashes(hashes).values()) {
			db.sql("""
					insert into flagged_questions (user_id, question_id) values (:userId, :question)
					on conflict (user_id, question_id) do nothing
					""").param("userId", userId).param("question", questionId).update();
		}
	}

	/* --------------------------------------------------------------- daily -- */

	public List<DailyView> daily(UUID userId) {
		return db.sql("""
				select answered_on, is_correct, answered_at from daily_answers
				where user_id = :userId order by answered_on
				""")
			.param("userId", userId)
			.query((rs, n) -> new DailyView(rs.getObject("answered_on", LocalDate.class).toString(),
					rs.getBoolean("is_correct"),
					rs.getObject("answered_at", OffsetDateTime.class).toInstant().toString()))
			.list();
	}

	/**
	 * One row per user per day, so answering again updates rather than fails.
	 *
	 * `question_id` and `choice_id` stay null: the browser stores a choice
	 * *index*, not a choice id, and re-derives the question from the date. Only
	 * the result is needed, and the streak is computed from which days exist.
	 */
	public void saveDaily(UUID userId, DailyView day) {
		db.sql("""
				insert into daily_answers (user_id, answered_on, question_id, choice_id,
				                           is_correct, answered_at)
				values (:userId, :on, null, null, :ok, :at)
				on conflict (user_id, answered_on) do update
				  set is_correct = excluded.is_correct, answered_at = excluded.answered_at
				""")
			.param("userId", userId)
			.param("on", java.sql.Date.valueOf(LocalDate.parse(day.date())))
			.param("ok", day.correct())
			.param("at", Timestamp.from(Instant.parse(day.at())))
			.update();
	}
}
