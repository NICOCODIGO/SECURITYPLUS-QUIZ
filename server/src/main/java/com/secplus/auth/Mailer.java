package com.secplus.auth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * The three emails this app sends: verify your address, reset your password,
 * and here is your sign-in code.
 *
 * **Sending never fails the request that triggered it.** A registration that
 * returns 500 because SMTP hiccuped is worse than one whose verification email
 * arrives late — the account exists either way, and every one of these has a
 * resend path. Failures are logged with the request id and swallowed.
 *
 * **With no host configured, the message is logged instead of sent.** That is
 * the local default, so the whole auth flow can be walked through from a clean
 * checkout with no SES account, no credentials and no network — the same
 * principle as the app working with `VITE_API_URL` unset.
 *
 * Plain text, not HTML. HTML mail means rendering quirks across clients and a
 * worse spam score, in exchange for styling nobody reads in a six-digit code.
 */
@Service
public class Mailer {

	private static final Logger log = LoggerFactory.getLogger(Mailer.class);

	private final JavaMailSender sender;

	private final String from;

	private final String baseUrl;

	private final boolean configured;

	Mailer(JavaMailSender sender,
			@Value("${spring.mail.host:}") String host,
			@Value("${app.mail.from}") String from,
			@Value("${app.mail.base-url}") String baseUrl) {
		this.sender = sender;
		this.from = from;
		this.baseUrl = baseUrl.replaceAll("/+$", "");
		this.configured = !host.isBlank();

		if (!configured) {
			log.warn("No MAIL_HOST set - emails will be logged instead of sent.");
		}
	}

	@Async
	public void sendVerification(String to, String token) {
		send(to, "Confirm your email address", """
				Welcome to the Security+ study platform.

				Confirm your email address so you can reset your password if you
				ever need to:

				%s/verify-email?token=%s

				The link works for 24 hours. If you did not create an account,
				you can ignore this email.
				""".formatted(baseUrl, token));
	}

	@Async
	public void sendPasswordReset(String to, String token) {
		send(to, "Reset your password", """
				We received a request to reset the password for your account.

				%s/reset-password?token=%s

				The link works for one hour and can only be used once. Changing
				your password signs you out on all devices.

				If you did not request this, you can ignore this email. Your
				password will not change.
				""".formatted(baseUrl, token));
	}

	@Async
	public void sendLoginCode(String to, String code) {
		send(to, "Your sign-in code: " + code, """
				Your sign-in code is %s

				It expires in ten minutes and can only be used once.

				If you did not try to sign in, someone may know your password.
				Reset it from the sign-in page.
				""".formatted(code));
	}

	/**
	 * The public methods carry `@Async`, not this one. Spring routes async
	 * through a proxy, and a call from one method of this class to another
	 * never touches that proxy - so `@Async` here would silently do nothing
	 * while looking correct. The same self-invocation trap as TokenFamilyRevoker.
	 */
	private void send(String to, String subject, String body) {
		if (!configured) {
			// Local development: the token is in the log, so the flow is still
			// walkable end to end without a mail provider.
			log.info("MAIL (not sent, no host) to={} subject={}\n{}", to, subject, body);
			return;
		}

		try {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom(from);
			message.setTo(to);
			message.setSubject(subject);
			message.setText(body);
			sender.send(message);
			log.info("Sent \"{}\" to {}", subject, to);
		} catch (Exception e) {
			// Deliberately broad, and deliberately not rethrown. In SES sandbox
			// this is the everyday case: sending to any address that is not
			// verified fails, and that must not break registration.
			log.error("Could not send \"{}\" to {}: {}", subject, to, e.getMessage());
		}
	}
}
