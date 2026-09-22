package com.secplus;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

import javax.crypto.spec.SecretKeySpec;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwsHeader;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.security.oauth2.jwt.NimbusJwtEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import com.jayway.jsonpath.JsonPath;
import com.nimbusds.jose.jwk.source.ImmutableSecret;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Auth, end to end against real Postgres.
 *
 * Written in the spirit of SchemaMigrationTests: assert that things are
 * actually **rejected**, not merely that the happy path returns 200. The
 * assertions that matter most here are the two nobody writes by default —
 * that the login failure messages are byte-identical, and that reusing a
 * rotated refresh token kills the whole family.
 */
@Import(TestcontainersConfiguration.class)
// Every request in this class comes from 127.0.0.1, so without per-test
// isolation the register limiter would trip partway through the class and the
// failures would look like auth bugs. Trusting X-Forwarded-For here lets each
// test claim its own bucket through the real code path — and exercises that
// the header is honoured when, and only when, the deployment says to.
@SpringBootTest(properties = "app.auth.trust-forwarded-for=true")
@AutoConfigureMockMvc
class AuthApiTests {

	private static final String CLIENT_HEADER = "X-Secplus-Client";

	private static final String FORWARDED_FOR = "X-Forwarded-For";

	/** A distinct caller per test, so one test's attempts never limit another's. */
	private final String callerIp = "203.0.113." + (Math.abs(UUID.randomUUID().hashCode()) % 254 + 1);

	@Autowired
	private MockMvc mvc;

	@Autowired
	private SecretKeySpec signingKey;

	private static String accessToken(MvcResult result) throws Exception {
		return JsonPath.read(result.getResponse().getContentAsString(), "$.accessToken");
	}

	/** Unique per test so the suite can run in any order against one database. */
	private static String freshEmail() {
		return "user-" + UUID.randomUUID() + "@example.com";
	}

	private MvcResult register(String email, String password) throws Exception {
		return mvc.perform(post("/api/v1/auth/register")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"%s","password":"%s","displayName":"Test"}""".formatted(email, password)))
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

	private static String cookieValue(MvcResult result, String name) {
		return result.getResponse().getCookie(name) == null ? null
				: result.getResponse().getCookie(name).getValue();
	}

	/* ---------------------------------------------------------- register -- */

	@Test
	void registerCreatesAnAccountAndSetsAnHttpOnlyRefreshCookie() throws Exception {
		MvcResult result = register(freshEmail(), "correct horse battery");

		assertThat(result.getResponse().getStatus()).isEqualTo(201);

		String body = result.getResponse().getContentAsString();
		assertThat(accessToken(result)).isNotBlank();
		assertThat(JsonPath.<String>read(body, "$.user.email")).contains("@example.com");
		// The refresh token must never reach a response body.
		assertThat(body).doesNotContain("refreshToken");

		String setCookie = result.getResponse().getHeader(HttpHeaders.SET_COOKIE);
		assertThat(setCookie).contains("HttpOnly").contains("SameSite=Strict")
			.contains("Path=/api/v1/auth");
	}

	@Test
	void theSameEmailInADifferentCaseIsRejected() throws Exception {
		String email = freshEmail();
		assertThat(register(email, "correct horse battery").getResponse().getStatus()).isEqualTo(201);

		// Proves users_email_lower_idx is what enforces uniqueness, not Java.
		MvcResult duplicate = register(email.toUpperCase(), "correct horse battery");
		assertThat(duplicate.getResponse().getStatus()).isEqualTo(409);
	}

	@Test
	void aShortPasswordIsRejectedAsAProblemDetail() throws Exception {
		mvc.perform(post("/api/v1/auth/register")
				.header(FORWARDED_FOR, callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"%s","password":"short","displayName":"Test"}""".formatted(freshEmail())))
			.andExpect(status().isBadRequest())
			// spring.mvc.problemdetails.enabled — without it this is Spring's
			// default error body and the front end cannot parse it.
			.andExpect(jsonPath("$.title").exists());
	}

	/* ------------------------------------------------------------- login -- */

	@Test
	void anUnknownEmailAndAWrongPasswordFailIdentically() throws Exception {
		String email = freshEmail();
		register(email, "correct horse battery");

		MvcResult wrongPasswordResult = login(email, "wrong horse battery");
		assertThat(wrongPasswordResult.getResponse().getStatus()).isEqualTo(401);
		String wrongPassword = wrongPasswordResult.getResponse().getContentAsString();

		MvcResult unknownEmailResult = login(freshEmail(), "wrong horse battery");
		assertThat(unknownEmailResult.getResponse().getStatus()).isEqualTo(401);
		String unknownEmail = unknownEmailResult.getResponse().getContentAsString();

		// Byte-identical, or the endpoint answers "does this person have an
		// account here?" — which is the whole reason the message is generic.
		assertThat(wrongPassword).isEqualTo(unknownEmail);
	}

	@Test
	void loginSucceedsWithTheRightPassword() throws Exception {
		String email = freshEmail();
		register(email, "correct horse battery");

		MvcResult result = login(email, "correct horse battery");

		assertThat(result.getResponse().getStatus()).isEqualTo(200);
		assertThat(accessToken(result)).isNotBlank();
	}

	/* --------------------------------------------------------------- me -- */

	@Test
	void meNeedsATokenAndReturnsTheRightAccount() throws Exception {
		mvc.perform(get("/api/v1/auth/me")).andExpect(status().isUnauthorized());

		String email = freshEmail();
		String token = accessToken(register(email, "correct horse battery"));

		mvc.perform(get("/api/v1/auth/me").header(HttpHeaders.AUTHORIZATION, "Bearer " + token))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.email").value(email.toLowerCase()));
	}

	@Test
	void aTokenSignedWithAnotherKeyIs401NotAnError() throws Exception {
		byte[] other = new byte[32];
		java.util.Arrays.fill(other, (byte) 7);
		JwtEncoder attacker = new NimbusJwtEncoder(
				new ImmutableSecret<>(new SecretKeySpec(other, "HmacSHA256")));

		Instant now = Instant.now();
		String forged = attacker.encode(JwtEncoderParameters.from(
				JwsHeader.with(MacAlgorithm.HS256).build(),
				JwtClaimsSet.builder()
					.issuer("secplus-api")
					.issuedAt(now)
					.expiresAt(now.plus(15, ChronoUnit.MINUTES))
					.subject(UUID.randomUUID().toString())
					.claim("roles", List.of("USER"))
					.build()))
			.getTokenValue();

		// 401, never 500 — a bad signature is a client problem, not a server one.
		mvc.perform(get("/api/v1/auth/me").header(HttpHeaders.AUTHORIZATION, "Bearer " + forged))
			.andExpect(status().isUnauthorized());
	}

	@Test
	void anExpiredTokenIsRejected() throws Exception {
		JwtEncoder ours = new NimbusJwtEncoder(new ImmutableSecret<>(signingKey));
		Instant longAgo = Instant.now().minus(2, ChronoUnit.HOURS);

		String expired = ours.encode(JwtEncoderParameters.from(
				JwsHeader.with(MacAlgorithm.HS256).build(),
				JwtClaimsSet.builder()
					.issuer("secplus-api")
					.issuedAt(longAgo)
					.expiresAt(longAgo.plus(15, ChronoUnit.MINUTES))
					.subject(UUID.randomUUID().toString())
					.claim("roles", List.of("USER"))
					.build()))
			.getTokenValue();

		mvc.perform(get("/api/v1/auth/me").header(HttpHeaders.AUTHORIZATION, "Bearer " + expired))
			.andExpect(status().isUnauthorized());
	}

	/* ---------------------------------------------------------- refresh -- */

	@Test
	void refreshRotatesTheCookie() throws Exception {
		MvcResult registered = register(freshEmail(), "correct horse battery");
		String first = cookieValue(registered, "secplus_refresh");

		MvcResult refreshed = mvc.perform(post("/api/v1/auth/refresh")
				.header(CLIENT_HEADER, "web")
				.cookie(registered.getResponse().getCookie("secplus_refresh")))
			.andExpect(status().isOk())
			.andReturn();

		String second = cookieValue(refreshed, "secplus_refresh");
		assertThat(second).isNotNull().isNotEqualTo(first);
	}

	@Test
	void reusingARotatedTokenRevokesTheWholeFamily() throws Exception {
		MvcResult registered = register(freshEmail(), "correct horse battery");
		jakarta.servlet.http.Cookie a = registered.getResponse().getCookie("secplus_refresh");

		MvcResult rotated = mvc.perform(post("/api/v1/auth/refresh")
				.header(CLIENT_HEADER, "web").cookie(a))
			.andExpect(status().isOk())
			.andReturn();
		jakarta.servlet.http.Cookie b = rotated.getResponse().getCookie("secplus_refresh");

		// Presenting A again means it leaked, or the client raced itself.
		mvc.perform(post("/api/v1/auth/refresh").header(CLIENT_HEADER, "web").cookie(a))
			.andExpect(status().isUnauthorized());

		// ...and the token that replaced it dies with it. This is the assertion
		// that distinguishes real reuse detection from merely refusing A twice.
		mvc.perform(post("/api/v1/auth/refresh").header(CLIENT_HEADER, "web").cookie(b))
			.andExpect(status().isUnauthorized());
	}

	@Test
	void refreshWithoutTheClientHeaderIsRejected() throws Exception {
		MvcResult registered = register(freshEmail(), "correct horse battery");

		// The CSRF defence: a cross-site request cannot set this header.
		mvc.perform(post("/api/v1/auth/refresh")
				.cookie(registered.getResponse().getCookie("secplus_refresh")))
			.andExpect(status().is4xxClientError());
	}

	@Test
	void refreshWithNoCookieIs401() throws Exception {
		mvc.perform(post("/api/v1/auth/refresh").header(CLIENT_HEADER, "web"))
			.andExpect(status().isUnauthorized());
	}

	/* ----------------------------------------------------------- logout -- */

	@Test
	void logoutClearsTheCookieAndKillsTheSession() throws Exception {
		MvcResult registered = register(freshEmail(), "correct horse battery");
		jakarta.servlet.http.Cookie cookie = registered.getResponse().getCookie("secplus_refresh");

		MvcResult loggedOut = mvc.perform(post("/api/v1/auth/logout")
				.header(CLIENT_HEADER, "web").cookie(cookie))
			.andExpect(status().isNoContent())
			.andReturn();

		assertThat(loggedOut.getResponse().getHeader(HttpHeaders.SET_COOKIE)).contains("Max-Age=0");

		mvc.perform(post("/api/v1/auth/refresh").header(CLIENT_HEADER, "web").cookie(cookie))
			.andExpect(status().isUnauthorized());
	}

	/* ------------------------------------------------------- regression -- */

	@Test
	void theQuestionBankStaysPublicWithAndWithoutAToken() throws Exception {
		// Adding a resource server to a chain that serves a free question bank
		// is exactly where "everything is free without an account" breaks.
		mvc.perform(get("/api/v1/questions").param("limit", "1")).andExpect(status().isOk());

		String token = accessToken(register(freshEmail(), "correct horse battery"));

		mvc.perform(get("/api/v1/questions").param("limit", "1")
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token))
			.andExpect(status().isOk());
	}
}
