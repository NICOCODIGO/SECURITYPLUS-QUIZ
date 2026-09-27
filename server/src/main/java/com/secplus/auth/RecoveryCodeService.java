package com.secplus.auth;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.HexFormat;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Ten single-use codes, shown once when 2FA is turned on.
 *
 * These are what stops a lost phone becoming a lost account. Without them the
 * only recovery path is a support request this project has nobody to answer,
 * so 2FA could not responsibly be required at all.
 *
 * **Hashed, never stored plainly.** Each code alone gets past the second step,
 * which makes them password-equivalent; a database leak that handed out live
 * recovery codes would undo 2FA for every account at once.
 *
 * SQL rather than an entity, matching UserTokenService: two columns and a
 * conditional update is not an object graph.
 */
@Service
public class RecoveryCodeService {

	/** Enough to survive a few panics without being a list nobody will store. */
	static final int CODE_COUNT = 10;

	/**
	 * 40 bits per code, rendered as ten Crockford-ish characters in two groups.
	 *
	 * Far beyond guessing, which matters because — unlike the six-digit
	 * codes — these do not expire. They are shown once, so they also have to be
	 * transcribable: no look-alike characters, and a dash in the middle so a
	 * handwritten copy can be read back.
	 */
	private static final String ALPHABET = "ABCDEFGHJKMNPQRSTVWXYZ23456789";

	private static final int GROUP = 5;

	private final JdbcClient db;

	private final SecureRandom random = new SecureRandom();

	RecoveryCodeService(DataSource dataSource) {
		this.db = JdbcClient.create(dataSource);
	}

	/**
	 * Replaces every existing code with a fresh set, returned in the clear this
	 * once.
	 *
	 * Replacing rather than appending is the point: regenerating after a
	 * suspected leak has to invalidate the old list, or it achieves nothing.
	 */
	@Transactional
	List<String> regenerate(UUID userId) {
		db.sql("delete from recovery_codes where user_id = :userId").param("userId", userId).update();

		List<String> codes = new ArrayList<>(CODE_COUNT);
		for (int i = 0; i < CODE_COUNT; i++) {
			String code = generate();
			codes.add(code);
			db.sql("""
					insert into recovery_codes (user_id, code_hash)
					values (:userId, :hash)
					on conflict do nothing
					""")
				.param("userId", userId)
				.param("hash", hash(code))
				.update();
		}
		return codes;
	}

	/**
	 * Spends one code, if it is theirs and unused.
	 *
	 * The `where` does the checking so two simultaneous uses cannot both
	 * succeed — the same reasoning as redeeming a token. Scoped by user id as
	 * well as hash, so one account can never spend another's code.
	 */
	@Transactional
	boolean redeem(UUID userId, String code, Instant now) {
		if (code == null || code.isBlank()) {
			return false;
		}

		return db.sql("""
				update recovery_codes
				   set used_at = :now
				 where user_id   = :userId
				   and code_hash = :hash
				   and used_at is null
				""")
			.param("userId", userId)
			.param("hash", hash(code))
			.param("now", Timestamp.from(now))
			.update() == 1;
	}

	/** Shown on the account page, so someone can tell they are running low. */
	@Transactional(readOnly = true)
	int remaining(UUID userId) {
		return db.sql("select count(*) from recovery_codes where user_id = :userId and used_at is null")
			.param("userId", userId)
			.query(Integer.class)
			.single();
	}

	@Transactional
	void clear(UUID userId) {
		db.sql("delete from recovery_codes where user_id = :userId").param("userId", userId).update();
	}

	private String generate() {
		StringBuilder code = new StringBuilder(GROUP * 2 + 1);
		for (int i = 0; i < GROUP * 2; i++) {
			if (i == GROUP) {
				code.append('-');
			}
			code.append(ALPHABET.charAt(random.nextInt(ALPHABET.length())));
		}
		return code.toString();
	}

	/**
	 * People retype these from paper, so case and the dash are not their
	 * problem. Normalising before hashing means "abcde fghjk" matches the code
	 * that was issued as "ABCDE-FGHJK".
	 */
	private static String normalise(String code) {
		return code.toUpperCase().replaceAll("[^A-Z0-9]", "");
	}

	/**
	 * SHA-256, not BCrypt, for the same reason as link tokens: 40 bits of
	 * CSPRNG output has nothing to brute-force, and the lookup has to be one
	 * indexed equality test. The dash is stripped first so the stored hash is
	 * of the canonical form.
	 */
	private static String hash(String code) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			return HexFormat.of().formatHex(digest.digest(normalise(code).getBytes(StandardCharsets.UTF_8)));
		}
		catch (NoSuchAlgorithmException e) {
			throw new IllegalStateException("SHA-256 is required by every JVM", e);
		}
	}

}
