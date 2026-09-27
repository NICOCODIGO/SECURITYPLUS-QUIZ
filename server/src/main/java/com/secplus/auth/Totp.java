package com.secplus.auth;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.Instant;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 * RFC 6238 time-based one-time passwords, on the JDK alone.
 *
 * **Why hand-written rather than a library.** The algorithm is an HMAC, a
 * truncation and a modulo — the whole of it is below. A TOTP dependency would
 * be one the Boot BOM does not manage, so its version would be ours to track
 * forever, which is the same reasoning that kept jjwt out in favour of the
 * BOM's resource-server starter. See docs/decisions.md.
 *
 * SHA-1, six digits and a thirty-second step are not choices: they are what
 * every authenticator app assumes when the `otpauth://` URI omits them, and a
 * code that Google Authenticator rejects is worthless however modern its hash.
 */
final class Totp {

	private static final int DIGITS = 6;

	private static final int STEP_SECONDS = 30;

	/** 160 bits, matching the SHA-1 block the algorithm keys. */
	private static final int SECRET_BYTES = 20;

	/**
	 * How many steps either side of now are accepted.
	 *
	 * One step, so a code stays valid for at most ~90 seconds. Phone clocks
	 * drift and people type slowly; zero tolerance produces support requests
	 * nobody can answer. Widening it lengthens the window in which a code
	 * observed over someone's shoulder still works, so it stays at one.
	 */
	private static final int SKEW_STEPS = 1;

	private static final SecureRandom RANDOM = new SecureRandom();

	private Totp() {
	}

	static String newSecret() {
		byte[] bytes = new byte[SECRET_BYTES];
		RANDOM.nextBytes(bytes);
		return Base32.encode(bytes);
	}

	/**
	 * The URI an authenticator app reads from the QR code.
	 *
	 * The issuer appears both as a label prefix and as a parameter, which is
	 * redundant but is what the de-facto spec asks for: older apps read one,
	 * newer ones the other.
	 */
	static String provisioningUri(String secret, String email, String issuer) {
		String label = encode(issuer) + ":" + encode(email);
		return "otpauth://totp/" + label
				+ "?secret=" + secret
				+ "&issuer=" + encode(issuer)
				+ "&algorithm=SHA1&digits=" + DIGITS + "&period=" + STEP_SECONDS;
	}

	private static String encode(String value) {
		return URLEncoder.encode(value, StandardCharsets.UTF_8).replace("+", "%20");
	}

	/** True when `code` is valid for `secret` at `now`, allowing for clock skew. */
	static boolean verify(String secret, String code, Instant now) {
		return matchingStep(secret, code, now) != NO_MATCH;
	}

	static final long NO_MATCH = -1;

	/**
	 * The time-step `code` belongs to, or NO_MATCH.
	 *
	 * Callers that sign someone in use this rather than verify(), and spend the
	 * step on the account (User.spendTotpStep) so each code works exactly once.
	 */
	static long matchingStep(String secret, String code, Instant now) {
		if (secret == null || code == null) {
			return NO_MATCH;
		}
		String cleaned = code.trim().replace(" ", "");
		if (cleaned.length() != DIGITS) {
			return NO_MATCH;
		}

		byte[] key;
		try {
			key = Base32.decode(secret);
		} catch (IllegalArgumentException e) {
			return NO_MATCH;
		}

		long step = now.getEpochSecond() / STEP_SECONDS;
		for (long candidate = step - SKEW_STEPS; candidate <= step + SKEW_STEPS; candidate++) {
			if (constantTimeEquals(generate(key, candidate), cleaned)) {
				return candidate;
			}
		}
		return NO_MATCH;
	}

	/** Exposed for tests, which need to produce a code the way an app would. */
	static String codeAt(String secret, Instant at) {
		return generate(Base32.decode(secret), at.getEpochSecond() / STEP_SECONDS);
	}

	private static String generate(byte[] key, long step) {
		byte[] counter = new byte[8];
		for (int i = 7; i >= 0; i--) {
			counter[i] = (byte) (step & 0xff);
			step >>= 8;
		}

		byte[] hash;
		try {
			Mac mac = Mac.getInstance("HmacSHA1");
			mac.init(new SecretKeySpec(key, "HmacSHA1"));
			hash = mac.doFinal(counter);
		} catch (NoSuchAlgorithmException | InvalidKeyException e) {
			throw new IllegalStateException("HmacSHA1 is required by every JVM", e);
		}

		// Dynamic truncation, RFC 4226 section 5.3: the low nibble of the last
		// byte picks where in the hash to read the code from, so no fixed slice
		// of the HMAC is ever exposed.
		int offset = hash[hash.length - 1] & 0x0f;
		int binary = ((hash[offset] & 0x7f) << 24)
				| ((hash[offset + 1] & 0xff) << 16)
				| ((hash[offset + 2] & 0xff) << 8)
				| (hash[offset + 3] & 0xff);

		return String.format("%0" + DIGITS + "d", binary % (int) Math.pow(10, DIGITS));
	}

	/**
	 * Comparison that does not return early on the first wrong digit.
	 *
	 * A code is a short-lived shared secret, and `equals` leaks through timing
	 * how much of a guess was right. The window is small and the attack is
	 * impractical over a network — but this costs one line.
	 */
	private static boolean constantTimeEquals(String a, String b) {
		if (a.length() != b.length()) {
			return false;
		}
		int difference = 0;
		for (int i = 0; i < a.length(); i++) {
			difference |= a.charAt(i) ^ b.charAt(i);
		}
		return difference == 0;
	}
}
