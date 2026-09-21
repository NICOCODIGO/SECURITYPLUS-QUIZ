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

/**
 * GET a JSON endpoint.
 *
 * @param {string} path      e.g. '/api/v1/questions'
 * @param {object} [params]  query params; null/undefined values are dropped
 */
export async function getJson(path, params = {}, { timeoutMs = DEFAULT_TIMEOUT_MS } = {}) {
  if (!isConfigured()) {
    throw new ApiError('No API configured (VITE_API_URL is unset)');
  }

  const url = new URL(`${BASE_URL}${path}`);
  Object.entries(params).forEach(([key, value]) => {
    if (value !== null && value !== undefined && value !== '') {
      url.searchParams.set(key, String(value));
    }
  });

  // AbortSignal.timeout would be tidier, but Safari only shipped it in 16 and
  // a study app should not drop older phones over a convenience.
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);

  let response;
  try {
    response = await fetch(url, {
      signal: controller.signal,
      headers: { Accept: 'application/json' },
      // Needed from phase 2: the refresh token is an httpOnly cookie.
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

  return response.json();
}
