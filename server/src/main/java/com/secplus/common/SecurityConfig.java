package com.secplus.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.Customizer;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

/**
 * Without this, Spring Security's default chain would lock every endpoint
 * behind HTTP Basic with a password printed to the log — including the public
 * question bank. The whole bank is free to read, so the read endpoints are
 * explicitly permitted and everything else stays closed by default.
 *
 * Deliberately deny-by-default: `anyRequest().authenticated()` means a new
 * endpoint is protected until someone opens it on purpose, rather than
 * exposed until someone remembers to close it.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http,
			JwtAuthenticationConverter jwtAuthenticationConverter) throws Exception {
		return http
			// No sessions on the API: requests authenticate with a bearer token,
			// so there is no session for CSRF to protect.
			//
			// The refresh cookie is the one exception, and it is defended
			// without Spring's CSRF machinery: /auth/refresh and /auth/logout
			// require an `X-Secplus-Client` header, which a cross-site form or
			// <img> cannot set without triggering a preflight that
			// corsConfigurationSource refuses. Re-enabling CSRF for two
			// endpoints would mean shipping a readable CSRF cookie and a
			// double-submit dance on an otherwise stateless API.
			.csrf(csrf -> csrf.disable())
			.cors(Customizer.withDefaults())
			.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
			.httpBasic(basic -> basic.disable())
			.formLogin(form -> form.disable())
			// With no login mechanism registered, Security's default response to
			// an anonymous request is 403, which says "you may not" when the
			// truth is "we don't know who you are". The front end needs that
			// distinction from phase 2 on: 401 means refresh the token or sign
			// in, 403 means signing in again will not help.
			.exceptionHandling(handling -> handling
				.authenticationEntryPoint(new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED)))
			.oauth2ResourceServer(oauth2 -> oauth2
				.jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter)))
			.authorizeHttpRequests(auth -> auth
				.requestMatchers(HttpMethod.GET, "/api/v1/questions", "/api/v1/objectives",
						"/api/v1/domains")
					.permitAll()
				// You sign in without a token by definition, and you sign out
				// with an expired one more often than not. /auth/me is the only
				// one that falls through to authenticated().
				.requestMatchers(HttpMethod.POST, "/api/v1/auth/register", "/api/v1/auth/login",
						"/api/v1/auth/refresh", "/api/v1/auth/logout",
						// All four below are reached by someone who cannot sign in
						// yet - that is the entire point of them. Each carries its
						// own single-use, expiring token and its own rate limit;
						// public is not the same as unprotected.
						"/api/v1/auth/2fa/verify", "/api/v1/auth/verify-email",
						"/api/v1/auth/forgot-password", "/api/v1/auth/reset-password")
					.permitAll()
				// Liveness and readiness only. `management.endpoint.health.show-details`
				// is `when-authorized`, so anonymous callers get UP/DOWN and nothing
				// about which downstream service is failing.
				.requestMatchers("/actuator/health", "/actuator/health/**", "/actuator/info")
					.permitAll()
				.anyRequest().authenticated())
			.build();
	}

	/**
	 * Maps the token's `roles` claim to Spring's ROLE_-prefixed authorities.
	 *
	 * The default converter reads `scope`/`scp` and would silently grant an
	 * authenticated user no authorities at all, which only shows up later as a
	 * 403 on the first @PreAuthorize.
	 */
	@Bean
	JwtAuthenticationConverter jwtAuthenticationConverter() {
		JwtGrantedAuthoritiesConverter authorities = new JwtGrantedAuthoritiesConverter();
		authorities.setAuthoritiesClaimName("roles");
		authorities.setAuthorityPrefix("ROLE_");

		JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
		converter.setJwtGrantedAuthoritiesConverter(authorities);
		return converter;
	}

	/**
	 * The deployed origin is supplied by CORS_ALLOWED_ORIGINS rather than
	 * hardcoded, so the same image runs locally and in front of CloudFront.
	 */
	@Bean
	CorsConfigurationSource corsConfigurationSource(
			@Value("${app.cors.allowed-origins}") List<String> allowedOrigins) {

		CorsConfiguration config = new CorsConfiguration();
		config.setAllowedOrigins(allowedOrigins);
		config.setAllowedMethods(List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
		config.setAllowedHeaders(List.of("*"));
		// Needed from phase 2: the refresh token travels as an httpOnly cookie.
		config.setAllowCredentials(true);

		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		source.registerCorsConfiguration("/api/**", config);
		return source;
	}
}
