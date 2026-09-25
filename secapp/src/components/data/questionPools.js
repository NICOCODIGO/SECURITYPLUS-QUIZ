// Question pools for the custom quiz builder.
//
// Three of the four pools are derived from `quiz_history` — specifically the
// per-question `answers: [{ id, ok }]` array TakeQuiz records — so "questions
// I've never seen" and "questions I got wrong" need no extra storage. The
// fourth, flagged, is the one thing the user marks by hand, and it lives in
// its own key.

import { getAllQuestions, hashQuestion } from './quizData';
import { getQuizHistory } from './quizHistoryData';
import { isPersistenceAllowed, scopedKey } from './persistence';
import { pushFlags } from './source';

/** Namespaced per account by scopedKey — see persistence.js. */
const FLAG_KEY = 'flagged_questions';

/* ---------------------------------------------------------------- flags -- */

export const getFlaggedIds = () => {
  if (!isPersistenceAllowed()) return new Set();

  try {
    const stored = JSON.parse(localStorage.getItem(scopedKey(FLAG_KEY)) || '[]');
    return new Set(Array.isArray(stored) ? stored : []);
  } catch {
    return new Set();
  }
};

export const isFlagged = (questionId) => getFlaggedIds().has(questionId);

/**
 * Adds or removes a flag; returns true if the question is now flagged.
 *
 * Signed out this only reports what the caller asked for — TakeQuiz mirrors
 * flags into React state, so the icon still toggles within the quiz. It just
 * does not survive the page.
 */
export const toggleFlag = (questionId) => {
  const flagged = getFlaggedIds();
  const nowFlagged = !flagged.has(questionId);

  if (nowFlagged) flagged.add(questionId);
  else flagged.delete(questionId);

  if (isPersistenceAllowed()) {
    localStorage.setItem(scopedKey(FLAG_KEY), JSON.stringify([...flagged]));
    // The whole set, because that is what PUT /me/flags replaces.
    pushFlags([...flagged]);
  }
  return nowFlagged;
};

export const clearFlags = () => {
  if (!isPersistenceAllowed()) return;
  localStorage.removeItem(scopedKey(FLAG_KEY));
};

/* ------------------------------------------------------- derived pools -- */

/**
 * Which questions have been seen, and which have been missed.
 *
 * Attempts recorded before TakeQuiz stored `answers` contribute nothing —
 * there is no per-question record in them to read.
 */
export const getAnswerIndex = (history = getQuizHistory()) => {
  const seen = new Set();
  const incorrect = new Set();

  history.forEach((attempt) => {
    (attempt.answers || []).forEach(({ id, ok }) => {
      seen.add(id);
      if (!ok) incorrect.add(id);
    });
  });

  return { seen, incorrect };
};

export const POOL_KINDS = ['new', 'incorrect', 'flagged', 'answered'];

export const POOL_LABELS = {
  new: 'Never seen',
  answered: 'Already answered',
  incorrect: 'Got wrong before',
  flagged: 'Flagged for review',
};

export const POOL_DESCRIPTIONS = {
  new: 'Questions you have not been asked yet',
  answered: 'Everything you have answered at least once',
  incorrect: 'Questions you have missed at least once',
  flagged: 'Questions you flagged while taking a quiz',
};

/**
 * Split the whole question bank into the four pools.
 *
 * `answered` and `incorrect` deliberately overlap — a question you got wrong
 * is also a question you've answered. Selecting both pools in the builder
 * unions them rather than double-counting.
 *
 * Deduplicated by id, because the bank currently holds 22 questions whose
 * text appears twice (some within one domain, some in two). They share an id,
 * so without this the counts shown on the pool buttons would be higher than
 * the number of questions a quiz could actually draw.
 */
export const getQuestionPools = (history = getQuizHistory()) => {
  const { seen, incorrect } = getAnswerIndex(history);
  const flagged = getFlaggedIds();

  const pools = { new: [], answered: [], incorrect: [], flagged: [] };
  const claimed = new Set();

  getAllQuestions().forEach((question) => {
    const id = hashQuestion(question.question);
    if (claimed.has(id)) return;
    claimed.add(id);

    const entry = { ...question, id };

    if (seen.has(id)) pools.answered.push(entry);
    else pools.new.push(entry);

    if (incorrect.has(id)) pools.incorrect.push(entry);
    if (flagged.has(id)) pools.flagged.push(entry);
  });

  return pools;
};

/**
 * Questions matching the chosen pools, domains and difficulty.
 *
 * Pools are unioned (deduplicated by id), then the domain and difficulty
 * filters narrow the result. An empty `domainIds` or `difficulties` means
 * "no filter" rather than "nothing".
 */
export const buildCustomPool = ({
  pools: selectedPools,
  domainIds = [],
  difficulties = [],
  history,
} = {}) => {
  const pools = getQuestionPools(history);
  const byId = new Map();

  (selectedPools || []).forEach((kind) => {
    (pools[kind] || []).forEach((question) => byId.set(question.id, question));
  });

  let questions = [...byId.values()];

  if (domainIds.length > 0) {
    const labels = new Set(domainIds);
    questions = questions.filter((q) => labels.has(q.domain));
  }
  if (difficulties.length > 0) {
    const wanted = new Set(difficulties);
    questions = questions.filter((q) => wanted.has(q.difficulty));
  }

  return questions;
};

/** Fisher-Yates — an unbiased shuffle, unlike `sort(() => Math.random() - 0.5)`. */
export const shuffle = (items) => {
  const copy = [...items];
  for (let i = copy.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
};
