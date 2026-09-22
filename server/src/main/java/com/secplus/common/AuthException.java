package com.secplus.common;

import org.springframework.http.HttpStatus;

/**
 * An auth failure the caller is allowed to see.
 *
 * The message is part of the API: it is shown to a person. Messages must stay
 * generic enough not to answer questions the caller has no right to ask —
 * above all, whether a given email has an account here. See AuthService.
 */
public class AuthException extends RuntimeException {

	private final HttpStatus status;

	/** Seconds for a Retry-After header; 0 when the failure is not rate limiting. */
	private final long retryAfterSeconds;

	public AuthException(HttpStatus status, String message) {
		this(status, message, 0);
	}

	public AuthException(HttpStatus status, String message, long retryAfterSeconds) {
		super(message);
		this.status = status;
		this.retryAfterSeconds = retryAfterSeconds;
	}

	public HttpStatus getStatus() {
		return status;
	}

	public long getRetryAfterSeconds() {
		return retryAfterSeconds;
	}
}
