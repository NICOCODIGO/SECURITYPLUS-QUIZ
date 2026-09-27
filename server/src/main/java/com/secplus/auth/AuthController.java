package com.secplus.auth;

import java.time.Instant;
import java.util.UUID;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.secplus.auth.AuthRequests.ForgotPasswordRequest;
import com.secplus.auth.AuthRequests.LoginRequest;
import com.secplus.auth.AuthRequests.PasswordConfirmRequest;
import com.secplus.auth.AuthRequests.RegisterRequest;
import com.secplus.auth.AuthRequests.ResetPasswordRequest;
import com.secplus.auth.AuthRequests.TwoFactorConfirmRequest;
import com.secplus.auth.AuthRequests.TwoFactorSetupRequest;
import com.secplus.auth.AuthRequests.TwoFactorVerifyRequest;
import com.secplus.auth.AuthRequests.VerifyEmailRequest;
import com.secplus.auth.AuthViews.LoginView;
import com.secplus.auth.AuthViews.RecoveryCodesView;
import com.secplus.auth.AuthViews.SessionView;
import com.secplus.auth.AuthViews.TwoFactorSetupView;
import com.secplus.auth.AuthViews.TwoFactorStatusView;
import com.secplus.auth.AuthViews.UserView;
import com.secplus.common.AuthException;

/**
 * Email + password accounts.
 *
 * The access token goes back in the body; the refresh token only ever leaves
 * as an httpOnly cookie, so script cannot read it even if the page is
 * compromised.
 *
 * `/refresh` and `/logout` require an `X-Secplus-Client` header. That is this
 * API's CSRF defence, and it is deliberately not Spring's: a cross-site form or
 * <img> cannot set a custom header without triggering a preflight, and CORS
 * only allows the configured origins. Spring's machinery would mean shipping a
 * readable CSRF cookie and a double-submit dance for two endpoints on an
 * otherwise stateless API. See SecurityConfig.
 */
@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

	private static final Logger log = LoggerFactory.getLogger(AuthController.class);

	private final AuthService auth;

	private final AccountSecurityService accountSecurity;

	private final AuthProperties properties;

	AuthController(AuthService auth, AccountSecurityService accountSecurity, AuthProperties properties) {
		this.auth = auth;
		this.accountSecurity = accountSecurity;
		this.properties = properties;
	}

	@PostMapping("/register")
	ResponseEntity<SessionView> register(@Valid @RequestBody RegisterRequest request,
			HttpServletRequest http) {

		AuthService.Session session = auth.register(request, Instant.now(), clientIp(http),
				http.getHeader(HttpHeaders.USER_AGENT));
		return respond(session, HttpStatus.CREATED);
	}

	/**
	 * Returns a session, or a challenge when 2FA is on.
	 *
	 * The challenge path sets **no cookie**, so a caller holding only the
	 * password comes away with nothing that can read or write study data.
	 */
	@PostMapping("/login")
	ResponseEntity<LoginView> login(@Valid @RequestBody LoginRequest request, HttpServletRequest http) {
		AuthService.LoginOutcome outcome = auth.login(request, Instant.now(), clientIp(http),
				http.getHeader(HttpHeaders.USER_AGENT));

		if (outcome.needsSecondStep()) {
			return ResponseEntity.ok(LoginView.secondStepRequired(outcome.challenge(), outcome.method()));
		}

		AuthService.Session session = outcome.session();
		return ResponseEntity.ok()
			.header(HttpHeaders.SET_COOKIE, refreshCookie(session.refreshToken()).toString())
			.body(LoginView.signedIn(session.view()));
	}

	/** The second step. Same response for a wrong code, an expired one and a wrong challenge. */
	@PostMapping("/2fa/verify")
	ResponseEntity<SessionView> verifyTwoFactor(@Valid @RequestBody TwoFactorVerifyRequest request,
			HttpServletRequest http) {

		AuthService.Session session = auth.verifyTwoFactor(request.challenge(), request.code(), Instant.now(),
				clientIp(http), http.getHeader(HttpHeaders.USER_AGENT));
		return respond(session, HttpStatus.OK);
	}

	// ---------------------------------------------- verification and reset --

	/**
	 * POST, not GET, even though it is reached from a link.
	 *
	 * The link in the email opens the SPA, which then calls this. A GET API
	 * endpoint would be fetched by the link scanners some mail providers run,
	 * silently spending the token before the person ever clicked it.
	 */
	@PostMapping("/verify-email")
	ResponseEntity<Void> verifyEmail(@Valid @RequestBody VerifyEmailRequest request) {
		accountSecurity.verifyEmail(request.token(), Instant.now());
		return ResponseEntity.noContent().build();
	}

	@PostMapping("/resend-verification")
	ResponseEntity<Void> resendVerification(@AuthenticationPrincipal Jwt jwt) {
		accountSecurity.resendVerification(UUID.fromString(jwt.getSubject()), Instant.now());
		return ResponseEntity.noContent().build();
	}

	/**
	 * Always 204, whether or not the address has an account.
	 *
	 * Anything else - a 404, a different message, even a measurably different
	 * response time - would make this a way of asking who has an account here,
	 * which is the oracle the login message exists to close.
	 */
	@PostMapping("/forgot-password")
	ResponseEntity<Void> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request,
			HttpServletRequest http) {

		accountSecurity.requestPasswordReset(request.email(), Instant.now(), clientIp(http));
		return ResponseEntity.noContent().build();
	}

	/**
	 * Ends every other session, and clears the refresh cookie on this one too.
	 *
	 * Resetting is what someone does when they think their account is
	 * compromised; leaving the attacker signed in elsewhere would defeat it.
	 */
	@PostMapping("/reset-password")
	ResponseEntity<Void> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
		accountSecurity.resetPassword(request.token(), request.password(), Instant.now());
		return ResponseEntity.noContent()
			.header(HttpHeaders.SET_COOKIE, expiredCookie().toString())
			.build();
	}

	// ------------------------------------------------------- managing 2FA --

	@GetMapping("/2fa")
	TwoFactorStatusView twoFactorStatus(@AuthenticationPrincipal Jwt jwt) {
		return accountSecurity.status(UUID.fromString(jwt.getSubject()));
	}

	/** Starts setup. Nothing is enabled until /2fa/confirm proves a code works. */
	@PostMapping("/2fa/setup")
	TwoFactorSetupView beginTwoFactorSetup(@Valid @RequestBody TwoFactorSetupRequest request,
			@AuthenticationPrincipal Jwt jwt) {

		return accountSecurity.beginSetup(UUID.fromString(jwt.getSubject()), request.method(), Instant.now());
	}

	/** The only response that ever contains recovery codes in the clear. */
	@PostMapping("/2fa/confirm")
	RecoveryCodesView confirmTwoFactorSetup(@Valid @RequestBody TwoFactorConfirmRequest request,
			@AuthenticationPrincipal Jwt jwt) {

		return new RecoveryCodesView(accountSecurity.confirmSetup(UUID.fromString(jwt.getSubject()),
				request.method(), request.code(), Instant.now()));
	}

	@PostMapping("/2fa/disable")
	ResponseEntity<Void> disableTwoFactor(@Valid @RequestBody PasswordConfirmRequest request,
			@AuthenticationPrincipal Jwt jwt) {

		accountSecurity.disable(UUID.fromString(jwt.getSubject()), request.password(), Instant.now());
		return ResponseEntity.noContent().build();
	}

	@PostMapping("/2fa/recovery-codes")
	RecoveryCodesView regenerateRecoveryCodes(@Valid @RequestBody PasswordConfirmRequest request,
			@AuthenticationPrincipal Jwt jwt) {

		return new RecoveryCodesView(accountSecurity.regenerateRecoveryCodes(UUID.fromString(jwt.getSubject()),
				request.password(), Instant.now()));
	}

	/**
	 * The cookie is optional so a caller with none gets the same 401 as a
	 * caller with a stale one — a missing cookie is just a signed-out browser,
	 * not a malformed request.
	 */
	@PostMapping("/refresh")
	ResponseEntity<SessionView> refresh(
			@CookieValue(name = "${app.auth.cookie-name}", required = false) String refreshToken,
			@RequestHeader("X-Secplus-Client") String client,
			HttpServletRequest http) {

		if (refreshToken == null || refreshToken.isBlank()) {
			throw new AuthException(HttpStatus.UNAUTHORIZED, "Your session has expired. Sign in again.");
		}

		AuthService.Session session = auth.refresh(refreshToken, Instant.now(), clientIp(http),
				http.getHeader(HttpHeaders.USER_AGENT));
		return respond(session, HttpStatus.OK);
	}

	/**
	 * Public, and always 204. You sign out with an expired access token more
	 * often than not, and a failed sign-out would leave the browser holding a
	 * cookie it believes is gone.
	 */
	@PostMapping("/logout")
	ResponseEntity<Void> logout(
			@CookieValue(name = "${app.auth.cookie-name}", required = false) String refreshToken,
			@RequestHeader("X-Secplus-Client") String client) {

		auth.logout(refreshToken, Instant.now());
		return ResponseEntity.noContent()
			.header(HttpHeaders.SET_COOKIE, expiredCookie().toString())
			.build();
	}

	@GetMapping("/me")
	UserView me(@AuthenticationPrincipal Jwt jwt) {
		return auth.me(UUID.fromString(jwt.getSubject()));
	}

	private ResponseEntity<SessionView> respond(AuthService.Session session, HttpStatus status) {
		return ResponseEntity.status(status)
			.header(HttpHeaders.SET_COOKIE, refreshCookie(session.refreshToken()).toString())
			.body(session.view());
	}

	private ResponseCookie refreshCookie(RefreshTokenService.Issued issued) {
		return baseCookie(issued.value())
			.maxAge(properties.getRefreshTokenTtl())
			.build();
	}

	private ResponseCookie expiredCookie() {
		return baseCookie("").maxAge(0).build();
	}

	private ResponseCookie.ResponseCookieBuilder baseCookie(String value) {
		return ResponseCookie.from(properties.getCookieName(), value)
			.httpOnly(true)
			.secure(properties.isCookieSecure())
			.path(properties.getCookiePath())
			.sameSite(properties.getCookieSameSite());
	}

	/**
	 * Who the per-IP rate limits count against.
	 *
	 * X-Forwarded-For is a list that every proxy APPENDS to - CloudFront and
	 * App Runner included; neither overwrites it. So everything to the left is
	 * whatever the caller sent, and only the entries our own proxies added can
	 * be believed. The client is the one `forwardedForHops` from the right: the
	 * address the outermost proxy saw. Taking the FIRST entry, as this once
	 * did, let a script send a fresh value per request and a fresh bucket with
	 * it.
	 *
	 * Even read correctly this is best-effort, because App Runner can be called
	 * directly, skipping the proxy that makes the count right. That is why every
	 * limit that protects a person is per account or global as well
	 * (LoginRateLimiter), never per IP alone.
	 */
	String clientIp(HttpServletRequest request) {
		if (properties.isTrustForwardedFor()) {
			String forwarded = request.getHeader("X-Forwarded-For");
			if (forwarded != null && !forwarded.isBlank()) {
				String[] entries = forwarded.split(",");
				int index = Math.max(entries.length - properties.getForwardedForHops(), 0);
				String chosen = entries[index].trim();
				// Off unless LOGGING_LEVEL_COM_SECPLUS_AUTH=DEBUG (package level:
				// Boot lowercases logging env vars, so a class name never matches). The
				// way to set forwarded-for-hops after the proxies in front change:
				// compare `chosen` with the caller's real public IP. Logs addresses,
				// so switch it back off afterwards.
				log.debug("X-Forwarded-For [{}] has {} entries; using {} (hops={})", forwarded, entries.length,
						chosen, properties.getForwardedForHops());
				return chosen;
			}
		}
		return request.getRemoteAddr();
	}
}
