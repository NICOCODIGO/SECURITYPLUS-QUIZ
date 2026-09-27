package com.secplus.auth;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.Duration;
import java.time.Instant;
import java.util.Base64;
import java.util.HexFormat;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Single-use, expiring tokens: verification links, password-reset links and
 * emailed sign-in codes.
 *
 * All three are the same shape — issue a secret, mail it, redeem it once — and
 * differ only in what redeeming does, so they share one table separated by
 * `purpose`. The constraint is what stops a reset token being spent on
 * verification.
 *
 * **Only hashes are stored.** The raw value exists in the email and nowhere
 * else, exactly as refresh tokens work, so a database leak hands out no live
 * links and no working codes.
 *
 * SQL rather than JPA for the same reason as MeStore: this is upserts and
 * conditional updates, not an entity graph.
 */
@Service
public class UserTokenService {

	/** Long enough to click at leisure; short enough that a leaked mailbox ages out. */
	static final Duration VERIFY_TTL = Duration.ofHours(24);

	/** Short, because a reset link is the one thing that can take an account over. */
	static final Duration RESET_TTL = Duration.ofHours(1);

	/** Six digits is guessable, so the window is small and the rate limit tight. */
	static final Duration LOGIN_CODE_TTL = Duration.ofMinutes(10);

	static final String VERIFY = "verify_email";

	static final String RESET = "reset_password";

	static final String LOGIN_CODE = "login_code";

	/** Proof that the password step succeeded, exchanged for a session with a code. */
	static final String LOGIN_CHALLENGE = "login_challenge";

	/** Only as long as it takes to fetch a code out of an inbox. */
	static final Duration CHALLENGE_TTL = Duration.ofMinutes(15);

	private final JdbcClient db;

	private final SecureRandom random = new SecureRandom();

	UserTokenService(DataSource dataSource) {
		this.db = JdbcClient.create(dataSource);
	}

	/** The raw value, returned once so it can be emailed and never stored. */
	record Issued(String value, Instant expiresAt) {
	}

	/**
	 * A link token: 32 bytes of CSPRNG output, URL-safe.
	 *
	 * Any outstanding token of the same purpose is spent first, so asking for a
	 * second reset email invalidates the first. Otherwise every request would
	 * leave another live way into the account.
	 */
	@Transactional
	Issued issueLink(UUID userId, String purpose, Duration ttl, Instant now) {
		invalidate(userId, purpose, now);

		byte[] raw = new byte[32];
		random.nextBytes(raw);
		String value = Base64.getUrlEncoder().withoutPadding().encodeToString(raw);
		store(userId, value, purpose, now.plus(ttl));
		return new Issued(value, now.plus(ttl));
	}

	/**
	 * A six-digit sign-in code.
	 *
	 * Short because people retype it from their inbox, which is also why it
	 * cannot be the only thing protecting the account — it is a second factor
	 * behind a password, never a password substitute.
	 *
	 * `SecureRandom.nextInt(bound)` rather than `% 1000000`, which would skew
	 * the distribution towards low values.
	 */
	@Transactional
	Issued issueLoginCode(UUID userId, Instant now) {
		invalidate(userId, LOGIN_CODE, now);

		String code = String.format("%06d", random.nextInt(1_000_000));
		Instant expiresAt = now.plus(LOGIN_CODE_TTL);
		// Scoped to the user, not stored bare. A six-digit code has only a
		// million values, so two people can hold the same one at once - and
		// `token_hash` is unique, so the second insert would fail. Worse, a
		// lookup by the bare hash would let one account spend another's code.
		store(userId, scoped(userId, code), LOGIN_CODE, expiresAt);
		return new Issued(code, expiresAt);
	}

	/** Redeems a code for one specific user. See issueLoginCode for why scoped. */
	@Transactional
	boolean redeemLoginCode(UUID userId, String code, Instant now) {
		return redeem(scoped(userId, code), LOGIN_CODE, now).isPresent();
	}

	private static String scoped(UUID userId, String code) {
		return userId + ":" + code;
	}

	private void store(UUID userId, String value, String purpose, Instant expiresAt) {
		db.sql("""
				insert into user_tokens (user_id, token_hash, purpose, expires_at)
				values (:userId, :hash, :purpose, :expiresAt)
				""")
			.param("userId", userId)
			.param("hash", hash(value))
			.param("purpose", purpose)
			.param("expiresAt", java.sql.Timestamp.from(expiresAt))
			.update();
	}

	/**
	 * Spends a token, returning whose it was.
	 *
	 * The update itself does the checking — unused, unexpired and of the right
	 * purpose are all in the `where`, so two simultaneous redemptions cannot
	 * both succeed. Checking first and updating after would leave that race
	 * open.
	 */
	@Transactional
	Optional<UUID> redeem(String value, String purpose, Instant now) {
		List<UUID> ids = db.sql("""
				update user_tokens
				   set used_at = :now
				 where token_hash = :hash
				   and purpose    = :purpose
				   and used_at is null
				   and expires_at > :now
				returning user_id
				""")
			.param("hash", hash(value))
			.param("purpose", purpose)
			.param("now", java.sql.Timestamp.from(now))
			.query(UUID.class)
			.list();

		return ids.stream().findFirst();
	}

	/**
	 * Who a token belongs to, WITHOUT spending it.
	 *
	 * This exists for the login challenge. Redeeming on sight would mean a
	 * single mistyped digit burned the challenge and sent the person back to
	 * the password screen - so the challenge is resolved to find the account,
	 * the code is checked, and only a correct code spends it.
	 *
	 * Same expiry and single-use conditions as redeem, so a spent or stale
	 * challenge resolves to nothing rather than to an account.
	 */
	@Transactional(readOnly = true)
	Optional<UUID> resolve(String value, String purpose, Instant now) {
		if (value == null || value.isBlank()) {
			return Optional.empty();
		}

		return db.sql("""
				select user_id
				  from user_tokens
				 where token_hash = :hash
				   and purpose    = :purpose
				   and used_at is null
				   and expires_at > :now
				""")
			.param("hash", hash(value))
			.param("purpose", purpose)
			.param("now", java.sql.Timestamp.from(now))
			.query(UUID.class)
			.optional();
	}

	/** Used when a password changes: every outstanding reset link dies with it. */
	@Transactional
	void invalidate(UUID userId, String purpose, Instant now) {
		db.sql("""
				update user_tokens set used_at = :now
				 where user_id = :userId and purpose = :purpose and used_at is null
				""")
			.param("userId", userId)
			.param("purpose", purpose)
			.param("now", java.sql.Timestamp.from(now))
			.update();
	}

	/** Spent and expired rows accumulate; nothing reads them after their TTL. */
	@Transactional
	int purgeExpiredBefore(Instant before) {
		return db.sql("delete from user_tokens where expires_at < :before")
			.param("before", java.sql.Timestamp.from(before))
			.update();
	}

	/**
	 * SHA-256, not BCrypt. Link tokens are 256 bits of CSPRNG output, so there
	 * is nothing to brute-force and the lookup must be a single indexed
	 * equality test.
	 *
	 * Six-digit codes are different — they *are* guessable — but their defence
	 * is the ten-minute window and the rate limiter, not the hash. Hashing them
	 * only keeps live codes out of a database dump.
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
