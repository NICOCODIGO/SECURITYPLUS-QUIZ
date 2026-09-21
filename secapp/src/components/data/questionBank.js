// Which copy of the question bank the app is currently using.
//
// The bundled bank in quizData.js is the default and the fallback. It is
// synchronous, and nine places depend on that — including module-level
// derivations like securityDomains.questionCount. Converting all of them to
// async would mean rewriting the data layer, so instead the bundled bank is
// what everything reads at import time, and the API hydrates over it once it
// answers.
//
// Consequences worth knowing:
//   - Before hydration finishes, callers get the bundled bank. Today both
//     contain the same 444 questions, so the only thing at stake is an edit
//     made server-side in the last second.
//   - `securityDomains.questionCount` is derived at import time and therefore
//     always reflects the bundled bank. Use getBank().total for a live count.
//
// With VITE_API_URL unset, hydrate() returns immediately and nothing changes.

import { getJson, isConfigured, ApiError } from '@/api/apiClient';
import { quizQuestions as bundledByDomain, getAllQuestions as bundledAll } from './quizData';

/** The shape every consumer sees, whichever source it came from. */
const bundled = {
  source: 'bundled',
  byDomain: bundledByDomain,
  all: bundledAll(),
  get total() {
    return this.all.length;
  },
};

let current = bundled;
let hydrating = null;
const listeners = new Set();

/** The active bank: `{ source, byDomain, all, total }`. */
export const getBank = () => current;

/** True once the API's copy is in use. */
export const isLive = () => current.source === 'api';

/** Subscribe to source changes; returns an unsubscribe function. */
export function subscribe(listener) {
  listeners.add(listener);
  return () => listeners.delete(listener);
}

/** The API's maximum page size. Asking for more is a 400. */
const PAGE_SIZE = 200;

/** Guard against a paging bug turning into an unbounded loop. */
const MAX_PAGES = 20;

/**
 * Walk the paged endpoint until a short page comes back.
 *
 * The bank is 444 questions and the API caps a single response at 200, so one
 * call silently returns less than half of it — which is exactly the kind of
 * partial success that looks fine until a quiz can't find a question.
 */
async function fetchWholeBank() {
  const all = [];
  for (let page = 0; page < MAX_PAGES; page += 1) {
    const batch = await getJson('/api/v1/questions', { limit: PAGE_SIZE, page });
    if (!Array.isArray(batch)) return [];
    all.push(...batch);
    if (batch.length < PAGE_SIZE) return all;
  }
  console.warn(`[questionBank] stopped paging at ${MAX_PAGES} pages`);
  return all;
}

/**
 * The API returns choices as objects and the correct answer as a flag; the
 * rest of the app expects quizData's shape (a string array plus an index).
 * Translating here keeps that assumption in exactly one place.
 */
function toQuizDataShape(apiQuestion, domainLabels) {
  const choices = [...apiQuestion.choices].sort((a, b) => a.position - b.position);
  const correctAnswer = choices.findIndex((choice) => choice.correct);

  return {
    difficulty: apiQuestion.difficulty,
    // The label the rest of the app joins on, keyed off the *filed* domain so
    // domain quizzes keep asking what they ask today. Switching these to the
    // objective's domain is a deliberate product change, not a side effect of
    // moving to the API — see docs/content.md.
    domain: domainLabels[apiQuestion.filedDomain] ?? apiQuestion.objective,
    objective: apiQuestion.objective,
    question: apiQuestion.text,
    choices: choices.map((choice) => choice.text),
    correctAnswer,
    explanation: apiQuestion.explanation,
    // Carried through so the rationale lookup can prefer the server's copy.
    choiceRationales: Object.fromEntries(
      choices.filter((choice) => !choice.correct && choice.rationale)
        .map((choice) => [choice.text, choice.rationale]),
    ),
  };
}

/**
 * Fetch the bank from the API and swap it in. Safe to call more than once —
 * concurrent calls share one request.
 *
 * Never throws: a missing or unreachable API leaves the bundled bank in place,
 * which is the documented requirement, not a degraded mode.
 *
 * @returns {Promise<'api'|'bundled'>} which source is active afterwards
 */
export function hydrate() {
  if (!isConfigured() || current.source === 'api') {
    return Promise.resolve(current.source);
  }
  if (hydrating) {
    return hydrating;
  }

  hydrating = (async () => {
    try {
      const questions = await fetchWholeBank();
      if (questions.length === 0) {
        return 'bundled';
      }

      // Reuse the bundled labels rather than inventing new ones, so
      // getDomainByQuizLabel keeps matching.
      const domainLabels = {};
      Object.entries(bundledByDomain).forEach(([id, list]) => {
        const number = Number(id.replace('domain', ''));
        if (list[0]?.domain) domainLabels[number] = list[0].domain;
      });

      const all = questions.map((q) => toQuizDataShape(q, domainLabels));
      const byDomain = {};
      all.forEach((question, index) => {
        const id = `domain${questions[index].filedDomain}`;
        (byDomain[id] ??= []).push(question);
      });

      current = {
        source: 'api',
        byDomain,
        all,
        get total() {
          return this.all.length;
        },
      };
      listeners.forEach((listener) => listener(current));
      return 'api';
    } catch (error) {
      // Expected whenever the API is down; not worth a console.error, which
      // would make a supported configuration look broken.
      if (error instanceof ApiError) {
        console.info(`[questionBank] using the bundled bank — ${error.message}`);
      } else {
        console.warn('[questionBank] unexpected hydration failure', error);
      }
      return 'bundled';
    } finally {
      hydrating = null;
    }
  })();

  return hydrating;
}

/** Test seam: forget any hydrated bank and go back to the bundled one. */
export function resetForTests() {
  current = bundled;
  hydrating = null;
  listeners.clear();
}
