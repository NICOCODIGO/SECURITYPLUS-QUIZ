package com.secplus.auth;

import java.time.Duration;
import java.time.Instant;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNoException;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * Needs no Docker, so the window logic stays covered even when the daemon is
 * down and the Testcontainers suites are skipped.
 *
 * Lives in the `auth` package so the limiter's surface can stay
 * package-private — widening production visibility to suit a test is the wrong
 * way round.
 *
 * Time is passed in rather than read from the clock, which is what makes "the
 * window rolls over" testable without sleeping.
 */
class LoginRateLimiterTests {

	private static final Duration WINDOW = Duration.ofMinutes(15);

	private static final Instant NOW = Instant.parse("2026-09-21T10:00:00Z");

	@Test
	void allowsUpToTheLimitThenRejects() {
		LoginRateLimiter limiter = new LoginRateLimiter();

		limiter.check("k", 3, WINDOW, NOW);
		limiter.check("k", 3, WINDOW, NOW);
		limiter.check("k", 3, WINDOW, NOW);

		assertThatThrownBy(() -> limiter.check("k", 3, WINDOW, NOW))
			.isInstanceOf(LoginRateLimiter.RateLimitedException.class)
			// Generic on purpose: a 429 naming the limit that tripped would
			// say whether the account exists.
			.hasMessage("Too many attempts. Try again in a few minutes.");
	}

	@Test
	void theWindowRollsOver() {
		LoginRateLimiter limiter = new LoginRateLimiter();

		limiter.check("k", 1, WINDOW, NOW);
		assertThatThrownBy(() -> limiter.check("k", 1, WINDOW, NOW))
			.isInstanceOf(LoginRateLimiter.RateLimitedException.class);

		Instant later = NOW.plus(WINDOW).plusSeconds(1);
		assertThatNoException().isThrownBy(() -> limiter.check("k", 1, WINDOW, later));
	}

	@Test
	void keysDoNotInterfere() {
		LoginRateLimiter limiter = new LoginRateLimiter();

		limiter.check("a", 1, WINDOW, NOW);
		// One account being locked must not lock a different one.
		assertThatNoException().isThrownBy(() -> limiter.check("b", 1, WINDOW, NOW));
	}

	@Test
	void clearingResetsOneKey() {
		LoginRateLimiter limiter = new LoginRateLimiter();

		limiter.check("a", 1, WINDOW, NOW);
		limiter.clear("a");
		// A successful login clears the failure count; without this, signing in
		// correctly often enough would lock you out of your own account.
		assertThatNoException().isThrownBy(() -> limiter.check("a", 1, WINDOW, NOW));
	}

	@Test
	void expiredWindowsArePurged() {
		LoginRateLimiter limiter = new LoginRateLimiter();

		limiter.check("a", 5, WINDOW, NOW);
		limiter.check("b", 5, WINDOW, NOW);
		assertThat(limiter.trackedKeys()).isEqualTo(2);

		assertThat(limiter.purgeExpired(NOW.plus(WINDOW).plusSeconds(1))).isEqualTo(2);
		assertThat(limiter.trackedKeys()).isZero();
	}

	@Test
	void retryAfterIsPositive() {
		LoginRateLimiter limiter = new LoginRateLimiter();

		limiter.check("k", 1, WINDOW, NOW);
		assertThatThrownBy(() -> limiter.check("k", 1, WINDOW, NOW))
			.isInstanceOfSatisfying(LoginRateLimiter.RateLimitedException.class,
					ex -> assertThat(ex.getRetryAfterSeconds()).isPositive());
	}
}
