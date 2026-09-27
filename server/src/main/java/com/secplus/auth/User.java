package com.secplus.auth;

import java.time.Instant;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
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

	/**
	 * Whether the address has been proved reachable.
	 *
	 * This gates password RESET and nothing else. It must never gate studying:
	 * every quiz works signed out, so gating it signed in would be a strict
	 * downgrade for having made an account.
	 */
	@Column(name = "email_verified", nullable = false)
	private boolean emailVerified;

	/** Null means 2FA is off. */
	@Column(name = "two_factor_method")
	@Convert(converter = TwoFactorMethod.Mapping.class)
	private TwoFactorMethod twoFactorMethod;

	@Column(name = "totp_secret")
	private String totpSecret;

	/** The last TOTP step spent, so a code works once. See V3. */
	@Column(name = "totp_last_step")
	private Long totpLastStep;

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

	public boolean isEmailVerified() {
		return emailVerified;
	}

	public void markEmailVerified() {
		this.emailVerified = true;
	}

	public TwoFactorMethod getTwoFactorMethod() {
		return twoFactorMethod;
	}

	public boolean isTwoFactorEnabled() {
		return twoFactorMethod != null;
	}

	String getTotpSecret() {
		return totpSecret;
	}

	/**
	 * Turning 2FA on. The secret is required for TOTP and forbidden otherwise:
	 * V2 enforces the first half as a check constraint, because a TOTP account
	 * with no secret would demand a code nobody can generate - a permanent
	 * lockout with no way back in.
	 */
	void enableTwoFactor(TwoFactorMethod method, String secret) {
		if (method == TwoFactorMethod.TOTP && (secret == null || secret.isBlank())) {
			throw new IllegalArgumentException("TOTP requires a secret");
		}
		this.twoFactorMethod = method;
		this.totpSecret = (method == TwoFactorMethod.TOTP) ? secret : null;
		this.totpLastStep = null;
	}

	/**
	 * Spends a TOTP time-step, refusing one already spent.
	 *
	 * A code stays valid for about 90 seconds, so without this the same six
	 * digits work again for the rest of that window - after their owner has
	 * used them, for anyone who saw or phished them. Steps only move forward,
	 * so "at or below the last one" is the whole test.
	 */
	boolean spendTotpStep(long step) {
		if (totpLastStep != null && step <= totpLastStep) {
			return false;
		}
		this.totpLastStep = step;
		return true;
	}

	/**
	 * Stages a TOTP secret while setup is still unconfirmed.
	 *
	 * The method stays null, so 2FA remains OFF until a working code proves the
	 * authenticator was actually set up. V2 permits exactly this state - its
	 * constraint forbids a method of 'totp' without a secret, not the reverse.
	 */
	void stageTotpSecret(String secret) {
		this.totpSecret = secret;
		this.totpLastStep = null;
	}

	public void changePassword(String newPasswordHash) {
		this.passwordHash = newPasswordHash;
	}

	/** Clears the secret too: keeping one after 2FA is off is a liability with no use. */
	void disableTwoFactor() {
		this.twoFactorMethod = null;
		this.totpSecret = null;
		this.totpLastStep = null;
	}
}
