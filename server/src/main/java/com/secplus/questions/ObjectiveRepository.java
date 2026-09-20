package com.secplus.questions;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ObjectiveRepository extends JpaRepository<Objective, String> {

	/** Codes sort lexically into exam order — 1.1, 1.2, … 5.6. */
	List<Objective> findAllByOrderByCodeAsc();
}
