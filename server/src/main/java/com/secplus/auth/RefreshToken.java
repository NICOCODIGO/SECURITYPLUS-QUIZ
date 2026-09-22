package com.secplus.auth;

import java.time.Instant;
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
 * One issued refresh token, stored as a hash.
 *
 * Only the SHA-256 of the token is kept, so a database leak hands out no live
 * sessions — the raw value exists once, in the Set-Cookie header.
 *
 * Tokens rotate on every use: refreshing revokes this row and inserts a new
 * one. A revoked row that is presented again means the value leaked (or a
 * client raced itself), which is why {@link RefreshTokenService} treats it as
 * theft and revokes the whole family rather than just refusing.
 */
@Entity
@Table(name = "refresh_tokens")
public class RefreshToken {

	@Id
	@GeneratedValue
	private UUID id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@Column(name = "token_hash", nullable = false, updatable = false)
	private String tokenHash;

	@Column(name = "expires_at", nullable = false)
	private Instant expiresAt;

	@Column(name = "revoked_at")
	private Instant revokedAt;

	@Column(name = "user_agent")
	private String userAgent;

	protected RefreshToken() {
		// for JPA
	}

	static RefreshToken issue(User user, String tokenHash, Instant expiresAt, String userAgent) {
		RefreshToken token = new RefreshToken();
		token.user = user;
		token.tokenHash = tokenHash;
		token.expiresAt = expiresAt;
		// Truncated because it is attacker-controlled and only ever read by a
		// human deciding whether a session looks like theirs.
		token.userAgent = userAgent == null ? null : userAgent.substring(0, Math.min(userAgent.length(), 255));
		return token;
	}

	public UUID getId() {
		return id;
	}

	public User getUser() {
		return user;
	}

	public Instant getExpiresAt() {
		return expiresAt;
	}

	public Instant getRevokedAt() {
		return revokedAt;
	}

	boolean isRevoked() {
		return revokedAt != null;
	}

	boolean isExpired(Instant now) {
		return expiresAt.isBefore(now);
	}

	void revoke(Instant at) {
		this.revokedAt = at;
	}
}
