// The auth calls. Thin on purpose — AuthProvider owns the state, this owns
// the URLs.

import { postJson, getJson } from '@/api/apiClient';

const BASE = '/api/v1/auth';

/** `auth: false` because these carry no bearer token by definition. */
export const register = (email, password, displayName) =>
  postJson(`${BASE}/register`, { email, password, displayName }, { auth: false });

/**
 * Resolves to one of two shapes: a session, or `{ challenge, twoFactorMethod }`
 * when the account has a second step. Callers branch on `challenge` — see
 * AuthProvider.signIn, which is the only place that should need to.
 */
export const login = (email, password) =>
  postJson(`${BASE}/login`, { email, password }, { auth: false });

/** The second step. One field for both a six-digit code and a recovery code. */
export const verifyTwoFactor = (challenge, code) =>
  postJson(`${BASE}/2fa/verify`, { challenge, code }, { auth: false });

export const logout = () => postJson(`${BASE}/logout`, null, { auth: false });

export const me = () => getJson(`${BASE}/me`);

// ------------------------------------------------- verification and reset --

// All four are reachable by someone who cannot sign in — that is the point of
// them — so none carries a bearer token.

export const verifyEmail = (token) =>
  postJson(`${BASE}/verify-email`, { token }, { auth: false });

/** Always resolves, whether or not the address has an account. */
export const forgotPassword = (email) =>
  postJson(`${BASE}/forgot-password`, { email }, { auth: false });

export const resetPassword = (token, password) =>
  postJson(`${BASE}/reset-password`, { token, password }, { auth: false });

export const resendVerification = () => postJson(`${BASE}/resend-verification`, null);

// ------------------------------------------------------------ managing 2FA --

export const twoFactorStatus = () => getJson(`${BASE}/2fa`);

/** For TOTP the response carries the secret and its provisioning URI, once. */
export const beginTwoFactorSetup = (method) => postJson(`${BASE}/2fa/setup`, { method });

/** The only response that ever contains recovery codes in the clear. */
export const confirmTwoFactorSetup = (method, code) =>
  postJson(`${BASE}/2fa/confirm`, { method, code });

export const disableTwoFactor = (password) => postJson(`${BASE}/2fa/disable`, { password });

export const regenerateRecoveryCodes = (password) =>
  postJson(`${BASE}/2fa/recovery-codes`, { password });
