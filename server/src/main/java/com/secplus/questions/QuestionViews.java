package com.secplus.questions;

import java.util.List;
import java.util.UUID;

/**
 * What the API sends back.
 *
 * Separate records rather than serialising the entities, so a lazy association
 * can never be walked during serialisation and a schema column can never leak
 * into the payload by accident.
 *
 * **These views include the answer key** (`correct` and `rationale`), because
 * they serve *practice* quizzes, which reveal whether you were right the
 * instant you answer. A keyless variant for mock exams arrives in phase 4 —
 * see docs/backend.md. Keep the split explicit: don't add a boolean flag to
 * these records that strips the key, add a separate record, so leaking it
 * requires actively choosing the wrong type.
 */
public final class QuestionViews {

	private QuestionViews() {
	}

	public record ChoiceView(int position, String text, boolean correct, String rationale) {

		static ChoiceView of(Choice choice) {
			return new ChoiceView(choice.getPosition(), choice.getText(), choice.isCorrect(),
					choice.getRationale());
		}
	}

	public record QuestionView(UUID id, String legacyHash, String text, String difficulty, String objective,
			int domain, int filedDomain, String explanation, List<ChoiceView> choices) {

		static QuestionView of(Question question) {
			return new QuestionView(question.getId(), question.getLegacyHash(), question.getText(),
					question.getDifficulty(), question.getObjective().getCode(),
					question.getObjective().getDomainNumber(), question.getFiledDomain(),
					question.getExplanation(), question.getChoices().stream().map(ChoiceView::of).toList());
		}
	}

	/** One objective, with how many published questions currently test it. */
	public record ObjectiveView(String code, int domain, String title, long questionCount) {
	}

	/**
	 * Per-domain counts. `questionCount` is by **objective** — the source of
	 * truth — while `filedQuestionCount` is the legacy quizData filing. They
	 * differ for 147 of the 444 questions, which is why both are exposed rather
	 * than silently picking one.
	 *
	 * Domain titles, weights and colours are not here on purpose: the front end
	 * owns that metadata in securityDomains.js, and duplicating it server-side
	 * is how the two start disagreeing.
	 */
	public record DomainView(int domain, long questionCount, long filedQuestionCount) {
	}
}
