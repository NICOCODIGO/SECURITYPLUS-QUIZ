// The one decision about whose study data is kept.
//
// Every accessor module in this folder asks this before reading or writing, so
// there is exactly one line to change if the policy changes.
//
// **Policy: study data is kept only while an account is signed in.**
// Signed out, a quiz can be taken and scored in full — the result is shown as
// normal — but nothing is written and nothing previously written is read.
//
// Two consequences, both deliberate and both chosen with them on the table:
//
//  1. It narrows CLAUDE.md rule 2. Progress *reporting* now needs an account,
//     where before it worked anonymously against browser storage.
//  2. With VITE_API_URL unset there is no API, therefore no account, therefore
//     no persistence at all. A clean checkout still runs every quiz, the
//     question bank, and Question of the Day — but the Progress dashboard,
//     the streak and the weakest-subject drill stay empty, because there is
//     nothing for them to read. `docs/decisions.md` records this.
//
// Nothing here deletes anything. A signed-out browser stops reading its old
// `quiz_history`, but the key is left alone: the policy is reversible and
// nobody's history is destroyed by it.

import { getUserId, isSessionActive } from '@/api/authSession';

/** True only while an account is signed in. */
export const isPersistenceAllowed = () => isSessionActive();

/**
 * The storage key for the signed-in account.
 *
 * Every key is namespaced by user id, because two people share a browser more
 * often than the word "local storage" suggests — a family laptop, a library
 * machine, a classroom. Without this, the second person to sign in reads the
 * first person's quiz history as their own and appends to it, which is exactly
 * what an account is supposed to prevent.
 *
 * Callers are already behind `isPersistenceAllowed()`, so there is no signed-out
 * path here; the throw is a tripwire for a future caller that forgets, not a
 * condition expected to happen.
 *
 * Note this abandons any pre-existing un-namespaced key rather than migrating
 * it. Data written before accounts existed belongs to whoever was using the
 * browser, and quietly adopting it into the first account to sign in would be
 * the same bug in a different shape.
 */
export const scopedKey = (base) => {
  const id = getUserId();
  if (!id) throw new Error(`scopedKey("${base}") called while signed out`);
  return `${base}:${id}`;
};
