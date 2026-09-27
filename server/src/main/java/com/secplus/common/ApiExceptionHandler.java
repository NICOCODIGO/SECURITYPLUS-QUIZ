package com.secplus.common;

import java.time.format.DateTimeParseException;
import java.util.List;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Turns bad client input into 400s.
 *
 * Without this, a `@Min`/`@Max` violation on a request parameter escapes as a
 * ConstraintViolationException and Spring reports **500 Internal Server
 * Error** — telling the caller the server broke when in fact they sent
 * `limit=0`. That is both wrong and noisy: it puts client mistakes in the
 * error budget and the alerting.
 *
 * RFC 7807 ProblemDetail, so the shape is predictable and the front end can
 * show the failing parameter rather than a generic message.
 */
@RestControllerAdvice
public class ApiExceptionHandler {

	@ExceptionHandler(ConstraintViolationException.class)
	ProblemDetail onConstraintViolation(ConstraintViolationException ex) {
		List<String> errors = ex.getConstraintViolations().stream()
			.map(ApiExceptionHandler::describe)
			.sorted()
			.toList();

		ProblemDetail problem = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
		problem.setTitle("Invalid request parameter");
		problem.setDetail(String.join("; ", errors));
		problem.setProperty("errors", errors);
		return problem;
	}

	/**
	 * Auth failures carry a title and a detail and nothing else.
	 *
	 * No field echoes, no stack traces, no "no account with that email" — the
	 * message is the whole body precisely so a caller cannot learn anything
	 * from its shape. Retry-After is set by the rate limiter on its own
	 * response, not here.
	 */
	@ExceptionHandler(AuthException.class)
	ResponseEntity<ProblemDetail> onAuthFailure(AuthException ex) {
		ProblemDetail problem = ProblemDetail.forStatus(ex.getStatus());
		problem.setTitle(ex.getStatus().getReasonPhrase());
		problem.setDetail(ex.getMessage());

		ResponseEntity.BodyBuilder response = ResponseEntity.status(ex.getStatus());
		if (ex.getRetryAfterSeconds() > 0) {
			response.header(HttpHeaders.RETRY_AFTER, Long.toString(ex.getRetryAfterSeconds()));
		}
		return response.body(problem);
	}

	/**
	 * A date the client sent that does not parse - "2026-13-45", say, which
	 * has the right shape for a pattern check but is not a day.
	 *
	 * Parsed where it is stored (MeStore), so it escapes as a runtime exception
	 * and would otherwise be a 500: the server blamed for the client's input.
	 * The detail stays generic; the parser's message echoes the input back.
	 */
	@ExceptionHandler(DateTimeParseException.class)
	ProblemDetail onBadDate(DateTimeParseException ex) {
		ProblemDetail problem = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
		problem.setTitle("Invalid date");
		problem.setDetail("A date in the request is not a valid ISO-8601 date or time.");
		return problem;
	}

	/** "limit: must be greater than or equal to 1" — the parameter, not the method path. */
	private static String describe(ConstraintViolation<?> violation) {
		String path = violation.getPropertyPath().toString();
		String parameter = path.contains(".") ? path.substring(path.lastIndexOf('.') + 1) : path;
		return parameter + ": " + violation.getMessage();
	}
}
