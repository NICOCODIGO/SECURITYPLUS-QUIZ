package com.secplus.auth;

import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Which X-Forwarded-For entry the per-IP rate limits count against.
 *
 * Proxies append, so a caller controls everything to the left of what our
 * own proxies added. Reading the first entry - as this once did - let a script
 * choose a fresh rate-limit bucket on every request.
 */
class ClientIpTests {

	private static String clientIp(boolean trust, int hops, String forwardedFor) {
		AuthProperties properties = new AuthProperties();
		properties.setTrustForwardedFor(trust);
		properties.setForwardedForHops(hops);

		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setRemoteAddr("10.0.0.9");
		if (forwardedFor != null) {
			request.addHeader("X-Forwarded-For", forwardedFor);
		}
		return new AuthController(null, null, properties).clientIp(request);
	}

	/** As observed through Amplify: its CDN appends the viewer, its proxy appends itself. */
	@Test
	void behindTwoProxiesTheCallerIsSecondFromTheRight() {
		assertThat(clientIp(true, 2, "198.51.100.7, 130.176.1.1")).isEqualTo("198.51.100.7");
	}

	@Test
	void whateverTheCallerPrependsIsIgnored() {
		assertThat(clientIp(true, 2, "1.1.1.1, 2.2.2.2, 198.51.100.7, 130.176.1.1"))
			.as("the forged entries are to the left of the ones our proxies added")
			.isEqualTo("198.51.100.7");
	}

	@Test
	void withOneProxyTheCallerIsTheLastEntry() {
		assertThat(clientIp(true, 1, "6.6.6.6, 198.51.100.7")).isEqualTo("198.51.100.7");
	}

	/** Fewer entries than proxies: it skipped one, so take the leftmost there is. */
	@Test
	void aShortHeaderFallsBackToItsFirstEntry() {
		assertThat(clientIp(true, 2, "198.51.100.7")).isEqualTo("198.51.100.7");
	}

	@Test
	void theHeaderIsIgnoredUnlessTheDeploymentTrustsIt() {
		assertThat(clientIp(false, 2, "198.51.100.7, 130.176.1.1")).isEqualTo("10.0.0.9");
	}

	@Test
	void noHeaderMeansTheSocketAddress() {
		assertThat(clientIp(true, 2, null)).isEqualTo("10.0.0.9");
	}

	@Test
	void hopsBelowOneAreTreatedAsOne() {
		assertThat(clientIp(true, 0, "6.6.6.6, 198.51.100.7")).isEqualTo("198.51.100.7");
	}
}
