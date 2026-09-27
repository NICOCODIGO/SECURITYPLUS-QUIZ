// Where to send someone after they sign in, from the `?next=` parameter.
//
// Only a path on this site. Anything else makes `?next=` an open redirect: a
// link to certucation.click/login?next=... that, after a perfectly genuine
// sign-in, lands the person on a look-alike page asking for their password
// again. So the value is resolved the way the browser would resolve it, and
// kept only if it is still this origin:
//
// - `//evil.example` is protocol-relative and leaves the site.
// - `/\evil.example` looks like a path, but browsers read a backslash as a
//   slash, so it becomes `//evil.example`. React Router had exactly this bug
//   (GHSA-wrjc-x8rr-h8h6), which is why a prefix check alone is not enough.
// - Tabs and newlines are stripped by URL parsing, so `/\t/evil.example`
//   collapses to `//evil.example` too. Control characters are refused outright.
//
// Plain JS with no React, so it can be exercised directly with node.

const FALLBACK = '/progress';

// eslint-disable-next-line no-control-regex
const UNSAFE = /[\\\u0000-\u001f\u007f]/;

export const safeNext = (value, origin = window.location.origin) => {
  if (typeof value !== 'string' || !value.startsWith('/') || UNSAFE.test(value)) {
    return FALLBACK;
  }
  try {
    const url = new URL(value, origin);
    if (url.origin !== origin) {
      return FALLBACK;
    }
    return url.pathname + url.search + url.hash;
  } catch {
    return FALLBACK;
  }
};
