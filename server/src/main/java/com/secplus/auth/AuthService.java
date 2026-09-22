package com.secplus.auth;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.secplus.auth.AuthRequests.LoginRequest;
import com.secplus.auth.AuthRequests.RegisterRequest;
import com.secplus.auth.AuthViews.SessionView;
import com.secplus.auth.AuthViews.UserView;
import com.secplus.common.AuthException;

/** Register, sign in, refresh, sign out. */
@Service
public class AuthService {

	/**
	 * One message for both "no such account" and "wrong password".
	 *
	 * Byte-identical on purpose: any difference at all, including punctuation,
	 * turns the endpoint into a way of asking whether a given person has an
	 * account here. AuthApiTests asserts the two responses are the same.
	 */
	private static final String BAD_CREDENTIALS = "Email or password is incorrect.";

	/**
	 * A real hash, verified against when the account does not exist.
	 *
	 * Without it an unknown email returns in about a millisecond while a known
	 * one takes the ~250ms BCrypt costs, and that timing gap is the same
	 * enumeration oracle the shared message just closed.
	 *
	 * Computed at startup from a random value rather than pasted in as a
	 * literal: a literal can be malformed or carry the wrong cost factor, and
	 * BCrypt answers both of those in microseconds without throwing — the
	 * defence would be silently doing nothing.
	 */
	private final String dummyHash;

	private final UserRepository users;

	private final RefreshTokenService refreshTokens;

	private final TokenService tokens;

	private final PasswordEncoder passwords;

	private final LoginRateLimiter rateLimiter;

	AuthService(UserRepository users, RefreshTokenService refreshTokens, TokenService tokens,
			PasswordEncoder passwords, LoginRateLimiter rateLimiter) {
		this.users = users;
		this.refreshTokens = refreshTokens;
		this.tokens = tokens;
		this.passwords = passwords;
		this.rateLimiter = rateLimiter;
		this.dummyHash = passwords.encode(UUID.randomUUID().toString());
	}

	/** An access token plus the raw refresh value the controller turns into a cookie. */
	record Session(SessionView view, RefreshTokenService.Issued refreshToken) {
	}

	/**
	 * Register returns 409 on a duplicate, which does tell a caller that an
	 * address is taken.
	 *
	 * This narrows docs/architecture.md's "no user enumeration" and is a
	 * deliberate trade, recorded in docs/decisions.md. The alternative — accept
	 * the registration and resolve it by email — needs a mailer this project
	 * does not have, and without one it produces a person who believes they
	 * created an account they can never sign into. Rate limiting per IP is what
	 * keeps the 409 from being a practical enumeration tool.
	 */
	@Transactional
	Session register(RegisterRequest request, Instant now, String ip, String userAgent) {
		rateLimiter.check("register:ip:" + ip, LoginRateLimiter.REGISTER_PER_IP,
				LoginRateLimiter.REGISTER_WINDOW, now);

		if (users.existsByEmail(request.email())) {
			throw new AuthException(HttpStatus.CONFLICT, "That email is already registered.");
		}

		User user = users.save(User.create(request.email(), passwords.encode(request.password()),
				request.displayName()));
		user.recordLogin(now);

		return session(user, now, userAgent);
	}

	@Transactional
	Session login(LoginRequest request, Instant now, String ip, String userAgent) {
		rateLimiter.check("login:ip:" + ip, LoginRateLimiter.LOGIN_PER_IP, LoginRateLimiter.LOGIN_WINDOW, now);
		String emailKey = "login:email:" + request.email().toLowerCase();
		rateLimiter.check(emailKey, LoginRateLimiter.LOGIN_PER_EMAIL, LoginRateLimiter.LOGIN_WINDOW, now);

		Optional<User> found = users.findByEmail(request.email());

		if (found.isEmpty()) {
			// Burn the same time a real verify would, then fail identically.
			passwords.matches(request.password(), dummyHash);
			throw new AuthException(HttpStatus.UNAUTHORIZED, BAD_CREDENTIALS);
		}

		User user = found.get();
		if (!passwords.matches(request.password(), user.getPasswordHash())) {
			throw new AuthException(HttpStatus.UNAUTHORIZED, BAD_CREDENTIALS);
		}

		// Only failures should count towards the lockout.
		rateLimiter.clear(emailKey);
		user.recordLogin(now);
		return session(user, now, userAgent);
	}

	@Transactional
	Session refresh(String presented, Instant now, String ip, String userAgent) {
		rateLimiter.check("refresh:ip:" + ip, LoginRateLimiter.REFRESH_PER_IP,
				LoginRateLimiter.REFRESH_WINDOW, now);

		RefreshTokenService.Rotation rotation = refreshTokens.rotate(presented, now, userAgent);
		return new Session(
				new SessionView(tokens.mintAccessToken(rotation.user(), now), tokens.accessTokenSeconds(),
						UserView.of(rotation.user())),
				rotation.token());
	}

	@Transactional
	void logout(String presented, Instant now) {
		if (presented != null && !presented.isBlank()) {
			refreshTokens.revoke(presented, now);
		}
	}

	@Transactional(readOnly = true)
	UserView me(UUID userId) {
		return users.findById(userId)
			.map(UserView::of)
			// The token verified, so the account existed when it was minted.
			// Reaching here means it was deleted mid-session.
			.orElseThrow(() -> new AuthException(HttpStatus.UNAUTHORIZED, "Your session is no longer valid."));
	}

	private Session session(User user, Instant now, String userAgent) {
		RefreshTokenService.Issued issued = refreshTokens.issue(user, now, userAgent);
		return new Session(
				new SessionView(tokens.mintAccessToken(user, now), tokens.accessTokenSeconds(), UserView.of(user)),
				issued);
	}
}
