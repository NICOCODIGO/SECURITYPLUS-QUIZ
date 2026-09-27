package com.secplus.auth;

import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import com.secplus.common.AuthException;

/**
 * Fixed-window rate limiting, in memory.
 *
 * Deliberately not Bucket4j. The deployment target is a single App Runner
 * instance with no shared cache, so a library would give exactly the same
 * per-instance guarantee this map gives, in exchange for a dependency and a
 * version to track. When phase 6 scales past one instance this needs a shared
 * store anyway — and that decision is Redis-or-not, not Bucket4j-or-not.
 *
 * Login is limited on two independent axes: per email, so one account cannot
 * be ground down, and per IP, so a single source cannot spray many accounts.
 */
@Component
public class LoginRateLimiter {

	static final int LOGIN_PER_EMAIL = 5;

	static final int LOGIN_PER_IP = 20;

	/**
	 * Higher than it first looks like it should be, deliberately.
	 *
	 * This counts one shared address, and the audience for a free study app is
	 * students on university, library and café wifi — a whole class signing up
	 * in one session is the normal case, not an attack. A handful per hour
	 * would generate support mail, not security. Twenty still makes scripted
	 * mass-registration useless.
	 */
	static final int REGISTER_PER_IP = 20;

	static final int REFRESH_PER_IP = 60;

	/**
	 * The one that actually matters.
	 *
	 * A six-digit code is a million guesses, which a script exhausts in minutes
	 * if it is only limited per IP - and an attacker holding a valid password
	 * already has the challenge. Five attempts against a single challenge makes
	 * guessing hopeless while leaving room for a fat-fingered retype.
	 */
	static final int TWO_FACTOR_PER_CHALLENGE = 5;

	/** Mail costs money to send and attention to receive. */
	static final int VERIFY_SEND_PER_USER = 5;

	/**
	 * How many sign-in codes one account can have MAILED in a window.
	 *
	 * Distinct from TWO_FACTOR_PER_CHALLENGE, which caps *guesses*. This caps
	 * *sends*: every login with the right password would otherwise mail a fresh
	 * code, and a correct password clears the per-account login bucket, so
	 * someone holding the password could use the account as a way to send mail
	 * to its owner.
	 *
	 * Three is enough for a code that landed in spam plus a genuine retry.
	 */
	static final int LOGIN_CODE_SEND_PER_USER = 3;

	static final int FORGOT_PER_IP = 10;

	static final Duration LOGIN_WINDOW = Duration.ofMinutes(15);

	static final Duration REGISTER_WINDOW = Duration.ofHours(1);

	static final Duration REFRESH_WINDOW = Duration.ofMinutes(1);

	/** Matches the login code's own ten-minute life; a longer window would outlive the code. */
	static final Duration TWO_FACTOR_WINDOW = Duration.ofMinutes(10);

	static final Duration VERIFY_SEND_WINDOW = Duration.ofHours(1);

	/** Matches the code's own ten-minute life. */
	static final Duration LOGIN_CODE_SEND_WINDOW = Duration.ofMinutes(10);

	static final Duration FORGOT_WINDOW = Duration.ofHours(1);

	private final Map<String, Window> windows = new ConcurrentHashMap<>();

	private static final class Window {

		private int count;

		private Instant resetAt;

		Window(Instant resetAt) {
			this.resetAt = resetAt;
			this.count = 0;
		}
	}

	/** Throws 429 when the window is full; otherwise records the hit. */
	void check(String key, int limit, Duration window, Instant now) {
		Window current = windows.compute(key, (ignored, existing) -> {
			if (existing == null || !existing.resetAt.isAfter(now)) {
				return new Window(now.plus(window));
			}
			return existing;
		});

		synchronized (current) {
			if (current.count >= limit) {
				long retryAfter = Math.max(1, Duration.between(now, current.resetAt).toSeconds());
				throw new RateLimitedException(retryAfter);
			}
			current.count += 1;
		}
	}

	/**
	 * Records a hit and reports whether it was allowed, instead of throwing.
	 *
	 * For limits where refusing outright would be worse than the thing being
	 * limited. Mailing a sign-in code is the case this exists for: throwing 429
	 * there would turn "we already sent you one" into "you cannot sign in",
	 * converting a rate limit into a lockout.
	 */
	boolean tryAcquire(String key, int limit, Duration window, Instant now) {
		try {
			check(key, limit, window, now);
			return true;
		}
		catch (RateLimitedException e) {
			return false;
		}
	}

	/**
	 * Login and register only count *failures*, so someone signing in
	 * repeatedly on a shared IP is never locked out by their own success.
	 */
	void clear(String key) {
		windows.remove(key);
	}

	/** Called on a schedule so abandoned keys do not accumulate. */
	int purgeExpired(Instant now) {
		int before = windows.size();
		windows.values().removeIf(window -> !window.resetAt.isAfter(now));
		return before - windows.size();
	}

	int trackedKeys() {
		return windows.size();
	}

	/**
	 * The message says nothing about which limit was hit or whether the account
	 * exists — a 429 that distinguished them would put back the enumeration
	 * oracle the login message exists to close.
	 */
	static class RateLimitedException extends AuthException {

		RateLimitedException(long retryAfterSeconds) {
			super(HttpStatus.TOO_MANY_REQUESTS, "Too many attempts. Try again in a few minutes.",
					retryAfterSeconds);
		}
	}
}
