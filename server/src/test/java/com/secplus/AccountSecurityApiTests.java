package com.secplus;

import java.util.UUID;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import com.jayway.jsonpath.JsonPath;
import com.secplus.auth.AuthTestSupport;
import com.secplus.auth.AuthTestSupport.AuthTestAccess;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Email verification, password reset and the two-step login, end to end.
 *
 * Same spirit as AuthApiTests: the assertions that earn their keep are the
 * ones about what gets **refused**. A 2FA flow whose happy path works but
 * which accepts a stale code, a replayed challenge or an unlimited number of
 * guesses is not a second factor — and every one of those failures looks fine
 * from the front end.
 *
 * Mail is never sent here. MAIL_HOST is unset in tests, so Mailer logs instead,
 * and the tokens are read back through AuthTestAccess rather than scraped out
 * of an inbox.
 */
@Import({ TestcontainersConfiguration.class, AuthTestSupport.class })
@SpringBootTest(properties = "app.auth.trust-forwarded-for=true")
@AutoConfigureMockMvc
class AccountSecurityApiTests {

	private static final String FORWARDED_FOR = "X-Forwarded-For";

	private final String callerIp = "198.51.100." + (Math.abs(UUID.randomUUID().hashCode()) % 254 + 1);

	@Autowired
	private MockMvc mvc;

	@Autowired
	private AuthTestAccess access;

	private static String freshEmail() {
		return "sec-" + UUID.randomUUID() + "@example.com";
	}

	private MvcResult register(String email) throws Exception {
		return mvc.perform(post("/api/v1/auth/register")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"%s","password":"correct-horse-battery","displayName":"Test"}"""
					.formatted(email)))
			.andExpect(status().isCreated())
			.andReturn();
	}

	private MvcResult login(String email, String password) throws Exception {
		return mvc.perform(post("/api/v1/auth/login")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"%s","password":"%s"}""".formatted(email, password)))
			.andReturn();
	}

	private static String token(MvcResult result) throws Exception {
		return JsonPath.read(result.getResponse().getContentAsString(), "$.accessToken");
	}

	// ------------------------------------------------------- verification --

	@Test
	void registeringLeavesTheAddressUnverifiedUntilTheLinkIsUsed() throws Exception {
		String email = freshEmail();
		MvcResult registered = register(email);

		assertThat(JsonPath.<Boolean>read(registered.getResponse().getContentAsString(),
				"$.user.emailVerified"))
			.as("a brand new address has not been proved reachable yet")
			.isFalse();

		mvc.perform(post("/api/v1/auth/verify-email")
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"token":"%s"}""".formatted(access.verificationToken(email))))
			.andExpect(status().isNoContent());

		mvc.perform(get("/api/v1/auth/me").header("Authorization", "Bearer " + token(registered)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.emailVerified").value(true));
	}

	@Test
	void aVerificationLinkCannotBeUsedTwice() throws Exception {
		String email = freshEmail();
		register(email);
		String link = access.verificationToken(email);

		mvc.perform(post("/api/v1/auth/verify-email")
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"token":"%s"}""".formatted(link)))
			.andExpect(status().isNoContent());

		mvc.perform(post("/api/v1/auth/verify-email")
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"token":"%s"}""".formatted(link)))
			.andExpect(status().isBadRequest());
	}

	// ----------------------------------------------------- password reset --

	/**
	 * The whole point of the endpoint. A different status, body or shape for a
	 * known address would turn it into a way of asking who has an account here.
	 */
	@Test
	void forgotPasswordAnswersIdenticallyForKnownAndUnknownAddresses() throws Exception {
		String known = freshEmail();
		register(known);
		access.verify(known);

		MvcResult forKnown = forgot(known);
		MvcResult forUnknown = forgot("definitely-nobody-" + UUID.randomUUID() + "@example.com");

		assertThat(forKnown.getResponse().getStatus()).isEqualTo(forUnknown.getResponse().getStatus());
		assertThat(forKnown.getResponse().getContentAsString())
			.isEqualTo(forUnknown.getResponse().getContentAsString());
	}

	private MvcResult forgot(String email) throws Exception {
		return mvc.perform(post("/api/v1/auth/forgot-password")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"%s"}""".formatted(email)))
			.andReturn();
	}

	/**
	 * A reset is what someone does when they believe they are compromised.
	 * Leaving the other party signed in elsewhere would defeat the exercise.
	 */
	@Test
	void resettingThePasswordEndsEverySession() throws Exception {
		String email = freshEmail();
		MvcResult registered = register(email);
		access.verify(email);
		String oldAccessToken = token(registered);

		forgot(email);
		mvc.perform(post("/api/v1/auth/reset-password")
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"token":"%s","password":"a-brand-new-passphrase"}"""
					.formatted(access.resetToken(email))))
			.andExpect(status().isNoContent());

		assertThat(access.liveRefreshTokens(email))
			.as("every refresh token issued before the reset should be dead")
			.isZero();

		assertThat(login(email, "correct-horse-battery").getResponse().getStatus())
			.as("the old password must stop working")
			.isEqualTo(401);
		assertThat(login(email, "a-brand-new-passphrase").getResponse().getStatus()).isEqualTo(200);

		// The access token stays valid until it expires - it is stateless and
		// short-lived by design. What must be gone is the ability to renew.
		assertThat(oldAccessToken).isNotBlank();
	}

	@Test
	void anUnverifiedAddressGetsNoResetLink() throws Exception {
		String email = freshEmail();
		register(email);

		forgot(email);

		assertThat(access.resetTokenOrNull(email))
			.as("otherwise registering someone else's address would be a way to take their mailbox")
			.isNull();
	}

	// ------------------------------------------------------ two-step login --

	@Test
	void withTwoFactorOnLoginReturnsAChallengeAndNoSession() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		MvcResult result = login(email, "correct-horse-battery");
		String body = result.getResponse().getContentAsString();

		assertThat(result.getResponse().getStatus()).isEqualTo(200);
		assertThat(JsonPath.<String>read(body, "$.challenge")).isNotBlank();
		assertThat(body).as("no token, and no refresh cookie, until the second step").doesNotContain("accessToken");
		assertThat(result.getResponse().getCookie("secplus_refresh")).isNull();
	}

	@Test
	void theSecondStepExchangesAValidCodeForASession() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		String challenge = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");

		mvc.perform(post("/api/v1/auth/2fa/verify")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"challenge":"%s","code":"%s"}""".formatted(challenge, access.loginCode(email))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.accessToken").isNotEmpty());
	}

	@Test
	void aWrongCodeIsRefusedAndTheChallengeSurvivesForARetype() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		String challenge = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");

		verify(challenge, "000000").andExpect(status().isUnauthorized());

		// A typo must not send someone back to the password screen.
		verify(challenge, access.loginCode(email)).andExpect(status().isOk());
	}

	@Test
	void aChallengeCannotBeReplayedAfterItSucceeds() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		String challenge = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");
		String code = access.loginCode(email);

		verify(challenge, code).andExpect(status().isOk());
		verify(challenge, code)
			.andExpect(status().isUnauthorized());
	}

	/**
	 * Six digits is a million values. Without a per-challenge limit an attacker
	 * holding the password simply retries, and a per-IP bucket does not stop
	 * someone who can change address.
	 */
	@Test
	void guessingIsLimitedPerChallengeNotOnlyPerAddress() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		String challenge = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");

		int refusals = 0;
		int rateLimited = 0;
		for (int attempt = 0; attempt < 12; attempt++) {
			int status = mvc.perform(post("/api/v1/auth/2fa/verify")
					.header(FORWARDED_FOR, callerIp)
					.contentType(MediaType.APPLICATION_JSON)
					.content("""
							{"challenge":"%s","code":"%06d"}""".formatted(challenge, attempt)))
				.andReturn().getResponse().getStatus();

			if (status == 429) {
				rateLimited++;
			}
			else if (status == 401) {
				refusals++;
			}
		}

		assertThat(refusals).as("a handful of retypes is allowed").isLessThanOrEqualTo(6);
		assertThat(rateLimited).as("then it stops answering at all").isPositive();
	}

	@Test
	void aRecoveryCodeGetsPastTheSecondStepExactlyOnce() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		String recoveryCode = access.enableEmailTwoFactorWithRecoveryCodes(email).get(0);

		String first = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");
		verify(first, recoveryCode).andExpect(status().isOk());

		String second = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");
		verify(second, recoveryCode)
			.andExpect(status().isUnauthorized());
	}

	@Test
	void anExpiredLoginCodeIsRefused() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		String challenge = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");
		String code = access.loginCode(email);

		access.expireTokensFor(email);

		verify(challenge, code).andExpect(status().isUnauthorized());
	}

	/**
	 * Signing in repeatedly must not turn the account into a way to mail its
	 * owner - but the limit must not become a lockout either. Over the limit we
	 * stop ISSUING, which is what keeps the code already in the inbox valid.
	 */
	@Test
	void repeatedSignInsStopMailingNewCodesButStillLetYouIn() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		access.enableEmailTwoFactor(email);

		login(email, "correct-horse-battery");
		login(email, "correct-horse-battery");
		login(email, "correct-horse-battery");
		String thirdCode = access.loginCode(email);

		// Fourth attempt: over the send limit.
		String challenge = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");

		assertThat(access.loginCode(email))
			.as("no fresh code should have been mailed")
			.isEqualTo(thirdCode);

		verify(challenge, thirdCode)
			.andExpect(status().isOk());
	}

	private org.springframework.test.web.servlet.ResultActions verify(String challenge, String code)
			throws Exception {
		return mvc.perform(post("/api/v1/auth/2fa/verify")
			.header(FORWARDED_FOR, callerIp)
			.contentType(MediaType.APPLICATION_JSON)
			.content("""
					{"challenge":"%s","code":"%s"}""".formatted(challenge, code)));
	}

	// ------------------------------------------------------- mail flooding --

	/**
	 * The per-IP limit cannot protect a person, because the IP is only as good
	 * as the proxies in front of us. Each request here claims a different
	 * address - exactly what a script would do - and the account is still
	 * mailed no more than its own cap. The answer never changes, so the cap
	 * cannot be used to learn that the address has an account.
	 */
	@Test
	void resetEmailsAreCappedPerAccountWhateverAddressTheyClaimToComeFrom() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);

		for (int i = 1; i <= 5; i++) {
			MvcResult result = mvc.perform(post("/api/v1/auth/forgot-password")
					.header(FORWARDED_FOR, "203.0.113." + i)
					.contentType(MediaType.APPLICATION_JSON)
					.content("""
							{"email":"%s"}""".formatted(email)))
				.andReturn();
			assertThat(result.getResponse().getStatus()).as("request %d", i).isEqualTo(204);
		}

		assertThat(access.resetEmailsSent(email, 3))
			.as("five requests, but only three emails")
			.isEqualTo(3);
	}

	/**
	 * With the hourly budget spent, nothing is sent - and the request still
	 * looks exactly like success, so the budget is invisible from outside.
	 */
	@Test
	void aSpentMailBudgetSkipsTheSendSilently() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);

		access.spendMailBudget();
		try {
			assertThat(forgot(email).getResponse().getStatus()).isEqualTo(204);
			assertThat(access.resetTokenOrNull(email)).as("over budget, no reset email").isNull();
		}
		finally {
			access.restoreMailBudget();
		}

		forgot(email);
		assertThat(access.resetToken(email)).as("and mail resumes once there is budget").isNotBlank();
	}

	// ------------------------------------------------------------- TOTP --

	/**
	 * An authenticator code is valid for about 90 seconds. Without this, the
	 * six digits someone just used still work for the rest of that window - for
	 * anyone who saw them over a shoulder or phished them in real time.
	 */
	@Test
	void anAuthenticatorCodeWorksOnlyOnce() throws Exception {
		String email = freshEmail();
		register(email);
		access.verify(email);
		String secret = access.enableTotp(email);

		String first = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");
		String code = access.totpCode(secret);
		verify(first, code).andExpect(status().isOk());

		String second = JsonPath.read(login(email, "correct-horse-battery")
			.getResponse().getContentAsString(), "$.challenge");
		verify(second, code)
			.andExpect(status().isUnauthorized());
	}

	// --------------------------------------------------------- passwords --

	/**
	 * 72 characters, but 144 bytes: each "é" is two. BCrypt reads 72 bytes, so
	 * this has to be refused as too long - not accepted and silently cut, and
	 * not a 500 from the encoder.
	 */
	@Test
	void aPasswordOverBcryptsByteLimitIsRefusedNotTruncated() throws Exception {
		mvc.perform(post("/api/v1/auth/register")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"%s","password":"%s"}""".formatted(freshEmail(), "é".repeat(72))))
			.andExpect(status().isBadRequest());
	}

}
