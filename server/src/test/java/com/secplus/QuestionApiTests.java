package com.secplus;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
// Boot 4 moved this out of spring-boot-test-autoconfigure into the webmvc
// test module — the old ...test.autoconfigure.web.servlet package is gone.
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.web.servlet.MockMvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.everyItem;
import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * The public question API, end to end: HTTP in, JSON out, real Postgres with
 * the real seeded bank behind it.
 *
 * These also serve as the check that the JPA mappings actually match the
 * schema — `ddl-auto=validate` catches a wrong column name at startup, but
 * only a query catches a wrong association or a lazy load that escapes its
 * transaction (`open-in-view` is off, so that fails loudly rather than
 * silently issuing another query).
 */
@Import(TestcontainersConfiguration.class)
@SpringBootTest
@AutoConfigureMockMvc
class QuestionApiTests {

	@Autowired
	private MockMvc mvc;

	/* ------------------------------------------------------------ access -- */

	@Test
	void theBankIsReadableWithoutAnAccount() throws Exception {
		// The entire point of the product rule: no login to study.
		mvc.perform(get("/api/v1/questions").param("limit", "1")).andExpect(status().isOk());
		mvc.perform(get("/api/v1/objectives")).andExpect(status().isOk());
		mvc.perform(get("/api/v1/domains")).andExpect(status().isOk());
	}

	@Test
	void anUnknownEndpointIsNotSilentlyPublic() throws Exception {
		// Deny-by-default: a future endpoint is protected until opened on purpose.
		mvc.perform(get("/api/v1/me/attempts")).andExpect(status().isUnauthorized());
	}

	@Test
	void actuatorHealthIsPublicButMetricsAreNot() throws Exception {
		mvc.perform(get("/actuator/health")).andExpect(status().isOk());
		mvc.perform(get("/actuator/metrics")).andExpect(status().isUnauthorized());
	}

	/* --------------------------------------------------------- questions -- */

	@Test
	void aQuestionComesBackWholeWithItsChoices() throws Exception {
		mvc.perform(get("/api/v1/questions").param("limit", "1"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", hasSize(1)))
			.andExpect(jsonPath("$[0].id", notNullValue()))
			.andExpect(jsonPath("$[0].legacyHash", notNullValue()))
			.andExpect(jsonPath("$[0].text", notNullValue()))
			.andExpect(jsonPath("$[0].explanation", notNullValue()))
			.andExpect(jsonPath("$[0].objective", notNullValue()))
			.andExpect(jsonPath("$[0].choices", hasSize(4)))
			.andExpect(jsonPath("$[0].choices[*].position", contains(0, 1, 2, 3)));
	}

	@Test
	void practiceQuestionsShipTheAnswerKey() throws Exception {
		// Practice grades in the browser and needs instant feedback, so the key
		// is included on purpose. Phase 4's mock endpoints must NOT do this.
		mvc.perform(get("/api/v1/questions").param("limit", "1"))
			.andExpect(jsonPath("$[0].choices[?(@.correct == true)]", hasSize(1)))
			.andExpect(jsonPath("$[0].choices[?(@.correct == false)]", hasSize(3)))
			.andExpect(jsonPath("$[0].choices[?(@.correct == false)].rationale", everyItem(notNullValue())));
	}

	@Test
	void filteringByObjectiveReturnsOnlyThatObjective() throws Exception {
		mvc.perform(get("/api/v1/questions").param("objective", "4.6").param("limit", "200"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", hasSize(32)))
			.andExpect(jsonPath("$[*].objective", everyItem(is("4.6"))));
	}

	@Test
	void domainFiltersByObjectiveNotByFiling() throws Exception {
		// The distinction that matters: 36 questions are *filed* under domain 4,
		// but 93 actually test a domain-4 objective.
		mvc.perform(get("/api/v1/questions").param("domain", "4").param("limit", "200"))
			.andExpect(jsonPath("$", hasSize(93)))
			.andExpect(jsonPath("$[*].domain", everyItem(is(4))));

		mvc.perform(get("/api/v1/questions").param("filedDomain", "4").param("limit", "200"))
			.andExpect(jsonPath("$", hasSize(36)))
			.andExpect(jsonPath("$[*].filedDomain", everyItem(is(4))));
	}

	@Test
	void difficultyFilters() throws Exception {
		mvc.perform(get("/api/v1/questions").param("difficulty", "Beginner").param("limit", "200"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[*].difficulty", everyItem(is("Beginner"))));
	}

	@Test
	void theLimitIsApplied() throws Exception {
		mvc.perform(get("/api/v1/questions").param("limit", "7")).andExpect(jsonPath("$", hasSize(7)));
	}

	@Test
	void pagingWalksTheWholeBankWithoutRepeating() throws Exception {
		// The bank is 444 and a single response is capped at 200, so a client
		// that reads one page gets less than half of it and never knows. This is
		// the regression that caused: the front end hydrated 200 of 444.
		java.util.Set<String> ids = new java.util.HashSet<>();
		int page = 0;
		int lastSize;

		do {
			String body = mvc
				.perform(get("/api/v1/questions").param("limit", "200").param("page", String.valueOf(page)))
				.andExpect(status().isOk())
				.andReturn()
				.getResponse()
				.getContentAsString();

			java.util.List<String> pageIds = com.jayway.jsonpath.JsonPath.read(body, "$[*].id");
			lastSize = pageIds.size();
			ids.addAll(pageIds);
			page += 1;
		}
		while (lastSize == 200 && page < 10);

		assertThat(ids).hasSize(444);
	}

	@Test
	void aPageBeyondTheEndIsEmptyRatherThanAnError() throws Exception {
		mvc.perform(get("/api/v1/questions").param("limit", "200").param("page", "99"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", hasSize(0)));
	}

	@Test
	void aNegativePageIsRejected() throws Exception {
		mvc.perform(get("/api/v1/questions").param("page", "-1")).andExpect(status().isBadRequest());
	}

	@Test
	void theOrderIsStableAcrossCalls() throws Exception {
		// A quiz picks a random subset client-side; the API returning a shifting
		// order would make paging and caching behave unpredictably.
		String first = mvc.perform(get("/api/v1/questions").param("limit", "20"))
			.andReturn().getResponse().getContentAsString();
		String again = mvc.perform(get("/api/v1/questions").param("limit", "20"))
			.andReturn().getResponse().getContentAsString();

		org.assertj.core.api.Assertions.assertThat(first).isEqualTo(again);
	}

	@Test
	void anUnknownObjectiveIsEmptyRatherThanAnError() throws Exception {
		mvc.perform(get("/api/v1/questions").param("objective", "9.9"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", hasSize(0)));
	}

	@Test
	void outOfRangeParametersAreRejected() throws Exception {
		mvc.perform(get("/api/v1/questions").param("limit", "0")).andExpect(status().isBadRequest());
		mvc.perform(get("/api/v1/questions").param("limit", "5000")).andExpect(status().isBadRequest());
		mvc.perform(get("/api/v1/questions").param("domain", "9")).andExpect(status().isBadRequest());
	}

	/* ---------------------------------------------- objectives & domains -- */

	@Test
	void objectivesListTheWholeOutlineWithCounts() throws Exception {
		mvc.perform(get("/api/v1/objectives"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", hasSize(28)))
			.andExpect(jsonPath("$[0].code", is("1.1")))
			.andExpect(jsonPath("$[*].questionCount", everyItem(greaterThan(-1))));
	}

	@Test
	void domainsExposeBothCountsSoNeitherIsHidden() throws Exception {
		mvc.perform(get("/api/v1/domains"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", hasSize(5)))
			.andExpect(jsonPath("$[3].domain", is(4)))
			.andExpect(jsonPath("$[3].questionCount", is(93)))
			.andExpect(jsonPath("$[3].filedQuestionCount", is(36)));
	}
}
