package com.secplus.auth;

import java.util.UUID;

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

	public record UserView(UUID id, String email, String displayName) {

		static UserView of(User user) {
			return new UserView(user.getId(), user.getEmail(), user.getDisplayName());
		}
	}

	/** `expiresInSeconds` lets the client refresh before a request fails, rather than after. */
	public record SessionView(String accessToken, long expiresInSeconds, UserView user) {
	}
}
