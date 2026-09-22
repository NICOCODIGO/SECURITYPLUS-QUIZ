package com.secplus.auth;

import java.time.Instant;
import java.util.List;

import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwsHeader;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.stereotype.Service;

/** Mints the short-lived access token. */
@Service
public class TokenService {

	private final JwtEncoder encoder;

	private final AuthProperties properties;

	TokenService(JwtEncoder encoder, AuthProperties properties) {
		this.encoder = encoder;
		this.properties = properties;
	}

	/**
	 * The claim set is deliberately small.
	 *
	 * `displayName` is **not** a claim: it is mutable, and a token carrying it
	 * would keep showing the old name for the rest of its 15 minutes. Anything
	 * that can change belongs behind /auth/me, not inside a signed blob.
	 */
	String mintAccessToken(User user, Instant now) {
		JwtClaimsSet claims = JwtClaimsSet.builder()
			.issuer(properties.getIssuer())
			.issuedAt(now)
			.expiresAt(now.plus(properties.getAccessTokenTtl()))
			.subject(user.getId().toString())
			.claim("email", user.getEmail())
			.claim("roles", List.of(user.getRole()))
			.build();

		JwsHeader header = JwsHeader.with(MacAlgorithm.HS256).build();
		return encoder.encode(JwtEncoderParameters.from(header, claims)).getTokenValue();
	}

	long accessTokenSeconds() {
		return properties.getAccessTokenTtl().toSeconds();
	}
}
