package com.secplus;

import java.util.UUID;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import com.jayway.jsonpath.JsonPath;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * One account's study data, end to end against real Postgres.
 *
 * The two assertions that matter most are the ones nobody writes by default:
 * that a second post of the same attempt does not duplicate it, and that one
 * account cannot read another's history. The second is what docs/backend.md
 * asks for by name, and the only thing standing behind it is a `where user_id`
 * in every statement.
 */
@Import(TestcontainersConfiguration.class)
@SpringBootTest(properties = "app.auth.trust-forwarded-for=true")
@AutoConfigureMockMvc
class MeApiTests {

	@Autowired
	private MockMvc mvc;

	/** A distinct caller per test, so the register rate limiter never trips. */
	private final String callerIp = "198.51.100." + (Math.abs(UUID.randomUUID().hashCode()) % 254 + 1);

	/** Registers a fresh account and returns its bearer token. */
	private String account() throws Exception {
		MvcResult result = mvc.perform(post("/api/v1/auth/register")
				.header("X-Forwarded-For", callerIp)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						{"email":"me-%s@example.com","password":"correct horse battery"}"""
					.formatted(UUID.randomUUID())))
			.andExpect(status().isCreated())
			.andReturn();
		return JsonPath.read(result.getResponse().getContentAsString(), "$.accessToken");
	}

	/** A real question hash, so answers resolve to actual rows rather than nulls. */
	private String aRealHash() throws Exception {
		MvcResult result = mvc.perform(get("/api/v1/questions").param("limit", "1"))
			.andExpect(status().isOk())
			.andReturn();
		return JsonPath.read(result.getResponse().getContentAsString(), "$[0].legacyHash");
	}

	private String attemptJson(UUID id, String hash, boolean ok) {
		return """
				{"id":"%s","date":"2026-09-23T12:00:00Z","type":"domain","score":%d,
				 "questionsCount":1,"durationSeconds":42,"domainTitle":"1.0 General Security Concepts",
				 "domainBreakdown":[],"answers":[{"id":"%s","ok":%b}]}"""
			.formatted(id, ok ? 100 : 0, hash, ok);
	}

	private void postAttempt(String token, String body) throws Exception {
		mvc.perform(post("/api/v1/me/attempts")
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
				.contentType(MediaType.APPLICATION_JSON).content(body))
			.andExpect(status().isNoContent());
	}

	/* ------------------------------------------------------------- access -- */

	@Test
	void everyEndpointNeedsAToken() throws Exception {
		mvc.perform(get("/api/v1/me/attempts")).andExpect(status().isUnauthorized());
		mvc.perform(get("/api/v1/me/flags")).andExpect(status().isUnauthorized());
		mvc.perform(get("/api/v1/me/daily")).andExpect(status().isUnauthorized());
	}

	@Test
	void oneAccountCannotReadAnothersAttempts() throws Exception {
		String alice = account();
		String bob = account();
		postAttempt(alice, attemptJson(UUID.randomUUID(), aRealHash(), true));

		// Alice sees hers.
		mvc.perform(get("/api/v1/me/attempts").header(HttpHeaders.AUTHORIZATION, "Bearer " + alice))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(1));

		// Bob sees nothing. A query missing `where user_id` would show him hers.
		mvc.perform(get("/api/v1/me/attempts").header(HttpHeaders.AUTHORIZATION, "Bearer " + bob))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(0));
	}

	/* ----------------------------------------------------------- attempts -- */

	@Test
	void anAttemptComesBackInTheShapeTheBrowserStores() throws Exception {
		String token = account();
		String hash = aRealHash();
		UUID id = UUID.randomUUID();
		postAttempt(token, attemptJson(id, hash, true));

		mvc.perform(get("/api/v1/me/attempts").header(HttpHeaders.AUTHORIZATION, "Bearer " + token))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[0].id").value(id.toString()))
			.andExpect(jsonPath("$[0].type").value("domain"))
			.andExpect(jsonPath("$[0].score").value(100))
			.andExpect(jsonPath("$[0].questionsCount").value(1))
			.andExpect(jsonPath("$[0].durationSeconds").value(42))
			.andExpect(jsonPath("$[0].domainTitle").value("1.0 General Security Concepts"))
			// The answer is keyed by the hash the browser uses, not the uuid.
			.andExpect(jsonPath("$[0].answers[0].id").value(hash))
			.andExpect(jsonPath("$[0].answers[0].ok").value(true))
			// Derived, never stored, and grouped by the question's filed domain.
			.andExpect(jsonPath("$[0].domainBreakdown[0].total").value(1))
			.andExpect(jsonPath("$[0].domainBreakdown[0].correct").value(1))
			.andExpect(jsonPath("$[0].domainBreakdown[0].percentage").value(100));
	}

	@Test
	void postingTheSameAttemptTwiceStoresItOnce() throws Exception {
		String token = account();
		String body = attemptJson(UUID.randomUUID(), aRealHash(), true);

		postAttempt(token, body);
		// The client re-sends whatever it is unsure about, so this is the normal
		// retry path, not an error. The client-minted id is the whole dedupe.
		postAttempt(token, body);

		mvc.perform(get("/api/v1/me/attempts").header(HttpHeaders.AUTHORIZATION, "Bearer " + token))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(1));
	}

	@Test
	void anAnswerOnAnUnknownQuestionIsKeptButNotJoined() throws Exception {
		String token = account();
		// A hash matching no question, as if it had been reworded since.
		postAttempt(token, attemptJson(UUID.randomUUID(), "nosuchhash", false));

		MvcResult result = mvc.perform(get("/api/v1/me/attempts")
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token))
			.andExpect(status().isOk())
			// The attempt survives - losing someone's quiz because a question
			// was edited would be worse than losing the per-question detail.
			.andExpect(jsonPath("$.length()").value(1))
			.andExpect(jsonPath("$[0].answers.length()").value(0))
			.andReturn();
		assertThat(result.getResponse().getContentAsString()).contains("\"score\":0");
	}

	/* -------------------------------------------------------------- flags -- */

	@Test
	void flagsRoundTripAndUnknownHashesAreDropped() throws Exception {
		String token = account();
		String hash = aRealHash();

		mvc.perform(put("/api/v1/me/flags").header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
				.contentType(MediaType.APPLICATION_JSON)
				.content("[\"%s\",\"nosuchhash\"]".formatted(hash)))
			.andExpect(status().isNoContent());

		// flagged_questions.question_id is NOT NULL, so an unresolvable flag
		// cannot be stored at all - it is dropped, never nulled.
		mvc.perform(get("/api/v1/me/flags").header(HttpHeaders.AUTHORIZATION, "Bearer " + token))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(1))
			.andExpect(jsonPath("$[0]").value(hash));
	}

	@Test
	void puttingFlagsReplacesRatherThanAppends() throws Exception {
		String token = account();
		String hash = aRealHash();
		String auth = "Bearer " + token;

		mvc.perform(put("/api/v1/me/flags").header(HttpHeaders.AUTHORIZATION, auth)
				.contentType(MediaType.APPLICATION_JSON).content("[\"%s\"]".formatted(hash)))
			.andExpect(status().isNoContent());
		mvc.perform(put("/api/v1/me/flags").header(HttpHeaders.AUTHORIZATION, auth)
				.contentType(MediaType.APPLICATION_JSON).content("[]"))
			.andExpect(status().isNoContent());

		// The browser holds a Set and rewrites it wholesale; unflagging has to
		// actually remove, or a flag could never be cleared.
		mvc.perform(get("/api/v1/me/flags").header(HttpHeaders.AUTHORIZATION, auth))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(0));
	}

	/* -------------------------------------------------------------- daily -- */

	@Test
	void answeringTheSameDayTwiceUpdatesRatherThanFails() throws Exception {
		String token = account();
		String auth = "Bearer " + token;

		mvc.perform(post("/api/v1/me/daily").header(HttpHeaders.AUTHORIZATION, auth)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						[{"date":"2026-09-23","correct":false,"at":"2026-09-23T10:00:00Z"}]"""))
			.andExpect(status().isNoContent());

		// One row per user per day is the primary key, so this is an upsert
		// rather than a constraint violation.
		mvc.perform(post("/api/v1/me/daily").header(HttpHeaders.AUTHORIZATION, auth)
				.contentType(MediaType.APPLICATION_JSON)
				.content("""
						[{"date":"2026-09-23","correct":true,"at":"2026-09-23T11:00:00Z"}]"""))
			.andExpect(status().isNoContent());

		mvc.perform(get("/api/v1/me/daily").header(HttpHeaders.AUTHORIZATION, auth))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(1))
			.andExpect(jsonPath("$[0].correct").value(true));
	}
}
