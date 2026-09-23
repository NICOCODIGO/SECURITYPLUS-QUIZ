// Where the access token lives, and nothing else.
//
// **Deliberately not a browser-storage accessor module.** CLAUDE.md rule 8
// governs modules that own a localStorage key; this one owns no key and stores
// nothing, which is the entire point — see below.
//
// The access token is held in a module-level variable. It carries full account
// authority for 15 minutes, and localStorage is readable by any script on the
// origin (this app renders markdown through react-markdown), so putting it
// there would turn any XSS into account takeover that outlives the tab. The
// refresh token is an httpOnly cookie precisely so script cannot read it;
// keeping the access token in storage would throw that protection away for
// convenience.
//
// The cost is real and specific: the quiz flow navigates with
// `window.location.href`, so it crosses two full page reloads and this variable
// is lost at each one. That is survivable **only** because AuthProvider fires a
// silent /auth/refresh on mount — the cookie survives the reload and re-mints.
// The in-memory choice and the boot refresh are one decision, not two.

let accessToken = null;

/**
 * Whether an account is signed in, readable outside React.
 *
 * Kept separately from `accessToken` because the token is briefly absent
 * during a refresh while the session is still perfectly valid — gating on the
 * token would make `isSessionActive()` flicker false mid-session. AuthProvider
 * owns this flag; `components/data/persistence.js` is what reads it.
 */
let sessionActive = false;

/**
 * Who is signed in, for namespacing their stored data.
 *
 * Without this the storage keys are global and two people sharing a browser
 * read each other's quiz history — see components/data/persistence.js.
 */
let userId = null;

/** Called when a refresh fails, so React can drop to the anonymous state. */
let onUnauthenticated = null;

export const isSessionActive = () => sessionActive;

export const getUserId = () => userId;

export const setSessionActive = (active) => {
  sessionActive = active;
};

export const setUserId = (id) => {
  userId = id;
};

export const getAccessToken = () => accessToken;

export const setAccessToken = (token) => {
  accessToken = token;
};

export const clearAccessToken = () => {
  accessToken = null;
};

export const setUnauthenticatedHandler = (handler) => {
  onUnauthenticated = handler;
};

export const notifyUnauthenticated = () => {
  clearAccessToken();
  sessionActive = false;
  userId = null;
  if (onUnauthenticated) onUnauthenticated();
};
