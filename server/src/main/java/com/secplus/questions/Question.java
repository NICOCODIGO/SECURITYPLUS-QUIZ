package com.secplus.questions;

import java.util.List;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.Table;

/**
 * One exam question.
 *
 * `objective` is the source of truth for which domain this question belongs
 * to. `filedDomain` records the quizData array it was imported from, which for
 * 147 of the 444 questions is a different domain — both are kept so per-domain
 * stats can describe content while the old filing stays visible. See
 * docs/database.md.
 *
 * `legacyHash` is the front end's djb2 hash of the question text. It exists so
 * imported localStorage history joins to the right row; it is never the
 * primary key, because the whole point of the uuid is that rewording a
 * question no longer retires its history.
 *
 * Note: `created_at` and `updated_at` are deliberately unmapped. Nothing reads
 * them yet, and Hibernate's `validate` only checks the columns that are mapped.
 */
@Entity
@Table(name = "questions")
public class Question {

	@Id
	@GeneratedValue
	private UUID id;

	@Column(name = "legacy_hash", nullable = false, updatable = false)
	private String legacyHash;

	@Column(nullable = false)
	private String text;

	@Column(nullable = false)
	private String difficulty;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "objective_code", nullable = false)
	private Objective objective;

	@Column(name = "filed_domain", nullable = false)
	private short filedDomain;

	@Column(nullable = false)
	private String explanation;

	@Column(nullable = false)
	private String status;

	@OneToMany(mappedBy = "question", fetch = FetchType.LAZY)
	@OrderBy("position")
	private List<Choice> choices;

	protected Question() {
		// for JPA
	}

	public UUID getId() {
		return id;
	}

	public String getLegacyHash() {
		return legacyHash;
	}

	public String getText() {
		return text;
	}

	public String getDifficulty() {
		return difficulty;
	}

	public Objective getObjective() {
		return objective;
	}

	public short getFiledDomain() {
		return filedDomain;
	}

	public String getExplanation() {
		return explanation;
	}

	public String getStatus() {
		return status;
	}

	public List<Choice> getChoices() {
		return choices;
	}
}
