package com.secplus.auth;

/**
 * RFC 4648 Base32, because the JDK ships Base64 and nothing else.
 *
 * TOTP secrets are Base32 by convention — it is what every authenticator app
 * expects to be handed, and the alphabet avoids the characters people confuse
 * when typing a secret in by hand instead of scanning the QR.
 *
 * Padding is omitted on encode and tolerated on decode: authenticator apps
 * generally ignore it, and a secret that round-trips either way is one less
 * thing to get wrong.
 */
final class Base32 {

	private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";

	private Base32() {
	}

	static String encode(byte[] data) {
		StringBuilder out = new StringBuilder();
		int buffer = 0;
		int bitsLeft = 0;

		for (byte b : data) {
			buffer = (buffer << 8) | (b & 0xff);
			bitsLeft += 8;
			// Emit every whole five bits the buffer has accumulated.
			while (bitsLeft >= 5) {
				out.append(ALPHABET.charAt((buffer >> (bitsLeft - 5)) & 0x1f));
				bitsLeft -= 5;
			}
		}
		if (bitsLeft > 0) {
			// Left-align the remainder rather than dropping it.
			out.append(ALPHABET.charAt((buffer << (5 - bitsLeft)) & 0x1f));
		}
		return out.toString();
	}

	/** @throws IllegalArgumentException on a character outside the alphabet. */
	static byte[] decode(String encoded) {
		String cleaned = encoded.trim().replace("=", "").replace(" ", "").toUpperCase();
		byte[] out = new byte[cleaned.length() * 5 / 8];

		int buffer = 0;
		int bitsLeft = 0;
		int written = 0;

		for (char c : cleaned.toCharArray()) {
			int value = ALPHABET.indexOf(c);
			if (value < 0) {
				throw new IllegalArgumentException("Not Base32: " + c);
			}
			buffer = (buffer << 5) | value;
			bitsLeft += 5;
			if (bitsLeft >= 8) {
				out[written++] = (byte) ((buffer >> (bitsLeft - 8)) & 0xff);
				bitsLeft -= 8;
			}
		}
		return out;
	}
}
