package com.secplus.auth;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, UUID> {

	/**
	 * Written out rather than derived as `findByEmailIgnoreCase`, which Spring
	 * Data renders as `upper(email) = upper(?)`. The index is on `lower(email)`,
	 * so the derived form cannot use it and degrades to a sequential scan on the
	 * one query that runs on every login attempt.
	 */
	@Query("select u from User u where lower(u.email) = lower(:email)")
	Optional<User> findByEmail(@Param("email") String email);

	@Query("select count(u) > 0 from User u where lower(u.email) = lower(:email)")
	boolean existsByEmail(@Param("email") String email);
}
