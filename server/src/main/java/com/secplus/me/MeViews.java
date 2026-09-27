package com.secplus.me;

import java.util.List;
import java.util.UUID;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;

/**
 * One account's own study data, in and out.
 *
 * `AttemptView` is deliberately the same shape the browser already stores under
 * `quiz_history`, so every selector in `quizHistoryData.js` keeps working with
 * no translation and the progress analytics are never reimplemented here. See
 * docs/backend.md, "The one contract that must not drift".
 *
 * The one place it differs: `DomainSlice.filedDomain` is a **number**, not the
 * quizData label string the browser stores. Domain titles, weights and colours
 * live in `securityDomains.js` and QuestionViews says keeping them there is
 * deliberate — duplicating them server-side is how the two start disagreeing.
 * The client maps number to label on the way in, exactly as `toQuizDataShape`
 * adapts questions in `questionBank.js`.
 */
public final class MeViews {

	/**
	 * Answers per attempt. Above the whole bank (444), so no real quiz - a
	 * domain quiz can be every question in its domain - ever comes near it.
	 * Every answer is its own insert, so without a cap one request could make
	 * the server do unbounded work.
	 */
	static final int MAX_ANSWERS = 500;

	/** Flags are a set of question hashes; more than the bank holds is not a real set. */
	static final int MAX_FLAGS = 1_000;

	/** Daily answers sent in one request, e.g. a first sync. Years of daily use. */
	static final int MAX_DAILY = 2_000;

	/** djb2 in base 36 is a handful of characters; this is room, not a format check. */
	static final int MAX_HASH = 64;

	private MeViews() {
	}

	/**
	 * One answered question. `ok` is all the browser records — which option was
	 * chosen is never captured, so `attempt_answers.chosen_choice_id` stays
	 * null on everything that arrives through here.
	 */
	public record AnswerView(@NotBlank @Size(max = MAX_HASH) String id, boolean ok) {
	}

	/**
	 * Per-domain totals, grouped by the question's **filed** domain rather than
	 * its objective.
	 *
	 * Those two disagree for 147 of the 444 questions. Grouping by objective
	 * would be defensible on its own terms, but it would silently change the
	 * per-domain accuracy every existing user already saw for quizzes they have
	 * taken. Matching what the browser computed is the property worth keeping.
	 */
	public record DomainSlice(int filedDomain, int percentage, int correct, int total) {
	}

	public record AttemptView(UUID id, String date, String type, int score, int questionsCount,
			Integer durationSeconds, String domainTitle, List<DomainSlice> domainBreakdown,
			List<AnswerView> answers) {
	}

	/**
	 * What the browser sends up, which is **not** what it gets back.
	 *
	 * No `domainBreakdown`: the server derives that from `attempt_answers` and
	 * ignores anything supplied, so accepting it invites exactly the bug this
	 * record exists to prevent. The browser's own breakdown is keyed by a domain
	 * *label* while DomainSlice is keyed by a *number*, so binding it into the
	 * response record failed outright and every real quiz submission 400'd —
	 * while a test sending an empty array passed.
	 *
	 * A separate record rather than a nullable field on AttemptView, for the
	 * reason QuestionViews gives: the split should be impossible to get wrong by
	 * accident, not merely documented.
	 */
	/*
	 * The constraints mirror V1's check constraints (type, score, count), so a
	 * bad value is a 400 naming the field rather than a 500 from the database.
	 */
	public record AttemptUpload(
			@NotNull UUID id,
			@NotBlank @Size(max = 40) String date,
			@NotNull @Pattern(regexp = "domain|mock|weakest|custom") String type,
			@Min(0) @Max(100) int score,
			@Min(1) @Max(MAX_ANSWERS) int questionsCount,
			@PositiveOrZero Integer durationSeconds,
			@Size(max = 200) String domainTitle,
			@NotNull @Size(max = MAX_ANSWERS) List<@Valid @NotNull AnswerView> answers) {
	}

	/** One Question-of-the-Day answer, keyed by the local date it was shown. */
	public record DailyView(
			@NotNull @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2}") String date,
			boolean correct,
			@NotBlank @Size(max = 40) String at) {
	}
}
