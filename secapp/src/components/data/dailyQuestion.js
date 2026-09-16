// Question of the Day.
//
// The question is chosen from the date itself, not stored — so everyone gets
// the same question all day, it rolls over at local midnight, and there is
// nothing to keep in sync. Only the answer and the streak are persisted.
//
// The daily answer deliberately does NOT write to `quiz_history`: a single
// question scores either 0% or 100%, and letting that into the history would
// swing the Progress dashboard's average score wildly. The streak below is
// its own reward.

import { getAllQuestions, hashQuestion } from './quizData';
import { getDomainByQuizLabel } from './securityDomains';

const STORAGE_KEY = 'daily_question';

/** Local (not UTC) YYYY-MM-DD, so the question rolls over at the user's midnight. */
export const getDateKey = (date = new Date()) => {
  const year = date.getFullYear();
  const month = `${date.getMonth() + 1}`.padStart(2, '0');
  const day = `${date.getDate()}`.padStart(2, '0');
  return `${year}-${month}-${day}`;
};

const addDays = (dateKey, delta) => {
  const [y, m, d] = dateKey.split('-').map(Number);
  const date = new Date(y, m - 1, d);
  date.setDate(date.getDate() + delta);
  return getDateKey(date);
};

const greatestCommonDivisor = (a, b) => (b === 0 ? a : greatestCommonDivisor(b, a % b));

/**
 * A stride that walks the whole question bank before repeating.
 *
 * Hashing each date independently looked random but allowed the same question
 * to come up twice inside a fortnight, which is very noticeable on something
 * labelled "of the day". Stepping by a fixed amount coprime with the bank
 * size instead visits every question exactly once per full cycle — 466 days
 * at the current size — while consecutive days still land far apart.
 *
 * The golden-ratio starting point is the standard low-discrepancy choice; it
 * is nudged upward until it is coprime with the total, which also keeps this
 * correct if the bank grows.
 */
const strideFor = (total) => {
  let stride = Math.max(1, Math.round(total * 0.6180339887));
  while (greatestCommonDivisor(stride, total) !== 1) stride += 1;
  return stride;
};

/** Whole days since the epoch, from a local calendar date. */
const dayNumber = (dateKey) => {
  const [y, m, d] = dateKey.split('-').map(Number);
  return Math.floor(Date.UTC(y, m - 1, d) / 86400000);
};

/**
 * Today's question — derived from the date, never stored.
 *
 * Offset by a hash of a fixed salt so the cycle does not start at question 1
 * on day zero.
 */
export const getDailyQuestion = (dateKey = getDateKey()) => {
  const questions = getAllQuestions();
  if (questions.length === 0) return null;

  const total = questions.length;
  const offset = parseInt(hashQuestion('qotd'), 36) % total;
  const index = (offset + dayNumber(dateKey) * strideFor(total)) % total;
  const question = questions[index];

  return {
    ...question,
    id: hashQuestion(question.question),
    domainMeta: getDomainByQuizLabel(question.domain),
  };
};

/* ------------------------------------------------------------ answers -- */

const readRecords = () => {
  try {
    const stored = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
    return stored && typeof stored === 'object' ? stored : {};
  } catch {
    return {};
  }
};

export const getDailyRecord = (dateKey = getDateKey()) => readRecords()[dateKey] || null;

export const saveDailyAnswer = (dateKey, choiceIndex, correct) => {
  const records = readRecords();
  records[dateKey] = { choice: choiceIndex, correct, at: new Date().toISOString() };

  // 400 days is plenty of history for a streak and keeps the object small.
  const keys = Object.keys(records).sort();
  while (keys.length > 400) delete records[keys.shift()];

  localStorage.setItem(STORAGE_KEY, JSON.stringify(records));
  return records[dateKey];
};

/**
 * Consecutive days answered, ending today.
 *
 * Counting starts at yesterday when today is unanswered, so a streak built
 * over previous days still reads as live until the day is missed entirely.
 */
export const getStreak = (dateKey = getDateKey()) => {
  const records = readRecords();
  let cursor = records[dateKey] ? dateKey : addDays(dateKey, -1);
  let streak = 0;

  while (records[cursor]) {
    streak += 1;
    cursor = addDays(cursor, -1);
  }
  return streak;
};

/** Lifetime totals for the card's footer. */
export const getDailyTotals = () => {
  const records = Object.values(readRecords());
  return {
    answered: records.length,
    correct: records.filter((r) => r.correct).length,
  };
};

/** Milliseconds until the next question unlocks. */
export const msUntilTomorrow = (now = new Date()) => {
  const midnight = new Date(now);
  midnight.setHours(24, 0, 0, 0);
  return midnight - now;
};
