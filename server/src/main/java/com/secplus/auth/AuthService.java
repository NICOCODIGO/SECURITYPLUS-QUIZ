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

	private final UserTokenService userTokens;

	private final RecoveryCodeService recoveryCodes;

	private final AccountSecurityService accountSecurity;

	AuthService(UserRepository users, RefreshTokenService refreshTokens, TokenService tokens,
			PasswordEncoder passwords, LoginRateLimiter rateLimiter, UserTokenService userTokens,
			RecoveryCodeService recoveryCodes, AccountSecurityService accountSecurity) {
		this.users = users;
		this.refreshTokens = refreshTokens;
		this.tokens = tokens;
		this.passwords = passwords;
		this.rateLimiter = rateLimiter;
		this.userTokens = userTokens;
		this.recoveryCodes = recoveryCodes;
		this.accountSecurity = accountSecurity;
		this.dummyHash = passwords.encode(UUID.randomUUID().toString());
	}

	/** An access token plus the raw refresh value the controller turns into a cookie. */
	record Session(SessionView view, RefreshTokenService.Issued refreshToken) {
	}

	/**
	 * Login ends in one of two places: signed in, or owing a second step.
	 *
	 * A challenge carries no access token and no cookie, so an attacker holding
	 * only the password gets a string that cannot read or write anything.
	 */
	record LoginOutcome(Session session, String challenge, TwoFactorMethod method) {

		boolean needsSecondStep() {
			return challenge != null;
		}
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
		rateLimiter.check("register:global", LoginRateLimiter.REGISTER_GLOBAL,
				LoginRateLimiter.REGISTER_WINDOW, now);

		if (users.existsByEmail(request.email())) {
			throw new AuthException(HttpStatus.CONFLICT, "That email is already registered.");
		}

		// saveAndFlush, not save. UserTokenService writes through JdbcClient, which
		// does not see unflushed JPA state — so with a plain save, the row this
		// user_tokens insert points at does not exist yet and the foreign key
		// fails. It surfaces as a 500 on EVERY registration, and only once a
		// verification token is issued in the same transaction, which is why it
		// appeared the moment mail was added rather than when the entity changed.
		User user = users.saveAndFlush(User.create(request.email(),
				passwords.encode(request.password()), request.displayName()));
		user.recordLogin(now);

		// Best-effort and deliberately so: Mailer swallows its own failures, so a
		// registration never fails because SMTP did. The address can be confirmed
		// later from the account page.
		accountSecurity.sendVerification(user, now);

		return session(user, now, userAgent);
	}

	@Transactional
	LoginOutcome login(LoginRequest request, Instant now, String ip, String userAgent) {
		rateLimiter.check("login:ip:" + ip, LoginRateLimiter.LOGIN_PER_IP, LoginRateLimiter.LOGIN_WINDOW, now);
		String emailKey = "login:email:" + request.email().toLowerCase();
		rateLimiter.check(emailKey, LoginRateLimiter.LOGIN_PER_EMAIL, LoginRateLimiter.LOGIN_WINDOW, now);

		// No account can have a password BCrypt cannot read (register and reset
		// both refuse one), so this is simply wrong - answered like any wrong
		// password, after the same hashing cost, rather than handed to BCrypt.
		if (!AuthRequests.fitsBcrypt(request.password())) {
			passwords.matches("", dummyHash);
			throw new AuthException(HttpStatus.UNAUTHORIZED, BAD_CREDENTIALS);
		}

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

		if (user.isTwoFactorEnabled()) {
			// The password was right, so the lockout is cleared above - but
			// nothing is issued yet. Until the second step passes this account
			// is no more signed in than before.
			UserTokenService.Issued challenge = userTokens.issueLink(user.getId(),
					UserTokenService.LOGIN_CHALLENGE, UserTokenService.CHALLENGE_TTL, now);

			if (user.getTwoFactorMethod() == TwoFactorMethod.EMAIL) {
				// Not thrown, deliberately. Over the limit we skip ISSUING as well
				// as sending, which leaves the code already in their inbox valid -
				// issuing is what invalidates the previous one. So the sign-in
				// still works, it just does not generate another email. Refusing
				// here would turn a rate limit into a lockout.
				if (rateLimiter.tryAcquire("2fa:send:" + user.getId(),
						LoginRateLimiter.LOGIN_CODE_SEND_PER_USER,
						LoginRateLimiter.LOGIN_CODE_SEND_WINDOW, now)) {
					accountSecurity.sendLoginCode(user, now);
				}
			}
			return new LoginOutcome(null, challenge.value(), user.getTwoFactorMethod());
		}

		user.recordLogin(now);
		return new LoginOutcome(session(user, now, userAgent), null, null);
	}

	/**
	 * The second step: challenge plus code, in exchange for a session.
	 *
	 * The challenge is resolved without being spent, so a mistyped digit costs
	 * one attempt rather than sending the person back to the password screen.
	 * Only a correct code consumes it.
	 *
	 * Rate limited **per challenge**, not only per IP. Six digits is a million
	 * values; an attacker who already has the password can rotate addresses, so
	 * a per-IP bucket alone would not stop them.
	 */
	@Transactional
	Session verifyTwoFactor(String challenge, String code, Instant now, String ip, String userAgent) {
		rateLimiter.check("2fa:ip:" + ip, LoginRateLimiter.LOGIN_PER_IP, LoginRateLimiter.LOGIN_WINDOW, now);

		UUID userId = userTokens.resolve(challenge, UserTokenService.LOGIN_CHALLENGE, now)
			.orElseThrow(() -> new AuthException(HttpStatus.UNAUTHORIZED,
					"That sign-in attempt has expired. Start again."));

		rateLimiter.check("2fa:challenge:" + userId, LoginRateLimiter.TWO_FACTOR_PER_CHALLENGE,
				LoginRateLimiter.TWO_FACTOR_WINDOW, now);

		User user = users.findById(userId)
			.orElseThrow(() -> new AuthException(HttpStatus.UNAUTHORIZED, BAD_CREDENTIALS));

		if (!codeAccepted(user, code, now)) {
			throw new AuthException(HttpStatus.UNAUTHORIZED, "That code is incorrect or has expired.");
		}

		// Correct: spend the challenge so it cannot be replayed, and stop
		// counting attempts against it.
		userTokens.redeem(challenge, UserTokenService.LOGIN_CHALLENGE, now);
		rateLimiter.clear("2fa:challenge:" + userId);
		user.recordLogin(now);
		return session(user, now, userAgent);
	}

	/**
	 * The configured method first, then recovery codes.
	 *
	 * One input field for both: the server can tell a six-digit code from a
	 * recovery code by shape, and asking someone mid-lockout to first classify
	 * what they are holding is friction that buys nothing.
	 */
	private boolean codeAccepted(User user, String code, Instant now) {
		boolean primary = (user.getTwoFactorMethod() == TwoFactorMethod.TOTP)
				? totpAccepted(user, code, now)
				: userTokens.redeemLoginCode(user.getId(), code, now);

		return primary || recoveryCodes.redeem(user.getId(), code, now);
	}

	/** Valid AND not already spent - an authenticator code works once, like an emailed one. */
	private static boolean totpAccepted(User user, String code, Instant now) {
		long step = Totp.matchingStep(user.getTotpSecret(), code, now);
		return step != Totp.NO_MATCH && user.spendTotpStep(step);
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
