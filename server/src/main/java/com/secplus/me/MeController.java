package com.secplus.me;

import java.util.List;
import java.util.UUID;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.secplus.me.MeViews.AttemptView;
import com.secplus.me.MeViews.DailyView;

/**
 * One account's own study data.
 *
 * Nothing here is comparative and nothing is cross-user: every endpoint reads
 * and writes exactly the caller's rows, and the caller is the `sub` claim of
 * their access token. `SecurityConfig` is deny-by-default with
 * `anyRequest().authenticated()` last, so these paths are protected the moment
 * they exist — no change was needed there, and `QuestionApiTests` already
 * asserts a 401 on `/api/v1/me/attempts`.
 *
 * The progress analytics deliberately stay in the browser. With no cross-user
 * comparison there is nothing the client cannot work out from its own attempts
 * array, and duplicating the selectors here is how the two start disagreeing.
 * See docs/backend.md.
 */
@RestController
@RequestMapping("/api/v1/me")
public class MeController {

	private final MeStore store;

	MeController(MeStore store) {
		this.store = store;
	}

	/** The `sub` claim is the user uuid. This is the only ownership check there is. */
	private static UUID caller(Jwt jwt) {
		return UUID.fromString(jwt.getSubject());
	}

	/* ------------------------------------------------------------ attempts -- */

	@GetMapping("/attempts")
	@Transactional(readOnly = true)
	List<AttemptView> attempts(@AuthenticationPrincipal Jwt jwt) {
		return store.attempts(caller(jwt));
	}

	/**
	 * Stores one finished quiz.
	 *
	 * Always 204, whether the attempt was new or already held. The client
	 * re-sends anything it is unsure about, and a 409 on a duplicate would turn
	 * a successful retry into an error it has to special-case.
	 */
	@PostMapping("/attempts")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@Transactional
	void saveAttempt(@AuthenticationPrincipal Jwt jwt, @Valid @RequestBody AttemptView attempt) {
		store.saveAttempt(caller(jwt), attempt);
	}

	/* --------------------------------------------------------------- flags -- */

	@GetMapping("/flags")
	@Transactional(readOnly = true)
	List<String> flags(@AuthenticationPrincipal Jwt jwt) {
		return store.flags(caller(jwt));
	}

	/** PUT, not PATCH: the browser holds the whole set and rewrites it on every toggle. */
	@PutMapping("/flags")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@Transactional
	void replaceFlags(@AuthenticationPrincipal Jwt jwt, @RequestBody @NotNull List<String> hashes) {
		store.replaceFlags(caller(jwt), hashes);
	}

	/* --------------------------------------------------------------- daily -- */

	@GetMapping("/daily")
	@Transactional(readOnly = true)
	List<DailyView> daily(@AuthenticationPrincipal Jwt jwt) {
		return store.daily(caller(jwt));
	}

	@PostMapping("/daily")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@Transactional
	void saveDaily(@AuthenticationPrincipal Jwt jwt, @Valid @RequestBody @NotEmpty List<DailyView> days) {
		UUID userId = caller(jwt);
		days.forEach(day -> store.saveDaily(userId, day));
	}
}
