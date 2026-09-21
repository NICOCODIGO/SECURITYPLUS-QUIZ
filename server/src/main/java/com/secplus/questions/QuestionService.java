package com.secplus.questions;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.secplus.questions.QuestionViews.DomainView;
import com.secplus.questions.QuestionViews.ObjectiveView;
import com.secplus.questions.QuestionViews.QuestionView;

/**
 * Read side of the question bank.
 *
 * Every method maps to view records **inside** the transaction. With
 * `spring.jpa.open-in-view=false` there is no session open during
 * serialisation, so a lazy association touched later would throw rather than
 * quietly issuing another query.
 */
@Service
public class QuestionService {

	private final QuestionRepository questions;
	private final ObjectiveRepository objectives;

	QuestionService(QuestionRepository questions, ObjectiveRepository objectives) {
		this.questions = questions;
		this.objectives = objectives;
	}

	@Transactional(readOnly = true)
	public List<QuestionView> search(String objective, Short domain, Short filedDomain, String difficulty,
			int limit, int page) {
		List<UUID> ids = questions.findIds(objective, domain, filedDomain, difficulty,
				PageRequest.of(page, limit));
		if (ids.isEmpty()) {
			return List.of();
		}

		// `in :ids` returns rows in whatever order the database likes, so the
		// deterministic order from findIds is reapplied here.
		Map<UUID, Integer> order = new HashMap<>();
		for (int i = 0; i < ids.size(); i++) {
			order.put(ids.get(i), i);
		}

		return questions.findAllWithChoices(ids).stream()
			.sorted(Comparator.comparingInt(q -> order.get(q.getId())))
			.map(QuestionView::of)
			.toList();
	}

	@Transactional(readOnly = true)
	public List<ObjectiveView> objectives() {
		Map<String, Long> counts = questions.countByObjective().stream()
			.collect(Collectors.toMap(QuestionRepository.ObjectiveCount::getCode,
					QuestionRepository.ObjectiveCount::getTotal));

		return objectives.findAllByOrderByCodeAsc().stream()
			.map(o -> new ObjectiveView(o.getCode(), o.getDomainNumber(), o.getTitle(),
					counts.getOrDefault(o.getCode(), 0L)))
			.toList();
	}

	@Transactional(readOnly = true)
	public List<DomainView> domains() {
		Map<Short, Long> byObjective = questions.countByObjectiveDomain().stream()
			.collect(Collectors.toMap(QuestionRepository.DomainCount::getDomain,
					QuestionRepository.DomainCount::getTotal));
		Map<Short, Long> byFiling = questions.countByFiledDomain().stream()
			.collect(Collectors.toMap(QuestionRepository.DomainCount::getDomain,
					QuestionRepository.DomainCount::getTotal));

		// All five are always returned, including any with no questions, so the
		// front end renders a complete picture rather than silently omitting one.
		return IntStream.rangeClosed(1, 5)
			.mapToObj(d -> new DomainView(d, byObjective.getOrDefault((short) d, 0L),
					byFiling.getOrDefault((short) d, 0L)))
			.toList();
	}
}
