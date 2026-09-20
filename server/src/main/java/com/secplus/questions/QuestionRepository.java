package com.secplus.questions;

import java.util.List;
import java.util.UUID;

import org.springframework.data.domain.Limit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface QuestionRepository extends JpaRepository<Question, UUID> {

	/**
	 * Matching ids, in a stable order, with the limit applied in SQL.
	 *
	 * This is deliberately separate from {@link #findAllWithChoices}: combining
	 * `join fetch` with a limit makes Hibernate fetch every matching row and
	 * paginate in memory, which would pull the whole bank for a 10-question
	 * quiz. Selecting ids first keeps the limit in the database.
	 *
	 * Filters are all optional — a null parameter means "don't filter on this".
	 */
	@Query("""
			select q.id from Question q
			where q.status = 'published'
			  and (:objective   is null or q.objective.code         = :objective)
			  and (:domain      is null or q.objective.domainNumber = :domain)
			  and (:filedDomain is null or q.filedDomain            = :filedDomain)
			  and (:difficulty  is null or q.difficulty             = :difficulty)
			order by q.objective.code, q.text
			""")
	List<UUID> findIds(@Param("objective") String objective, @Param("domain") Short domain,
			@Param("filedDomain") Short filedDomain, @Param("difficulty") String difficulty, Limit limit);

	/**
	 * The full questions for those ids, with choices and objective fetched in
	 * one query so rendering them cannot trigger N+1 — which matters because
	 * `spring.jpa.open-in-view=false` would make it fail outright, not just run
	 * slowly.
	 */
	@Query("""
			select distinct q from Question q
			join fetch q.choices
			join fetch q.objective
			where q.id in :ids
			""")
	List<Question> findAllWithChoices(@Param("ids") List<UUID> ids);

	@Query("""
			select q.objective.domainNumber as domain, count(q) as total
			from Question q where q.status = 'published'
			group by q.objective.domainNumber order by q.objective.domainNumber
			""")
	List<DomainCount> countByObjectiveDomain();

	@Query("""
			select q.filedDomain as domain, count(q) as total
			from Question q where q.status = 'published'
			group by q.filedDomain order by q.filedDomain
			""")
	List<DomainCount> countByFiledDomain();

	@Query("""
			select q.objective.code as code, count(q) as total
			from Question q where q.status = 'published'
			group by q.objective.code
			""")
	List<ObjectiveCount> countByObjective();

	/** Projection: questions per domain number. */
	interface DomainCount {
		short getDomain();

		long getTotal();
	}

	/** Projection: questions per objective code. */
	interface ObjectiveCount {
		String getCode();

		long getTotal();
	}
}
