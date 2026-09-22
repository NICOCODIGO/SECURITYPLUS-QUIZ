package com.secplus.auth;

import java.time.Instant;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * One account.
 *
 * An account exists to keep one person's own study data safe, never to compare
 * them to anyone. Nothing here is public: `displayName` is only ever shown back
 * to its owner.
 *
 * Note: `email` carries no `unique = true`. Uniqueness is case-insensitive and
 * enforced by the `users_email_lower_idx` functional index in V1__init.sql —
 * declaring it here would describe a plain unique constraint that does not
 * exist, and invite someone to "fix" the mismatch with a migration.
 *
 * `created_at` is deliberately unmapped, as on Question: nothing reads it yet,
 * and Hibernate's `validate` only checks mapped columns.
 */
@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue
	private UUID id;

	@Column(nullable = false)
	private String email;

	@Column(name = "password_hash", nullable = false)
	private String passwordHash;

	@Column(name = "display_name")
	private String displayName;

	@Column(nullable = false)
	private String role;

	@Column(name = "last_login_at")
	private Instant lastLoginAt;

	protected User() {
		// for JPA
	}

	/** Emails are stored lowercased so the functional index and equality agree. */
	public static User create(String email, String passwordHash, String displayName) {
		User user = new User();
		user.email = email.toLowerCase();
		user.passwordHash = passwordHash;
		user.displayName = displayName;
		user.role = "USER";
		return user;
	}

	public UUID getId() {
		return id;
	}

	public String getEmail() {
		return email;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public String getDisplayName() {
		return displayName;
	}

	public String getRole() {
		return role;
	}

	public Instant getLastLoginAt() {
		return lastLoginAt;
	}

	public void recordLogin(Instant at) {
		this.lastLoginAt = at;
	}
}
