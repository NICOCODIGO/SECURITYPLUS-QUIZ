package com.secplus.common;

import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * Puts a request id on every log line for the life of one request.
 *
 * `logging.pattern.level` has referenced `%X{requestId}` since the project
 * started, but nothing ever populated it, so the field rendered empty on every
 * line — the log format promised a correlation id and never had one. This is
 * what supplies it.
 *
 * An inbound `X-Request-Id` is honoured so a trace can be followed across a
 * proxy; CloudFront sets its own, and reusing it is what lets a CloudWatch
 * query and an access log line be joined up. Anything else generates one.
 *
 * Ordered first: a request that fails inside a later filter — an expired token,
 * a rejected CORS preflight — is exactly the one worth correlating, so the id
 * has to exist before any of them run.
 */
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class RequestIdFilter implements Filter {

	static final String MDC_KEY = "requestId";

	static final String HEADER = "X-Request-Id";

	/** Long enough to be unique in a log, short enough to read in a terminal. */
	private static final int ID_LENGTH = 16;

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		String requestId = resolve(request);
		MDC.put(MDC_KEY, requestId);

		if (response instanceof HttpServletResponse http) {
			// Echoed back so a user reporting a problem can quote the id of the
			// exact request that failed.
			http.setHeader(HEADER, requestId);
		}

		try {
			chain.doFilter(request, response);
		} finally {
			// Threads are pooled and reused, so leaving this set would stamp
			// the next unrelated request with this one's id.
			MDC.remove(MDC_KEY);
		}
	}

	private static String resolve(ServletRequest request) {
		if (request instanceof HttpServletRequest http) {
			String inbound = http.getHeader(HEADER);
			if (inbound != null && !inbound.isBlank()) {
				// Caller-supplied and only ever used as a log label. Stripped of
				// anything that could forge a newline and inject a fake log
				// entry, then truncated — sanitising first, so the bound is the
				// cleaned length and not the original's.
				String cleaned = inbound.replaceAll("[^A-Za-z0-9._-]", "");
				if (!cleaned.isEmpty()) {
					return cleaned.substring(0, Math.min(cleaned.length(), 64));
				}
			}
		}
		return generate();
	}

	private static String generate() {
		return UUID.randomUUID().toString().replace("-", "").substring(0, ID_LENGTH);
	}
}
