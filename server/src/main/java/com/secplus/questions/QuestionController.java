package com.secplus.questions;

import java.util.List;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.secplus.questions.QuestionViews.DomainView;
import com.secplus.questions.QuestionViews.ObjectiveView;
import com.secplus.questions.QuestionViews.QuestionView;

/**
 * Public, read-only access to the question bank. No authentication — the whole
 * bank is free to use, and an account exists only to keep your own results
 * (see docs/architecture.md).
 *
 * Everything here serves *practice*, so responses include the answer key.
 * Mock exams get their own keyless, server-graded endpoints in phase 4.
 */
@RestController
@RequestMapping("/api/v1")
@Validated
public class QuestionController {

	/** A whole mock exam is 90; the ceiling leaves room without allowing a full dump. */
	private static final int MAX_LIMIT = 200;

	private final QuestionService service;

	QuestionController(QuestionService service) {
		this.service = service;
	}

	/**
	 * @param objective   exact objective code, e.g. "4.6"
	 * @param domain      1–5, by the question's **objective** — the source of truth
	 * @param filedDomain 1–5, by the legacy quizData array. Differs from `domain`
	 *                    for 147 of the 444 questions; exposed so the front end can
	 *                    keep today's behaviour until the switch is made deliberately
	 * @param difficulty  Beginner | Intermediate | Advanced
	 * @param limit       page size, 1–200
	 * @param page        0-based page index. The bank is 444 questions and no
	 *                    single call may dump it, so a client that wants all of
	 *                    them walks pages until a short one comes back.
	 */
	@GetMapping("/questions")
	public List<QuestionView> questions(@RequestParam(required = false) String objective,
			@RequestParam(required = false) @Min(1) @Max(5) Short domain,
			@RequestParam(required = false) @Min(1) @Max(5) Short filedDomain,
			@RequestParam(required = false) String difficulty,
			@RequestParam(defaultValue = "50") @Min(1) @Max(MAX_LIMIT) int limit,
			@RequestParam(defaultValue = "0") @Min(0) int page) {

		return service.search(objective, domain, filedDomain, difficulty, limit, page);
	}

	@GetMapping("/objectives")
	public List<ObjectiveView> objectives() {
		return service.objectives();
	}

	@GetMapping("/domains")
	public List<DomainView> domains() {
		return service.domains();
	}
}
