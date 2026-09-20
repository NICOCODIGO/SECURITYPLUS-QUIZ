package com.secplus.questions;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

/**
 * One answer option.
 *
 * `rationale` explains why this **wrong** choice is wrong, and is null on the
 * correct choice — why the right answer is right lives on
 * {@link Question#getExplanation()} instead. All 1,332 wrong choices carry one;
 * ContentSeedTests enforces that.
 *
 * The database guarantees at most one correct choice per question
 * (`choices_one_correct_idx`). "At least one" cannot be an index, so the seed
 * generator and ContentSeedTests assert that half.
 */
@Entity
@Table(name = "choices")
public class Choice {

	@Id
	@GeneratedValue
	private UUID id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "question_id", nullable = false)
	private Question question;

	/** 0-based, and the order they are shown in. */
	@Column(nullable = false)
	private short position;

	@Column(nullable = false)
	private String text;

	@Column(name = "is_correct", nullable = false)
	private boolean correct;

	private String rationale;

	protected Choice() {
		// for JPA
	}

	public UUID getId() {
		return id;
	}

	public short getPosition() {
		return position;
	}

	public String getText() {
		return text;
	}

	public boolean isCorrect() {
		return correct;
	}

	public String getRationale() {
		return rationale;
	}
}
