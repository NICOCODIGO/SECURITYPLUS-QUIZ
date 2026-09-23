package com.secplus.common;

import jakarta.servlet.FilterChain;

import org.junit.jupiter.api.Test;
import org.slf4j.MDC;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * Needs no Docker, so the correlation id stays covered when the daemon is down.
 *
 * The MDC is read inside the chain rather than after it, because the whole
 * point is what a log line emitted *during* the request would contain.
 */
class RequestIdFilterTests {

	private final RequestIdFilter filter = new RequestIdFilter();

	/** Captures what the MDC held while the request was in flight. */
	private static FilterChain capturing(String[] seen) {
		return (request, response) -> seen[0] = MDC.get(RequestIdFilter.MDC_KEY);
	}

	@Test
	void generatesAnIdWhenNoneIsSupplied() throws Exception {
		String[] seen = new String[1];
		MockHttpServletResponse response = new MockHttpServletResponse();

		filter.doFilter(new MockHttpServletRequest(), response, capturing(seen));

		assertThat(seen[0]).isNotBlank();
		// Echoed back so a user can quote the id of the request that failed.
		assertThat(response.getHeader(RequestIdFilter.HEADER)).isEqualTo(seen[0]);
	}

	@Test
	void reusesAnInboundIdSoATraceSurvivesTheProxy() throws Exception {
		String[] seen = new String[1];
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.addHeader(RequestIdFilter.HEADER, "cloudfront-abc123");

		filter.doFilter(request, new MockHttpServletResponse(), capturing(seen));

		assertThat(seen[0]).isEqualTo("cloudfront-abc123");
	}

	@Test
	void stripsCharactersThatCouldForgeALogLine() throws Exception {
		String[] seen = new String[1];
		MockHttpServletRequest request = new MockHttpServletRequest();
		// A newline here would let a caller inject a fake entry into the log.
		request.addHeader(RequestIdFilter.HEADER, "abc\n ERROR fake-entry");

		filter.doFilter(request, new MockHttpServletResponse(), capturing(seen));

		assertThat(seen[0]).doesNotContain("\n").doesNotContain(" ");
	}

	@Test
	void fallsBackWhenAnInboundIdSanitisesToNothing() throws Exception {
		String[] seen = new String[1];
		MockHttpServletRequest request = new MockHttpServletRequest();
		// Every character is stripped; bounding the substring on the original
		// length here would throw instead of falling back.
		request.addHeader(RequestIdFilter.HEADER, "!!!@@@###");

		filter.doFilter(request, new MockHttpServletResponse(), capturing(seen));

		assertThat(seen[0]).isNotBlank().doesNotContain("!");
	}

	@Test
	void clearsTheMdcSoAPooledThreadCannotInheritIt() throws Exception {
		filter.doFilter(new MockHttpServletRequest(), new MockHttpServletResponse(),
				(request, response) -> {
				});

		// Left set, the next unrelated request on this thread would be logged
		// under this one's id.
		assertThat(MDC.get(RequestIdFilter.MDC_KEY)).isNull();
	}

	@Test
	void clearsTheMdcEvenWhenTheRequestBlowsUp() throws Exception {
		assertThatThrownBy(() -> filter.doFilter(new MockHttpServletRequest(),
				new MockHttpServletResponse(), (request, response) -> {
					throw new IllegalStateException("boom");
				})).isInstanceOf(IllegalStateException.class);

		// A failing request is the one most worth correlating, and also the one
		// whose id would leak onto the next request without the finally.
		assertThat(MDC.get(RequestIdFilter.MDC_KEY)).isNull();
	}
}
