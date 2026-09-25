// Where study data comes from when an account is signed in.
//
// The accessor modules in this folder are **synchronous**, and a lot depends on
// that: Progress reads them inside useMemo, and some derivations run at import
// time. Making them async to fetch from the server would ripple through every
// caller. So this follows the same shape questionBank.js uses for the question
// bank — pull once, write into the store the accessors already read, and leave
// every read synchronous.
//
// The server is authoritative on hydrate. It holds every attempt this account
// has ever recorded, from any device; the browser holds only what happened
// here. Overwriting local with remote is what makes signing in on a second
// machine show your history rather than an empty dashboard.
//
// Writes go to both: local first so the UI is instant and offline still works,
// then the server. A failed POST is queued rather than dropped — losing a quiz
// somebody just sat because their wifi dipped would be the worst possible bug
// in a study app.

import { getJson, postJson, putJson, isConfigured } from '@/api/apiClient';
import { isPersistenceAllowed, scopedKey } from './persistence';
import { getDomainById } from './securityDomains';

const HISTORY_KEY = 'quiz_history';
const FLAG_KEY = 'flagged_questions';
const DAILY_KEY = 'daily_question';

/** Attempts that failed to reach the server, retried on the next hydrate. */
const PENDING_KEY = 'pending_attempts';

/* ------------------------------------------------------------- shape -- */

/**
 * The server sends `filedDomain` as a number; the browser stores the quizData
 * label string. Domain titles live in securityDomains.js and QuestionViews says
 * keeping them out of the API is deliberate, so the mapping happens here — the
 * same job `toQuizDataShape` does for questions in questionBank.js.
 */
const toLocalShape = (attempt) => ({
  ...attempt,
  domainBreakdown: (attempt.domainBreakdown ?? []).map((slice) => ({
    // filedDomain is 1-5; the domains are keyed domain1..domain5.
    domain: getDomainById(`domain${slice.filedDomain}`)?.quizLabel ?? null,
    percentage: slice.percentage,
    correct: slice.correct,
    total: slice.total,
  })),
});

const readLocal = (key, fallback) => {
  try {
    return JSON.parse(localStorage.getItem(scopedKey(key))) ?? fallback;
  } catch {
    return fallback;
  }
};

const writeLocal = (key, value) => {
  try {
    localStorage.setItem(scopedKey(key), JSON.stringify(value));
  } catch {
    // Private mode, or the quota is full. The server still has it.
  }
};

/* ----------------------------------------------------------- hydrate -- */

// Single-flight, the same way questionBank.js guards its hydrate: two
// components mounting at once must cause one request, not two.
let hydrating = null;

/**
 * Pulls this account's data down and writes it where the accessors read.
 *
 * Deliberately called *before* AuthProvider flips status to `authenticated`,
 * so the first signed-in render already has real data. Hydrating afterwards
 * would paint an empty dashboard for a beat, which reads as data loss.
 *
 * Never throws: a failed hydrate leaves whatever is local in place and the app
 * carries on, exactly as questionBank.js does when the API is unreachable.
 */
export function hydrate() {
  if (!isConfigured() || !isPersistenceAllowed()) return Promise.resolve(false);
  if (hydrating) return hydrating;

  hydrating = (async () => {
    await flushPending();

    const [attempts, flags, daily] = await Promise.all([
      getJson('/api/v1/me/attempts'),
      getJson('/api/v1/me/flags'),
      getJson('/api/v1/me/daily'),
    ]);

    // Union, not overwrite. The server holds everything recorded from any
    // device, but this browser may hold attempts it has never seen: history
    // written before sync existed, or before this account had an id on its
    // records. Replacing local with remote would delete exactly those.
    //
    // Anything local the server lacks is sent up and kept. Attempts written
    // before ids existed get one now, persisted back with the merged history,
    // so the next sync recognises them instead of uploading duplicates.
    const remote = attempts.map(toLocalShape);
    const known = new Set(remote.map((a) => a.id));
    const localOnly = readLocal(HISTORY_KEY, [])
      .map((a) => (a.id ? a : { ...a, id: crypto.randomUUID() }))
      .filter((a) => !known.has(a.id));

    localOnly.forEach(pushAttempt);

    const merged = [...remote, ...localOnly]
      .sort((a, b) => new Date(a.date) - new Date(b.date));

    writeLocal(HISTORY_KEY, merged);
    writeLocal(FLAG_KEY, flags);
    // The browser keys daily answers by date; the API sends a list.
    writeLocal(DAILY_KEY, Object.fromEntries(
      daily.map((d) => [d.date, { correct: d.correct, at: d.at }]),
    ));
    return true;
  })()
    .catch(() => false)
    .finally(() => {
      hydrating = null;
    });

  return hydrating;
}

/* ------------------------------------------------------------ writes -- */

/**
 * Sends one attempt up. Queued locally if it does not land, so the only way to
 * lose a quiz is to clear site data before the next sign-in.
 */
export function pushAttempt(attempt) {
  if (!isConfigured() || !isPersistenceAllowed()) return;

  postJson('/api/v1/me/attempts', attempt).catch(() => {
    const pending = readLocal(PENDING_KEY, []);
    // Keyed by the attempt's own id, so queueing twice cannot duplicate it.
    if (!pending.some((a) => a.id === attempt.id)) {
      writeLocal(PENDING_KEY, [...pending, attempt]);
    }
  });
}

async function flushPending() {
  const pending = readLocal(PENDING_KEY, []);
  if (pending.length === 0) return;

  const stillFailing = [];
  for (const attempt of pending) {
    try {
      // The server dedupes on the attempt id, so re-sending one that did
      // land after all is a no-op rather than a duplicate.
      await postJson('/api/v1/me/attempts', attempt);
    } catch {
      stillFailing.push(attempt);
    }
  }
  writeLocal(PENDING_KEY, stillFailing);
}

/** The whole set, matching how the browser holds flags and how PUT behaves. */
export function pushFlags(hashes) {
  if (!isConfigured() || !isPersistenceAllowed()) return;
  putJson('/api/v1/me/flags', hashes).catch(() => {
    // Flags are a convenience, not a record of work. Losing one to a failed
    // request is not worth a retry queue; the next toggle resends the set.
  });
}

export function pushDaily(dateKey, correct, at) {
  if (!isConfigured() || !isPersistenceAllowed()) return;
  postJson('/api/v1/me/daily', [{ date: dateKey, correct, at }]).catch(() => {
    // Same reasoning as flags: one missed day is not worth queueing.
  });
}
