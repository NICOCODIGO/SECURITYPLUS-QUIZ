package com.secplus.auth;

import java.time.Instant;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * Needs no Docker, so the 2FA maths stays covered when the daemon is down.
 *
 * The first test is the one that matters. Generating a code and then verifying
 * it with the same code proves only that the implementation agrees with itself
 * — it would pass just as happily if the algorithm were wrong in a way that
 * cancelled out. The RFC 6238 published vectors are an outside answer, and they
 * are what actually proves a real authenticator app will work.
 */
class TotpTests {

	/** RFC 6238 appendix B: the SHA-1 test key is "12345678901234567890" ASCII. */
	private static final String RFC_SECRET = Base32.encode("12345678901234567890".getBytes());

	@Test
	void matchesTheRfc6238PublishedVectors() {
		// Each pair is a timestamp and the eight-digit code the RFC lists. Our
		// codes are six digits, which is the last six of theirs.
		assertThat(Totp.codeAt(RFC_SECRET, Instant.ofEpochSecond(59L))).isEqualTo("287082");
		assertThat(Totp.codeAt(RFC_SECRET, Instant.ofEpochSecond(1111111109L))).isEqualTo("081804");
		assertThat(Totp.codeAt(RFC_SECRET, Instant.ofEpochSecond(1111111111L))).isEqualTo("050471");
		assertThat(Totp.codeAt(RFC_SECRET, Instant.ofEpochSecond(1234567890L))).isEqualTo("005924");
		assertThat(Totp.codeAt(RFC_SECRET, Instant.ofEpochSecond(2000000000L))).isEqualTo("279037");
	}

	@Test
	void acceptsTheCurrentCode() {
		String secret = Totp.newSecret();
		Instant now = Instant.parse("2026-09-25T10:00:00Z");

		assertThat(Totp.verify(secret, Totp.codeAt(secret, now), now)).isTrue();
	}

	@Test
	void toleratesOneStepOfClockDriftButNotTwo() {
		String secret = Totp.newSecret();
		Instant now = Instant.parse("2026-09-25T10:00:00Z");

		// Phones drift and people type slowly, so the previous code still works.
		assertThat(Totp.verify(secret, Totp.codeAt(secret, now.minusSeconds(30)), now)).isTrue();
		assertThat(Totp.verify(secret, Totp.codeAt(secret, now.plusSeconds(30)), now)).isTrue();

		// Two steps is 90 seconds of validity, which widens the window in which
		// a code read over someone's shoulder still works.
		assertThat(Totp.verify(secret, Totp.codeAt(secret, now.minusSeconds(90)), now)).isFalse();
		assertThat(Totp.verify(secret, Totp.codeAt(secret, now.plusSeconds(90)), now)).isFalse();
	}

	@Test
	void rejectsRubbishWithoutThrowing() {
		String secret = Totp.newSecret();
		Instant now = Instant.now();

		// A wrong code is an ordinary event on a login form, not an exception.
		assertThat(Totp.verify(secret, "000000", now.plusSeconds(3600))).isFalse();
		assertThat(Totp.verify(secret, "12345", now)).isFalse();
		assertThat(Totp.verify(secret, "abcdef", now)).isFalse();
		assertThat(Totp.verify(secret, null, now)).isFalse();
		assertThat(Totp.verify(null, "123456", now)).isFalse();
		// A corrupt stored secret must fail closed, not blow up the request.
		assertThat(Totp.verify("not-base32!", "123456", now)).isFalse();
	}

	@Test
	void ignoresTheSpacesAuthenticatorAppsShow() {
		String secret = Totp.newSecret();
		Instant now = Instant.parse("2026-09-25T10:00:00Z");
		String code = Totp.codeAt(secret, now);

		// Apps display "123 456", and people paste what they see.
		String spaced = code.substring(0, 3) + " " + code.substring(3);
		assertThat(Totp.verify(secret, spaced, now)).isTrue();
	}

	@Test
	void theProvisioningUriCarriesWhatAnAppNeeds() {
		String uri = Totp.provisioningUri("ABCDEF", "user@example.com", "Security+ Quiz");

		assertThat(uri).startsWith("otpauth://totp/")
			.contains("secret=ABCDEF")
			.contains("digits=6")
			.contains("period=30")
			.contains("algorithm=SHA1")
			// "Security+ Quiz" encoded. The space must be %20 rather than '+',
			// because some apps do not decode '+' back to a space.
			.contains("Security%2B%20Quiz");
	}

	/* -------------------------------------------------------------- base32 -- */

	@Test
	void base32RoundTrips() {
		byte[] data = "12345678901234567890".getBytes();
		assertThat(Base32.decode(Base32.encode(data))).isEqualTo(data);
	}

	@Test
	void base32MatchesTheRfc4648Vectors() {
		assertThat(Base32.encode("f".getBytes())).isEqualTo("MY");
		assertThat(Base32.encode("fo".getBytes())).isEqualTo("MZXQ");
		assertThat(Base32.encode("foobar".getBytes())).isEqualTo("MZXW6YTBOI");
	}

	@Test
	void base32ToleratesPaddingAndCaseButNotRubbish() {
		assertThat(Base32.decode("mzxw6ytboi")).isEqualTo("foobar".getBytes());
		assertThat(Base32.decode("MZXW6YTBOI======")).isEqualTo("foobar".getBytes());
		assertThatThrownBy(() -> Base32.decode("MZXW6YTB01"))
			.isInstanceOf(IllegalArgumentException.class);
	}
}
