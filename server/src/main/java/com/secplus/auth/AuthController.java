package com.secplus.auth;

import java.time.Instant;
import java.util.UUID;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

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

import com.secplus.auth.AuthRequests.LoginRequest;
import com.secplus.auth.AuthRequests.RegisterRequest;
import com.secplus.auth.AuthViews.SessionView;
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

	private final AuthService auth;

	private final AuthProperties properties;

	AuthController(AuthService auth, AuthProperties properties) {
		this.auth = auth;
		this.properties = properties;
	}

	@PostMapping("/register")
	ResponseEntity<SessionView> register(@Valid @RequestBody RegisterRequest request,
			HttpServletRequest http) {

		AuthService.Session session = auth.register(request, Instant.now(), clientIp(http),
				http.getHeader(HttpHeaders.USER_AGENT));
		return respond(session, HttpStatus.CREATED);
	}

	@PostMapping("/login")
	ResponseEntity<SessionView> login(@Valid @RequestBody LoginRequest request, HttpServletRequest http) {
		AuthService.Session session = auth.login(request, Instant.now(), clientIp(http),
				http.getHeader(HttpHeaders.USER_AGENT));
		return respond(session, HttpStatus.OK);
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
	 * Who the rate limiter counts against.
	 *
	 * X-Forwarded-For is only consulted when the deployment says every request
	 * arrives through a proxy that overwrites it. Trusting it unconditionally
	 * would be worse than having no limiter at all: the header is caller-
	 * supplied, so a script could send a different value on every request and
	 * get a fresh bucket each time, while a legitimate user behind a real proxy
	 * stays correctly counted.
	 *
	 * Only the first entry is taken — the rest are appendable by the client.
	 */
	private String clientIp(HttpServletRequest request) {
		if (properties.isTrustForwardedFor()) {
			String forwarded = request.getHeader("X-Forwarded-For");
			if (forwarded != null && !forwarded.isBlank()) {
				return forwarded.split(",")[0].trim();
			}
		}
		return request.getRemoteAddr();
	}
}
