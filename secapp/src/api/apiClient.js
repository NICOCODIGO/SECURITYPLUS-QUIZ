// Thin fetch wrapper for the Spring Boot API.
//
// The API is **optional**. `VITE_API_URL` unset means "there is no back end",
// and every caller must still work — the app has to run from a clean checkout
// with no Docker, no database and no account. So nothing here throws at import
// time, and `isConfigured()` is the switch callers check.
//
// Errors are deliberately boring: one ApiError type carrying the status, so a
// caller can tell "the server said no" (4xx/5xx) from "the server isn't there"
// (network, timeout, API not configured) without parsing strings.

import {
  getAccessToken,
  setAccessToken,
  notifyUnauthenticated,
} from './authSession';

const BASE_URL = (import.meta.env.VITE_API_URL ?? '').replace(/\/+$/, '');

/** Long enough for a cold App Runner container, short enough not to hang a page. */
const DEFAULT_TIMEOUT_MS = 8000;

export class ApiError extends Error {
  constructor(message, { status = null, cause = null } = {}) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.cause = cause;
  }

  /** True when the API is unreachable rather than refusing — the fallback case. */
  get isOffline() {
    return this.status === null;
  }
}

/** Whether a back end is configured at all. */
export const isConfigured = () => BASE_URL.length > 0;

export const apiBaseUrl = () => BASE_URL;

/** The API's CSRF defence on /auth/refresh and /auth/logout. See docs/backend.md. */
const CLIENT_HEADER = 'X-Secplus-Client';

const REFRESH_PATH = '/api/v1/auth/refresh';

async function send(method, path, { params = {}, body = null, auth = true, timeoutMs } = {}) {
  const url = new URL(`${BASE_URL}${path}`);
  Object.entries(params).forEach(([key, value]) => {
    if (value !== null && value !== undefined && value !== '') {
      url.searchParams.set(key, String(value));
    }
  });

  const headers = { Accept: 'application/json' };
  if (body !== null) headers['Content-Type'] = 'application/json';
  // Set here rather than at any call site: forgetting it makes refresh fail
  // and every session die after 15 minutes.
  if (path === REFRESH_PATH || path === '/api/v1/auth/logout') headers[CLIENT_HEADER] = 'web';

  const token = auth ? getAccessToken() : null;
  if (token) headers.Authorization = `Bearer ${token}`;

  // AbortSignal.timeout would be tidier, but Safari only shipped it in 16 and
  // a study app should not drop older phones over a convenience.
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs ?? DEFAULT_TIMEOUT_MS);

  let response;
  try {
    response = await fetch(url, {
      method,
      signal: controller.signal,
      headers,
      body: body === null ? undefined : JSON.stringify(body),
      // The refresh token is an httpOnly cookie.
      credentials: 'include',
    });
  } catch (error) {
    // Network failure, CORS rejection, or our own timeout — all "not there".
    throw new ApiError(`Cannot reach the API at ${BASE_URL}`, { cause: error });
  } finally {
    clearTimeout(timer);
  }

  if (!response.ok) {
    // The API returns RFC 7807 ProblemDetail on 400s; fall back to the status
    // line when the body is empty or not JSON (a proxy 502, say).
    let detail = response.statusText;
    try {
      const problem = await response.json();
      detail = problem.detail || problem.title || detail;
    } catch {
      // keep the status line
    }
    throw new ApiError(`API ${response.status}: ${detail}`, { status: response.status });
  }

  // 204 on logout, and any future empty success.
  if (response.status === 204) return null;
  return response.json();
}

/**
 * In-flight refresh, shared by every caller.
 *
 * This is the single most dangerous thing to get wrong in the whole auth
 * client. Refresh tokens **rotate**, and the server treats a second use of a
 * rotated token as theft and revokes the entire family. So three requests that
 * 401 at once must produce **one** refresh, not three: the other two would
 * present an already-rotated token, get the account's sessions revoked, and
 * sign the user out for no reason — looking exactly like a server bug.
 *
 * Same single-flight pattern as questionBank.js's `hydrate`.
 */
let refreshing = null;

function refreshSession() {
  if (refreshing) return refreshing;
  refreshing = send('POST', REFRESH_PATH, { auth: false })
    .then((session) => {
      setAccessToken(session.accessToken);
      return session;
    })
    .finally(() => {
      refreshing = null;
    });
  return refreshing;
}

async function request(method, path, options = {}) {
  if (!isConfigured()) {
    throw new ApiError('No API configured (VITE_API_URL is unset)');
  }

  try {
    return await send(method, path, options);
  } catch (error) {
    const sentWithToken = options.auth !== false && Boolean(getAccessToken());
    const retryable =
      error instanceof ApiError &&
      error.status === 401 &&
      sentWithToken &&
      path !== REFRESH_PATH &&
      !options.retried;

    // Only retry a request that actually carried a token. A 401 without one
    // means "not signed in", not "token expired" — retrying those would fire a
    // refresh on every anonymous page load.
    if (!retryable) throw error;

    try {
      await refreshSession();
    } catch {
      // Refresh failed: the session is genuinely over. Rethrow the original
      // 401 so the caller sees why its request failed, not why refresh did.
      notifyUnauthenticated();
      throw error;
    }

    return send(method, path, { ...options, retried: true });
  }
}

/**
 * GET a JSON endpoint.
 *
 * @param {string} path      e.g. '/api/v1/questions'
 * @param {object} [params]  query params; null/undefined values are dropped
 */
export function getJson(path, params = {}, options = {}) {
  return request('GET', path, { ...options, params });
}

export function postJson(path, body = null, options = {}) {
  return request('POST', path, { ...options, body });
}

export { refreshSession };
