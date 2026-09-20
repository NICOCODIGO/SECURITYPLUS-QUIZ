package com.secplus;

import java.util.List;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.core.simple.JdbcClient;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Integrity of the seeded question bank, asserted against the database rather
 * than against the JavaScript source.
 *
 * `npm run objectives` already checks the front end's copy. This is the same
 * guarantee one layer down: it catches a seed that generated but landed wrong —
 * a truncated file, a bad escape, a question whose choices did not all insert.
 * Those are exactly the failures a generator can produce silently.
 *
 * The counts are deliberately exact. If you add questions, these numbers change
 * and the test should be updated in the same commit — a drifting "at least N"
 * assertion would stop meaning anything.
 */
@Import(TestcontainersConfiguration.class)
@SpringBootTest
class ContentSeedTests {

	private static final int OBJECTIVES = 28;
	private static final int QUESTIONS = 444;
	private static final int CHOICES = 1776;
	private static final int WRONG_CHOICES = 1332;

	@Autowired
	private DataSource dataSource;

	private JdbcClient db() {
		return JdbcClient.create(dataSource);
	}

	private int count(String sql) {
		return db().sql(sql).query(Integer.class).single();
	}

	@Test
	void theBankSeededCompletely() {
		assertThat(count("select count(*) from objectives")).isEqualTo(OBJECTIVES);
		assertThat(count("select count(*) from questions where status = 'published'")).isEqualTo(QUESTIONS);
		assertThat(count("select count(*) from choices")).isEqualTo(CHOICES);
	}

	@Test
	void everyQuestionHasAnObjectiveInTheOfficialOutline() {
		// The FK guarantees the code exists; this catches the subtler case of a
		// question pointing at the fixture objective or some other stray row.
		List<String> orphans = db()
			.sql("""
					select q.legacy_hash from questions q
					left join objectives o on o.code = q.objective_code
					where o.code is null
					""")
			.query(String.class)
			.list();

		assertThat(orphans).isEmpty();
	}

	@Test
	void everyQuestionHasExactlyOneCorrectChoice() {
		// choices_one_correct_idx enforces "at most one". This is the other half.
		List<String> wrong = db()
			.sql("""
					select q.legacy_hash from questions q
					join choices c on c.question_id = q.id
					group by q.legacy_hash
					having count(*) filter (where c.is_correct) <> 1
					""")
			.query(String.class)
			.list();

		assertThat(wrong).isEmpty();
	}

	@Test
	void everyQuestionHasFourChoices() {
		assertThat(count("""
				select count(*) from (
				  select question_id from choices group by question_id having count(*) <> 4
				) bad
				"""))
			.isZero();
	}

	@Test
	void everyWrongChoiceExplainsItself() {
		// The whole point of the rationales files: a wrong answer says why it is
		// wrong. All 1,332 are covered today, and losing one is silent in the UI.
		assertThat(count("select count(*) from choices where not is_correct")).isEqualTo(WRONG_CHOICES);
		assertThat(count("select count(*) from choices where not is_correct and (rationale is null or rationale = '')"))
			.isZero();
	}

	@Test
	void theCorrectChoiceCarriesNoRationale() {
		// Why the right answer is right lives in questions.explanation.
		assertThat(count("select count(*) from choices where is_correct and rationale is not null")).isZero();
	}

	@Test
	void objectiveIsTheSourceOfTruth_andTheMisfilingIsStillRecorded() {
		// 147 of the 444 sit in a quizData array that disagrees with their
		// objective. Both are stored on purpose. This asserts the split is still
		// what the docs claim — if an import silently "fixed" filed_domain, the
		// per-domain numbers would change meaning without anyone noticing.
		int misfiled = count("""
				select count(*) from questions q
				join objectives o on o.code = q.objective_code
				where q.status = 'published' and o.domain_number <> q.filed_domain
				""");

		assertThat(misfiled).isEqualTo(147);
	}

	@Test
	void byObjectiveDomainFourIsNotAsThinAsItsFilingSuggests() {
		// Guards the correction in docs/content.md: filed = 36, by objective = 93.
		int filed = count("select count(*) from questions where status = 'published' and filed_domain = 4");
		int byObjective = count("""
				select count(*) from questions q
				join objectives o on o.code = q.objective_code
				where q.status = 'published' and o.domain_number = 4
				""");

		assertThat(filed).isEqualTo(36);
		assertThat(byObjective).isEqualTo(93);
	}
}
