package com.secplus.auth;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * What the API sends back.
 *
 * Records rather than the entities, so `passwordHash` can never reach a
 * response by someone adding a getter. The refresh token is never in a body —
 * it only ever travels as an httpOnly cookie.
 */
public final class AuthViews {

	private AuthViews() {
	}

	public record UserView(UUID id, String email, String displayName, boolean emailVerified,
			String twoFactorMethod) {

		static UserView of(User user) {
			TwoFactorMethod method = user.getTwoFactorMethod();
			return new UserView(user.getId(), user.getEmail(), user.getDisplayName(), user.isEmailVerified(),
					method == null ? null : method.value());
		}
	}

	/** `expiresInSeconds` lets the client refresh before a request fails, rather than after. */
	public record SessionView(String accessToken, long expiresInSeconds, UserView user) {
	}

	/**
	 * What /login returns, which is one of two different things.
	 *
	 * With 2FA off it carries the session. With 2FA on it carries only a
	 * challenge - no access token, no refresh cookie, nothing that can read or
	 * write study data until the second step succeeds.
	 *
	 * NON_NULL so the client can branch on the presence of `challenge` rather
	 * than on a flag it could forget to check. A discriminated union would be
	 * more rigorous and would also mean Jackson polymorphism config for one
	 * endpoint.
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public record LoginView(String accessToken, Long expiresInSeconds, UserView user, String challenge,
			String twoFactorMethod) {

		static LoginView signedIn(SessionView session) {
			return new LoginView(session.accessToken(), session.expiresInSeconds(), session.user(), null, null);
		}

		static LoginView secondStepRequired(String challenge, TwoFactorMethod method) {
			return new LoginView(null, null, null, challenge, method.value());
		}
	}

	/** Drives the account page: what is on, and whether recovery codes are running out. */
	public record TwoFactorStatusView(boolean emailVerified, String method, int recoveryCodesRemaining) {
	}

	/**
	 * `secret` and `provisioningUri` are only populated for TOTP, and only
	 * during setup - this is the single moment either is readable.
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public record TwoFactorSetupView(String method, String secret, String provisioningUri) {
	}

	/**
	 * Shown exactly once. They are hashed at rest, so there is no endpoint that
	 * can show them again - only one that replaces them.
	 */
	public record RecoveryCodesView(List<String> codes) {
	}
}
