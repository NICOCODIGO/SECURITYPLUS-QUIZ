package com.secplus.auth;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

/**
 * How an account proves the second step: a code emailed to it, or one from an
 * authenticator app.
 *
 * Stored lowercase because V2__account_security.sql constrains the column to
 * `('email', 'totp')`. That is why this is an AttributeConverter rather than
 * `@Enumerated(EnumType.STRING)` — the default would write `EMAIL`, which the
 * check constraint rejects at runtime with an error naming the constraint
 * rather than the cause.
 *
 * Null is a real and common value: it means 2FA is off. One nullable column
 * rather than a boolean plus a method, so "on, but by which means" stays a
 * single answerable question instead of two flags that can contradict.
 */
public enum TwoFactorMethod {

	/** A six-digit code sent to the account address. Needs no extra app. */
	EMAIL("email"),

	/** RFC 6238 TOTP. Survives losing access to the mailbox. */
	TOTP("totp");

	private final String value;

	TwoFactorMethod(String value) {
		this.value = value;
	}

	public String value() {
		return this.value;
	}

	/**
	 * Parses what the API was given. Unknown values are rejected here rather
	 * than reaching the database, where the same mistake surfaces as a
	 * constraint violation with no hint of which input caused it.
	 */
	static TwoFactorMethod parse(String raw) {
		if (raw != null) {
			for (TwoFactorMethod method : values()) {
				if (method.value.equalsIgnoreCase(raw)) {
					return method;
				}
			}
		}
		return null;
	}

	@Converter(autoApply = false)
	static class Mapping implements AttributeConverter<TwoFactorMethod, String> {

		@Override
		public String convertToDatabaseColumn(TwoFactorMethod method) {
			return (method == null) ? null : method.value;
		}

		@Override
		public TwoFactorMethod convertToEntityAttribute(String column) {
			return parse(column);
		}

	}

}
