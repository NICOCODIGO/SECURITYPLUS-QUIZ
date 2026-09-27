package com.secplus.auth;

import java.nio.charset.StandardCharsets;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** What the API accepts. */
public final class AuthRequests {

	private AuthRequests() {
	}

	/** BCrypt reads at most this many bytes of a password. */
	static final int BCRYPT_MAX_BYTES = 72;

	/**
	 * Whether BCrypt will see all of `password`.
	 *
	 * Bytes, not characters: `@Size(max = 72)` counts characters, and an
	 * accented letter or an emoji is two to four bytes, so a password can pass
	 * that and still be too long. Null counts as fitting; @NotBlank reports it.
	 */
	static boolean fitsBcrypt(String password) {
		return password == null || password.getBytes(StandardCharsets.UTF_8).length <= BCRYPT_MAX_BYTES;
	}

	/**
	 * The 72-byte password ceiling is **not** arbitrary and must not be relaxed:
	 * BCrypt truncates its input at 72 bytes, so without the cap a longer
	 * passphrase is silently cut and two different passwords open the same
	 * account. The minimum of 10 is a length floor rather than a character-class
	 * rule, which is both friendlier and stronger.
	 */
	public record RegisterRequest(
			@NotBlank @Email @Size(max = 320) String email,
			@NotBlank @Size(min = 10, max = 72) String password,
			@Size(max = 80) String displayName) {

		@AssertTrue(message = "is too long: at most 72 bytes, and some characters take more than one")
		public boolean isPasswordWithinLimit() {
			return fitsBcrypt(password);
		}
	}

	/**
	 * Login deliberately does not reuse RegisterRequest's constraints. A
	 * tightened password rule must never turn an existing account's sign-in
	 * into a 400 — that would lock people out of their own data on the day the
	 * policy changed.
	 */
	public record LoginRequest(@NotBlank String email, @NotBlank String password) {
	}

	/**
	 * The second step. `code` is a six-digit code OR a recovery code - one field,
	 * because making the person first classify what they are holding is friction
	 * that buys nothing; the server can tell by shape.
	 */
	public record TwoFactorVerifyRequest(@NotBlank String challenge, @NotBlank @Size(max = 32) String code) {
	}

	public record VerifyEmailRequest(@NotBlank String token) {
	}

	public record ForgotPasswordRequest(@NotBlank @Email @Size(max = 320) String email) {
	}

	/**
	 * Same 10..72 bound as registration, and for the same reason: BCrypt
	 * truncates at 72 bytes, so a longer passphrase would be silently cut and
	 * two different passwords would open the account.
	 */
	public record ResetPasswordRequest(@NotBlank String token, @NotBlank @Size(min = 10, max = 72) String password) {

		@AssertTrue(message = "is too long: at most 72 bytes, and some characters take more than one")
		public boolean isPasswordWithinLimit() {
			return fitsBcrypt(password);
		}
	}

	public record TwoFactorSetupRequest(@NotBlank String method) {
	}

	public record TwoFactorConfirmRequest(@NotBlank String method, @NotBlank @Size(max = 32) String code) {
	}

	/** Turning 2FA off, or reissuing recovery codes, costs the password. */
	public record PasswordConfirmRequest(@NotBlank String password) {
	}
}
