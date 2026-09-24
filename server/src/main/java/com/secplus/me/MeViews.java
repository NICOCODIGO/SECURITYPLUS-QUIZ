package com.secplus.me;

import java.util.List;
import java.util.UUID;

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

	private MeViews() {
	}

	/**
	 * One answered question. `ok` is all the browser records — which option was
	 * chosen is never captured, so `attempt_answers.chosen_choice_id` stays
	 * null on everything that arrives through here.
	 */
	public record AnswerView(String id, boolean ok) {
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

	/** One Question-of-the-Day answer, keyed by the local date it was shown. */
	public record DailyView(String date, boolean correct, String at) {
	}
}
