package com.secplus.auth;

import java.security.SecureRandom;
import java.nio.charset.StandardCharsets;

import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtValidators;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtEncoder;

import com.nimbusds.jose.jwk.source.ImmutableSecret;

/**
 * The beans that mint and verify tokens, and the one that hashes passwords.
 *
 * These live in `auth` rather than `common/SecurityConfig` on purpose:
 * SecurityConfig is about the filter chain, and mixing key material into it
 * makes both harder to read.
 *
 * Declaring a {@link JwtDecoder} here also makes Boot's resource-server
 * auto-configuration back off, so no `spring.security.oauth2.*` properties are
 * needed and the key is configured in exactly one place.
 */
@Configuration
@EnableConfigurationProperties(AuthProperties.class)
public class TokenConfig {

	private static final Logger log = LoggerFactory.getLogger(TokenConfig.class);

	/** HS256 needs at least 256 bits of key. Shorter is a misconfiguration, not a preference. */
	private static final int MINIMUM_SECRET_BYTES = 32;

	@Bean
	SecretKeySpec jwtSecretKey(AuthProperties properties) {
		String configured = properties.getSecret();

		if (configured == null || configured.isBlank()) {
			// Keeps `./gradlew bootRun` zero-setup. The WARN matters because the
			// failure mode in production is subtle: everyone is silently signed
			// out on every deploy, which reads as a bug rather than a setting.
			byte[] generated = new byte[MINIMUM_SECRET_BYTES];
			new SecureRandom().nextBytes(generated);
			log.warn("AUTH_JWT_SECRET is not set — generated a random signing key. "
					+ "Sessions will not survive a restart. Set it in any deployed environment.");
			return new SecretKeySpec(generated, "HmacSHA256");
		}

		byte[] bytes = configured.getBytes(StandardCharsets.UTF_8);
		if (bytes.length < MINIMUM_SECRET_BYTES) {
			// Fail loudly rather than signing every token with a weak key.
			throw new IllegalStateException("AUTH_JWT_SECRET must be at least " + MINIMUM_SECRET_BYTES
					+ " bytes; got " + bytes.length);
		}
		return new SecretKeySpec(bytes, "HmacSHA256");
	}

	@Bean
	JwtEncoder jwtEncoder(SecretKeySpec key) {
		return new NimbusJwtEncoder(new ImmutableSecret<>(key));
	}

	@Bean
	JwtDecoder jwtDecoder(SecretKeySpec key, AuthProperties properties) {
		NimbusJwtDecoder decoder = NimbusJwtDecoder.withSecretKey(key)
			.macAlgorithm(MacAlgorithm.HS256)
			.build();
		// Default validators check exp/nbf with a little clock skew; the issuer
		// check stops a token minted by some other service with the same key.
		decoder.setJwtValidator(JwtValidators.createDefaultWithIssuer(properties.getIssuer()));
		return decoder;
	}

	/**
	 * Strength 12 per docs/backend.md. Also the reason passwords are capped at
	 * 72 bytes — see AuthRequests.
	 */
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder(12);
	}
}
