package com.secplus.auth;

import java.time.Instant;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Revokes every live token for one account, in its own transaction.
 *
 * This exists as a separate bean for one reason, and it is not stylistic.
 * Reuse detection has to revoke the family **and** fail the request, and those
 * two pull in opposite directions: the 401 travels as an exception, and an
 * exception rolls the surrounding transaction back — taking the revocation
 * with it. The result is the worst possible outcome, a log line claiming the
 * theft was contained while the stolen token's replacements stay live.
 *
 * `noRollbackFor` on the calling method does not fix it either, because the
 * caller is itself transactional and the outermost boundary decides. A new
 * physical transaction commits the revocation before the exception is ever
 * thrown, whatever the caller does afterwards.
 *
 * It is a separate class rather than a method on RefreshTokenService because
 * Spring's proxying means a self-invocation would silently ignore the
 * propagation and put the bug straight back.
 */
@Component
class TokenFamilyRevoker {

	private final RefreshTokenRepository tokens;

	TokenFamilyRevoker(RefreshTokenRepository tokens) {
		this.tokens = tokens;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	int revokeAll(UUID userId, Instant now) {
		return tokens.revokeAllForUser(userId, now);
	}
}
