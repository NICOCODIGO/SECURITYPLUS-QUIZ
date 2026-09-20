package com.secplus.common;

import java.util.List;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
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

	/** "limit: must be greater than or equal to 1" — the parameter, not the method path. */
	private static String describe(ConstraintViolation<?> violation) {
		String path = violation.getPropertyPath().toString();
		String parameter = path.contains(".") ? path.substring(path.lastIndexOf('.') + 1) : path;
		return parameter + ": " + violation.getMessage();
	}
}
