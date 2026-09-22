package com.secplus.auth;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Base64;
import java.util.HexFormat;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.secplus.common.AuthException;

/** Issues, rotates and revokes refresh tokens. */
@Service
public class RefreshTokenService {

	private static final Logger log = LoggerFactory.getLogger(RefreshTokenService.class);

	private static final int TOKEN_BYTES = 32;

	private final RefreshTokenRepository tokens;

	private final TokenFamilyRevoker familyRevoker;

	private final AuthProperties properties;

	private final SecureRandom random = new SecureRandom();

	RefreshTokenService(RefreshTokenRepository tokens, TokenFamilyRevoker familyRevoker,
			AuthProperties properties) {
		this.tokens = tokens;
		this.familyRevoker = familyRevoker;
		this.properties = properties;
	}

	/** The raw value exists here and in the Set-Cookie header. Never in the database. */
	record Issued(String value, Instant expiresAt) {
	}

	@Transactional
	Issued issue(User user, Instant now, String userAgent) {
		byte[] raw = new byte[TOKEN_BYTES];
		random.nextBytes(raw);
		String value = Base64.getUrlEncoder().withoutPadding().encodeToString(raw);
		Instant expiresAt = now.plus(properties.getRefreshTokenTtl());

		tokens.save(RefreshToken.issue(user, hash(value), expiresAt, userAgent));
		return new Issued(value, expiresAt);
	}

	/**
	 * Validate, revoke, re-issue — all in one transaction, so a token can never
	 * be spent twice.
	 *
	 * A token that is already revoked but not yet expired means the value
	 * leaked, or a client fired two refreshes at once. Either way the safe
	 * reading is theft, so the whole family is revoked and every session for
	 * that account ends. The client is responsible for never racing itself; see
	 * the single-flight refresh in the front end's apiClient.
	 *
	 * The revocation goes through TokenFamilyRevoker rather than the repository
	 * directly, so it commits in its own transaction and survives the exception
	 * that follows it. See that class — the reason is not obvious and the bug
	 * it prevents is silent.
	 */
	@Transactional
	Rotation rotate(String presented, Instant now, String userAgent) {
		RefreshToken existing = tokens.findByTokenHash(hash(presented))
			.orElseThrow(() -> new AuthException(HttpStatus.UNAUTHORIZED, "Your session has expired. Sign in again."));

		if (existing.isRevoked()) {
			int revoked = familyRevoker.revokeAll(existing.getUser().getId(), now);
			log.warn("Refresh token reuse detected for user {} — revoked {} live token(s).",
					existing.getUser().getId(), revoked);
			throw new AuthException(HttpStatus.UNAUTHORIZED, "Your session has expired. Sign in again.");
		}

		if (existing.isExpired(now)) {
			throw new AuthException(HttpStatus.UNAUTHORIZED, "Your session has expired. Sign in again.");
		}

		existing.revoke(now);
		User user = existing.getUser();
		return new Rotation(user, issue(user, now, userAgent));
	}

	record Rotation(User user, Issued token) {
	}

	@Transactional
	void revoke(String presented, Instant now) {
		Optional<RefreshToken> existing = tokens.findByTokenHash(hash(presented));
		existing.filter(token -> !token.isRevoked()).ifPresent(token -> token.revoke(now));
	}

	@Transactional
	int purgeExpiredBefore(Instant before) {
		return tokens.deleteExpiredBefore(before);
	}

	/**
	 * SHA-256, not BCrypt: the value is 256 bits of CSPRNG output, so there is
	 * nothing to brute-force and a lookup has to be a single indexed equality
	 * test rather than a scan over every row.
	 */
	private static String hash(String value) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			return HexFormat.of().formatHex(digest.digest(value.getBytes(StandardCharsets.UTF_8)));
		} catch (NoSuchAlgorithmException e) {
			throw new IllegalStateException("SHA-256 is required by every JVM", e);
		}
	}
}
