package com.secplus.questions;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * One SY0-701 exam objective, e.g. 4.6 "Implement and maintain identity and
 * access management".
 *
 * Seeded from the front end's examObjectives.js by R__seed_content.sql. The
 * code is the natural primary key — it is stable, published by CompTIA, and
 * what every question points at.
 */
@Entity
@Table(name = "objectives")
public class Objective {

	@Id
	private String code;

	@Column(name = "domain_number", nullable = false)
	private short domainNumber;

	@Column(nullable = false)
	private String title;

	protected Objective() {
		// for JPA
	}

	public String getCode() {
		return code;
	}

	public short getDomainNumber() {
		return domainNumber;
	}

	public String getTitle() {
		return title;
	}
}
