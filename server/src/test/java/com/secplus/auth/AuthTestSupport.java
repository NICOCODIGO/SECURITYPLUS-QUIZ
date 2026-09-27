package com.secplus.auth;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Supplier;

import javax.sql.DataSource;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.transaction.annotation.Transactional;

/**
 * Test-only reach into the auth package.
 *
 * Lives in `com.secplus.auth` so it can touch the package-private pieces the
 * production code keeps closed — none of this widens the real API surface.
 *
 * The central problem it solves: **tokens are SHA-256 hashed at rest**, so a
 * test cannot read back the link that was mailed, by design. Rather than
 * weakening that, the Mailer is replaced with one that records what it was
 * asked to send. Assertions then read the way the requirement does — "a reset
 * email went out, carrying this token" — instead of reaching into storage.
 */
@TestConfiguration
public class AuthTestSupport {

	/**
	 * How long an accessor waits for a recorded message before giving up.
	 *
	 * Mailer's methods are `@Async`, and overriding one without the annotation
	 * does NOT reliably make it synchronous — Spring resolves `@Async` through
	 * the superclass method, so the override can still be advised as async.
	 *
	 * Making the test executor synchronous instead looks tidier and is a trap:
	 * a `@TestConfiguration` that implements `AsyncConfigurer` collides with the
	 * one Boot already registers, and the context fails to load with an error
	 * about factory methods that names neither async nor mail.
	 *
	 * So the accessors simply wait. Slower to fail, impossible to get wrong.
	 */
	private static final long AWAIT_MILLIS = 2_000;

	/** Records what it was asked to send instead of sending it. */
	public static class RecordingMailer extends Mailer {

		private final Map<String, String> verifications = new ConcurrentHashMap<>();

		private final Map<String, String> resets = new ConcurrentHashMap<>();

		private final Map<String, String> loginCodes = new ConcurrentHashMap<>();

		RecordingMailer(JavaMailSender sender) {
			super(sender, "", "no-reply@test.invalid", "http://localhost:5173");
		}

		@Override
		public void sendVerification(String to, String token) {
			this.verifications.put(to.toLowerCase(), token);
		}

		@Override
		public void sendPasswordReset(String to, String token) {
			this.resets.put(to.toLowerCase(), token);
		}

		@Override
		public void sendLoginCode(String to, String code) {
			this.loginCodes.put(to.toLowerCase(), code);
		}

		// Read through METHODS, never the fields directly.
		//
		// Mailer's methods carry @Async, so Spring wraps this bean in a CGLIB
		// proxy - and a CGLIB proxy is instantiated WITHOUT running constructors
		// or field initialisers. `proxy.verifications` is therefore null, while
		// the target's map is perfectly populated. A method call is delegated to
		// the target; a field read is not.
		//
		// It is also why the writes above always worked: sendVerification runs on
		// the target, so `this.verifications` there is the real map. Only reads
		// from outside hit the proxy, which is what made the failure look like
		// the recording silently not happening.

		String recordedVerification(String to) {
			return this.verifications.get(to.toLowerCase());
		}

		String recordedReset(String to) {
			return this.resets.get(to.toLowerCase());
		}

		String recordedLoginCode(String to) {
			return this.loginCodes.get(to.toLowerCase());
		}

	}

	@Bean
	@Primary
	RecordingMailer recordingMailer(JavaMailSender sender) {
		return new RecordingMailer(sender);
	}

	@Bean
	AuthTestAccess authTestAccess(UserRepository users, RecoveryCodeService recoveryCodes,
			RecordingMailer mailer, DataSource dataSource) {
		return new AuthTestAccess(users, recoveryCodes, mailer, dataSource);
	}

	/** What the tests actually call. */
	public static class AuthTestAccess {

		private final UserRepository users;

		private final RecoveryCodeService recoveryCodes;

		private final RecordingMailer mailer;

		private final JdbcClient db;

		AuthTestAccess(UserRepository users, RecoveryCodeService recoveryCodes, RecordingMailer mailer,
				DataSource dataSource) {
			this.users = users;
			this.recoveryCodes = recoveryCodes;
			this.mailer = mailer;
			this.db = JdbcClient.create(dataSource);
		}

		// ------------------------------------------------ what was mailed --

		public String verificationToken(String email) {
			return await(() -> mailer.recordedVerification(email), email, "verification email");
		}

		public String resetToken(String email) {
			return await(() -> mailer.recordedReset(email), email, "reset email");
		}

		/**
		 * Null when no reset email was sent, which is itself the assertion in one
		 * test.
		 *
		 * Deliberately does NOT wait — waiting two seconds to conclude "nothing
		 * arrived" would be right, but the one caller has already made a request
		 * and awaited its response, so anything queued has had its chance.
		 */
		public String resetTokenOrNull(String email) {
			return mailer.recordedReset(email);
		}

		public String loginCode(String email) {
			return await(() -> mailer.recordedLoginCode(email), email, "login code");
		}

		/** Polls briefly, because the send may be on another thread. See AWAIT_MILLIS. */
		private static String await(Supplier<String> read, String email, String what) {
			long deadline = System.currentTimeMillis() + AWAIT_MILLIS;

			while (System.currentTimeMillis() < deadline) {
				String value = read.get();
				if (value != null) {
					return value;
				}
				try {
					Thread.sleep(25);
				}
				catch (InterruptedException e) {
					Thread.currentThread().interrupt();
					break;
				}
			}
			return required(read.get(), what, email);
		}

		private static String required(String value, String what, String email) {
			if (value == null) {
				throw new AssertionError("No " + what + " was sent to " + email);
			}
			return value;
		}

		// --------------------------------------------------- account state --

		@Transactional
		public void verify(String email) {
			user(email).markEmailVerified();
		}

		@Transactional
		public void enableEmailTwoFactor(String email) {
			user(email).enableTwoFactor(TwoFactorMethod.EMAIL, null);
		}

		@Transactional
		public List<String> enableEmailTwoFactorWithRecoveryCodes(String email) {
			User user = user(email);
			user.enableTwoFactor(TwoFactorMethod.EMAIL, null);
			return this.recoveryCodes.regenerate(user.getId());
		}

		/** Refresh tokens that could still be exchanged for a session. */
		public int liveRefreshTokens(String email) {
			return this.db.sql("""
					select count(*)
					  from refresh_tokens t
					  join users u on u.id = t.user_id
					 where lower(u.email) = lower(:email)
					   and t.revoked_at is null
					   and t.expires_at > now()
					""")
				.param("email", email)
				.query(Integer.class)
				.single();
		}

		/** Ages every outstanding token past its expiry, without waiting ten minutes. */
		@Transactional
		public void expireTokensFor(String email) {
			this.db.sql("""
					update user_tokens
					   set expires_at = now() - interval '1 minute'
					 where user_id = :userId
					""")
				.param("userId", userId(email))
				.update();
		}

		public UUID userId(String email) {
			return user(email).getId();
		}

		private User user(String email) {
			Optional<User> found = this.users.findByEmail(email);
			return found.orElseThrow(() -> new AssertionError("No account for " + email));
		}

	}

}
