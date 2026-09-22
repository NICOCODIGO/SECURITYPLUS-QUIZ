package com.secplus.auth;

import java.time.Duration;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Everything about auth that differs between a laptop and production.
 *
 * The cookie attributes are here rather than inline at the call site because
 * SameSite in particular has to change when the API moves behind the same
 * domain as the site — see docs/decisions.md.
 */
@ConfigurationProperties("app.auth")
public class AuthProperties {

	/** Blank means "generate one at startup"; see TokenConfig. */
	private String secret = "";

	private String issuer = "secplus-api";

	private Duration accessTokenTtl = Duration.ofMinutes(15);

	private Duration refreshTokenTtl = Duration.ofDays(30);

	private String cookieName = "secplus_refresh";

	/** Scoped so the refresh token is not sent with every question request. */
	private String cookiePath = "/api/v1/auth";

	private String cookieSameSite = "Strict";

	private boolean cookieSecure = false;

	/**
	 * Whether X-Forwarded-For identifies the caller.
	 *
	 * Off by default, and that default is the safe one: anything can send the
	 * header, so trusting it on a directly reachable origin lets a caller pick
	 * a fresh rate-limit bucket per request and defeat the limiter entirely.
	 * Turn it on only where every request arrives through a proxy that
	 * overwrites the header — CloudFront in front of App Runner, in phase 6.
	 */
	private boolean trustForwardedFor = false;

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getIssuer() {
		return issuer;
	}

	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}

	public Duration getAccessTokenTtl() {
		return accessTokenTtl;
	}

	public void setAccessTokenTtl(Duration accessTokenTtl) {
		this.accessTokenTtl = accessTokenTtl;
	}

	public Duration getRefreshTokenTtl() {
		return refreshTokenTtl;
	}

	public void setRefreshTokenTtl(Duration refreshTokenTtl) {
		this.refreshTokenTtl = refreshTokenTtl;
	}

	public String getCookieName() {
		return cookieName;
	}

	public void setCookieName(String cookieName) {
		this.cookieName = cookieName;
	}

	public String getCookiePath() {
		return cookiePath;
	}

	public void setCookiePath(String cookiePath) {
		this.cookiePath = cookiePath;
	}

	public String getCookieSameSite() {
		return cookieSameSite;
	}

	public void setCookieSameSite(String cookieSameSite) {
		this.cookieSameSite = cookieSameSite;
	}

	public boolean isCookieSecure() {
		return cookieSecure;
	}

	public void setCookieSecure(boolean cookieSecure) {
		this.cookieSecure = cookieSecure;
	}

	public boolean isTrustForwardedFor() {
		return trustForwardedFor;
	}

	public void setTrustForwardedFor(boolean trustForwardedFor) {
		this.trustForwardedFor = trustForwardedFor;
	}
}
