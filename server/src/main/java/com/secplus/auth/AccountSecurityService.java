package com.secplus.auth;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.secplus.auth.AuthViews.TwoFactorStatusView;
import com.secplus.auth.AuthViews.TwoFactorSetupView;
import com.secplus.common.AuthException;

/**
 * Email verification, password reset, and turning the second step on and off.
 *
 * Kept out of AuthService, which owns the session lifecycle — register, sign
 * in, refresh, sign out. These are account *maintenance*: they never mint a
 * session, and two of them deliberately destroy every session there is.
 *
 * The rule that shapes most of this file: **none of it may gate studying.**
 * Every quiz, the mock exam and all 444 questions work signed out, so an
 * unverified address or a half-finished 2FA setup must never be able to take
 * that away. Verification gates password reset. Nothing else.
 */
@Service
public class AccountSecurityService {

	/**
	 * What every password-reset request returns, whether or not the address
	 * exists.
	 *
	 * The endpoint is public and unauthenticated, so a response that differed
	 * would be a way of asking whether someone has an account here — the same
	 * enumeration oracle AuthService closes on login, reopened on a different
	 * door.
	 */
	private static final String RESET_REQUESTED = "If that address has an account, a reset link is on its way.";

	private final UserRepository users;

	private final UserTokenService userTokens;

	private final RecoveryCodeService recoveryCodes;

	private final TokenFamilyRevoker familyRevoker;

	private final PasswordEncoder passwords;

	private final LoginRateLimiter rateLimiter;

	private final Mailer mailer;

	AccountSecurityService(UserRepository users, UserTokenService userTokens, RecoveryCodeService recoveryCodes,
			TokenFamilyRevoker familyRevoker, PasswordEncoder passwords, LoginRateLimiter rateLimiter,
			Mailer mailer) {
		this.users = users;
		this.userTokens = userTokens;
		this.recoveryCodes = recoveryCodes;
		this.familyRevoker = familyRevoker;
		this.passwords = passwords;
		this.rateLimiter = rateLimiter;
		this.mailer = mailer;
	}

	// ------------------------------------------------------- verification --

	/**
	 * Issues a verification link and mails it.
	 *
	 * Called on registration and on request. Sending is fire-and-forget by
	 * design: Mailer swallows its own failures, so a registration cannot 500
	 * because SMTP hiccuped.
	 */
	@Transactional
	public void sendVerification(User user, Instant now) {
		if (user.isEmailVerified()) {
			return;
		}

		UserTokenService.Issued issued = userTokens.issueLink(user.getId(), UserTokenService.VERIFY,
				UserTokenService.VERIFY_TTL, now);
		mailer.sendVerification(user.getEmail(), issued.value());
	}

	/** Resending is rate limited per account: the mail costs us money and them attention. */
	@Transactional
	void resendVerification(UUID userId, Instant now) {
		rateLimiter.check("verify:user:" + userId, LoginRateLimiter.VERIFY_SEND_PER_USER,
				LoginRateLimiter.VERIFY_SEND_WINDOW, now);

		users.findById(userId).ifPresent(user -> sendVerification(user, now));
	}

	/**
	 * Spends a verification link.
	 *
	 * Already-verified is not an error worth surfacing: people click the link
	 * twice, and a second click that reports failure reads as though the first
	 * one did not work.
	 */
	@Transactional
	void verifyEmail(String token, Instant now) {
		UUID userId = userTokens.redeem(token, UserTokenService.VERIFY, now)
			.orElseThrow(() -> new AuthException(HttpStatus.BAD_REQUEST,
					"That verification link has expired or has already been used."));

		users.findById(userId).ifPresent(User::markEmailVerified);
	}

	// ----------------------------------------------------- password reset --

	/**
	 * Always succeeds, as far as the caller can tell.
	 *
	 * An unverified address gets no link. That is the one thing verification is
	 * for: without it, anyone could register somebody else's address and later
	 * use "reset" to take over the mailbox they never proved they owned.
	 */
	@Transactional
	String requestPasswordReset(String email, Instant now, String ip) {
		rateLimiter.check("forgot:ip:" + ip, LoginRateLimiter.FORGOT_PER_IP,
				LoginRateLimiter.FORGOT_WINDOW, now);

		users.findByEmail(email)
			.filter(User::isEmailVerified)
			.ifPresent(user -> {
				UserTokenService.Issued issued = userTokens.issueLink(user.getId(), UserTokenService.RESET,
						UserTokenService.RESET_TTL, now);
				mailer.sendPasswordReset(user.getEmail(), issued.value());
			});

		return RESET_REQUESTED;
	}

	/**
	 * Spends a reset link and sets the new password.
	 *
	 * **Every refresh token dies here.** A reset is what someone does when they
	 * believe their account is compromised, so leaving the attacker signed in
	 * on another device would defeat the entire exercise. Outstanding reset
	 * links die too, so a second link sitting in the mailbox is not a way back
	 * in.
	 */
	@Transactional
	void resetPassword(String token, String newPassword, Instant now) {
		UUID userId = userTokens.redeem(token, UserTokenService.RESET, now)
			.orElseThrow(() -> new AuthException(HttpStatus.BAD_REQUEST,
					"That reset link has expired or has already been used. Request a new one."));

		User user = users.findById(userId)
			.orElseThrow(() -> new AuthException(HttpStatus.BAD_REQUEST, "That account no longer exists."));

		user.changePassword(passwords.encode(newPassword));
		// Reaching a reset link proves the mailbox, which is what verification
		// proves - so an address that somehow got here unverified now is.
		user.markEmailVerified();
		userTokens.invalidate(userId, UserTokenService.RESET, now);
		familyRevoker.revokeAll(userId, now);
	}

	// --------------------------------------------------------------- 2FA --

	@Transactional(readOnly = true)
	TwoFactorStatusView status(UUID userId) {
		User user = require(userId);
		TwoFactorMethod method = user.getTwoFactorMethod();
		return new TwoFactorStatusView(user.isEmailVerified(), method == null ? null : method.value(),
				user.isTwoFactorEnabled() ? recoveryCodes.remaining(userId) : 0);
	}

	/**
	 * Begins setup. Nothing is enabled until a code proves it works.
	 *
	 * That two-step shape is the whole safety property: enabling TOTP on the
	 * strength of a scanned QR code alone locks out anyone whose authenticator
	 * clock is wrong or who scanned into an app they then deleted.
	 */
	@Transactional
	TwoFactorSetupView beginSetup(UUID userId, String rawMethod, Instant now) {
		User user = require(userId);
		TwoFactorMethod method = TwoFactorMethod.parse(rawMethod);

		if (method == null) {
			throw new AuthException(HttpStatus.BAD_REQUEST, "Choose either email or an authenticator app.");
		}

		if (method == TwoFactorMethod.EMAIL) {
			if (!user.isEmailVerified()) {
				throw new AuthException(HttpStatus.CONFLICT,
						"Confirm your email address first — otherwise a code sent there could lock you out.");
			}
			sendLoginCode(user, now);
			return new TwoFactorSetupView(method.value(), null, null);
		}

		// Staged on the user with the method left null, which V2 explicitly
		// permits: the check constraint forbids a method of 'totp' WITHOUT a
		// secret, not a secret without a method. So an abandoned setup leaves an
		// inert secret and 2FA stays off, rather than half-on.
		String secret = Totp.newSecret();
		user.stageTotpSecret(secret);
		return new TwoFactorSetupView(method.value(), secret,
				Totp.provisioningUri(secret, user.getEmail(), "Certucation"));
	}

	/**
	 * Finishes setup, returning the recovery codes once.
	 *
	 * This is the only time they are ever readable. They are hashed at rest, so
	 * there is no second chance to show them — which is why the client has to
	 * make the person acknowledge them before moving on.
	 */
	@Transactional
	List<String> confirmSetup(UUID userId, String rawMethod, String code, Instant now) {
		User user = require(userId);
		TwoFactorMethod method = TwoFactorMethod.parse(rawMethod);

		if (method == null) {
			throw new AuthException(HttpStatus.BAD_REQUEST, "Choose either email or an authenticator app.");
		}

		rateLimiter.check("2fa:setup:" + userId, LoginRateLimiter.TWO_FACTOR_PER_CHALLENGE,
				LoginRateLimiter.TWO_FACTOR_WINDOW, now);

		String secret = null;
		if (method == TwoFactorMethod.TOTP) {
			secret = user.getTotpSecret();
			if (secret == null) {
				throw new AuthException(HttpStatus.BAD_REQUEST, "Start the setup again - nothing is pending.");
			}

			if (!Totp.verify(secret, code, now)) {
				throw new AuthException(HttpStatus.BAD_REQUEST, "That code is not right. Check the clock on your device.");
			}
		}
		else if (!userTokens.redeemLoginCode(userId, code, now)) {
			throw new AuthException(HttpStatus.BAD_REQUEST, "That code is not right, or it has expired.");
		}

		user.enableTwoFactor(method, secret);
		return recoveryCodes.regenerate(userId);
	}

	/**
	 * Turning it off needs the password, not just a session.
	 *
	 * A borrowed unlocked laptop is the exact threat 2FA exists for, and it
	 * arrives holding a valid session. Removing the protection has to cost
	 * something the borrower does not have.
	 */
	@Transactional
	void disable(UUID userId, String password, Instant now) {
		User user = require(userId);
		requirePassword(user, password, now);

		user.disableTwoFactor();
		recoveryCodes.clear(userId);
	}

	/** Same reasoning as disable: a fresh list invalidates the old one. */
	@Transactional
	List<String> regenerateRecoveryCodes(UUID userId, String password, Instant now) {
		User user = require(userId);
		requirePassword(user, password, now);

		if (!user.isTwoFactorEnabled()) {
			throw new AuthException(HttpStatus.CONFLICT, "Two-factor authentication is not turned on.");
		}
		return recoveryCodes.regenerate(userId);
	}

	// ------------------------------------------------------------ helpers --

	/** Issues and mails a six-digit code. Shared by setup and the login challenge. */
	@Transactional
	void sendLoginCode(User user, Instant now) {
		UserTokenService.Issued issued = userTokens.issueLoginCode(user.getId(), now);
		mailer.sendLoginCode(user.getEmail(), issued.value());
	}

	private void requirePassword(User user, String password, Instant now) {
		rateLimiter.check("password:user:" + user.getId(), LoginRateLimiter.LOGIN_PER_EMAIL,
				LoginRateLimiter.LOGIN_WINDOW, now);

		if (password == null || !passwords.matches(password, user.getPasswordHash())) {
			throw new AuthException(HttpStatus.UNAUTHORIZED, "That password is incorrect.");
		}
		rateLimiter.clear("password:user:" + user.getId());
	}

	private User require(UUID userId) {
		Optional<User> found = users.findById(userId);
		return found.orElseThrow(
				() -> new AuthException(HttpStatus.UNAUTHORIZED, "Your session is no longer valid."));
	}

}
