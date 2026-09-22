package com.secplus.auth;

import java.time.Duration;
import java.time.Instant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Housekeeping for auth state that would otherwise only ever grow.
 *
 * Refresh tokens rotate, so every refresh writes a row and revokes one. The
 * front end refreshes on boot and the quiz flow crosses two full page reloads,
 * which makes a single quiz worth several rows. On a t4g.micro that adds up.
 *
 * Revoked rows are kept until well past expiry rather than deleted on
 * revocation: reuse detection needs to still find a revoked token in order to
 * recognise the reuse at all.
 */
@Component
public class AuthMaintenance {

	private static final Logger log = LoggerFactory.getLogger(AuthMaintenance.class);

	/** Long enough that a reused token is still recognised as reuse, not as unknown. */
	private static final Duration GRACE = Duration.ofDays(30);

	private final RefreshTokenService refreshTokens;

	private final LoginRateLimiter rateLimiter;

	AuthMaintenance(RefreshTokenService refreshTokens, LoginRateLimiter rateLimiter) {
		this.refreshTokens = refreshTokens;
		this.rateLimiter = rateLimiter;
	}

	@Scheduled(cron = "0 15 3 * * *")
	public void purgeExpiredRefreshTokens() {
		int removed = refreshTokens.purgeExpiredBefore(Instant.now().minus(GRACE));
		if (removed > 0) {
			log.info("Purged {} expired refresh token(s).", removed);
		}
	}

	/** In-memory, so this only reclaims heap on a long-running instance. */
	@Scheduled(fixedDelay = 15 * 60 * 1000L)
	public void purgeRateLimitWindows() {
		rateLimiter.purgeExpired(Instant.now());
	}
}
