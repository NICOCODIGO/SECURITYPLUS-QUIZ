package com.secplus.auth;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, UUID> {

	@Query("select t from RefreshToken t join fetch t.user where t.tokenHash = :hash")
	Optional<RefreshToken> findByTokenHash(@Param("hash") String hash);

	/** Used on reuse detection and on logout-everywhere. */
	@Modifying
	@Query("update RefreshToken t set t.revokedAt = :now where t.user.id = :userId and t.revokedAt is null")
	int revokeAllForUser(@Param("userId") UUID userId, @Param("now") Instant now);

	/**
	 * Rotation writes a row per refresh, and the quiz flow crosses two full page
	 * reloads, so a single quiz issues several. Without a sweep the table only
	 * ever grows.
	 */
	@Modifying
	@Query("delete from RefreshToken t where t.expiresAt < :before")
	int deleteExpiredBefore(@Param("before") Instant before);
}
