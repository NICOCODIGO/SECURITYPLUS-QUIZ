// Analytics over the `quiz_history` key written by TakeQuiz.
//
// This is the only module that derives statistics from quiz results. The
// Progress dashboard and the Weakest Subject quiz both read from here so the
// two can never disagree about which domain is weakest.
//
// Every selector takes an optional `history` argument. Passing one in is how
// the Progress page's sample-data toggle renders a populated dashboard
// through the exact same code path as real results.
//
// Records are written by TakeQuiz.handleSubmit() and look like:
//   { date, type, score, questionsCount, durationSeconds, domainTitle,
//     domainBreakdown: [{ domain, percentage, correct, total }],
//     answers:         [{ id, ok }] }
// Records written before `answers` / `durationSeconds` existed are still in
// people's browsers, so every selector below tolerates them being absent.

import { getDomainByQuizLabel } from './securityDomains';
import { getQuestionsByHash } from './quizData';

const STORAGE_KEY = 'quiz_history';

/** Keeps localStorage bounded — the array was previously unbounded. */
export const MAX_HISTORY_ENTRIES = 50;

export const getQuizHistory = () => {
  try {
    const stored = JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
    if (!Array.isArray(stored)) return [];
    return [...stored].sort((a, b) => new Date(a.date) - new Date(b.date));
  } catch {
    // Corrupt or unparseable history should degrade to an empty dashboard,
    // never crash the page.
    return [];
  }
};

/** Appends an attempt, trimming to the most recent MAX_HISTORY_ENTRIES. */
export const saveQuizAttempt = (attempt) => {
  const history = getQuizHistory();
  history.push(attempt);
  const trimmed = history.slice(-MAX_HISTORY_ENTRIES);
  localStorage.setItem(STORAGE_KEY, JSON.stringify(trimmed));
  return trimmed;
};

export const clearQuizHistory = () => localStorage.removeItem(STORAGE_KEY);

/**
 * Headline numbers for the stat cards.
 *
 * `questionsAnswered` / `correctAnswers` come from domainBreakdown rather
 * than from `score`, because a percentage alone cannot be re-weighted across
 * attempts of different lengths.
 */
export const getQuizStats = (history = getQuizHistory()) => {
  if (history.length === 0) {
    return {
      attempts: 0,
      averageScore: 0,
      bestScore: 0,
      bestScoreLabel: null,
      questionsAnswered: 0,
      correctAnswers: 0,
      studySeconds: 0,
    };
  }

  let questionsAnswered = 0;
  let correctAnswers = 0;
  let studySeconds = 0;
  let best = history[0];

  history.forEach((attempt) => {
    (attempt.domainBreakdown || []).forEach((d) => {
      questionsAnswered += d.total || 0;
      correctAnswers += d.correct || 0;
    });
    studySeconds += attempt.durationSeconds || 0;
    if ((attempt.score || 0) > (best.score || 0)) best = attempt;
  });

  const scoreSum = history.reduce((sum, a) => sum + (a.score || 0), 0);

  return {
    attempts: history.length,
    averageScore: Math.round(scoreSum / history.length),
    bestScore: best.score || 0,
    bestScoreLabel: describeAttempt(best),
    questionsAnswered,
    correctAnswers,
    studySeconds,
  };
};

/**
 * Accuracy per domain, joined to the domain metadata so callers get the icon
 * and colour tokens alongside the numbers.
 *
 * Returns every domain — including ones never attempted, flagged with
 * `attempted: false` — so the dashboard can show a complete five-row picture
 * instead of silently omitting the domains you have been avoiding.
 *
 * `ranked` holds only attempted domains, weakest first.
 */
export const getDomainPerformance = (history = getQuizHistory()) => {
  const totals = {};

  history.forEach((attempt) => {
    (attempt.domainBreakdown || []).forEach((entry) => {
      if (!entry.domain) return;
      if (!totals[entry.domain]) {
        totals[entry.domain] = { correct: 0, total: 0, attempts: 0 };
      }
      totals[entry.domain].correct += entry.correct || 0;
      totals[entry.domain].total += entry.total || 0;
      totals[entry.domain].attempts += 1;
    });
  });

  const rows = Object.entries(totals).map(([label, stats]) => {
    const domain = getDomainByQuizLabel(label);
    return {
      // `label` is the raw quizData string; `domain` may be undefined if a
      // question carries a label that is no longer in securityDomains.
      label,
      domain,
      title: domain ? domain.numberedTitle : label,
      correct: stats.correct,
      total: stats.total,
      attempts: stats.attempts,
      accuracy: stats.total > 0 ? Math.round((stats.correct / stats.total) * 100) : 0,
      attempted: true,
    };
  });

  const ranked = [...rows].sort((a, b) => a.accuracy - b.accuracy);

  return {
    rows,
    ranked,
    weakest: ranked[0] || null,
    strongest: ranked[ranked.length - 1] || null,
  };
};

/** Chronological scores, for the trend chart. */
export const getScoreTrend = (history = getQuizHistory()) =>
  history.map((attempt, index) => ({
    index,
    score: attempt.score || 0,
    date: attempt.date,
    label: describeAttempt(attempt),
  }));

/**
 * Questions missed most often across attempts.
 *
 * Only attempts recorded with an `answers` array contribute; older records
 * have no per-question detail and are skipped. A question whose text has
 * since been edited no longer resolves against the hash map and is dropped
 * rather than rendered as a blank row.
 */
export const getMostMissed = (history = getQuizHistory(), limit = 5) => {
  const byQuestion = new Map();

  history.forEach((attempt) => {
    (attempt.answers || []).forEach(({ id, ok }) => {
      if (!byQuestion.has(id)) byQuestion.set(id, { id, seen: 0, missed: 0 });
      const stat = byQuestion.get(id);
      stat.seen += 1;
      if (!ok) stat.missed += 1;
    });
  });

  const lookup = getQuestionsByHash();

  return [...byQuestion.values()]
    .filter((stat) => stat.missed > 0)
    .map((stat) => {
      const question = lookup.get(stat.id);
      if (!question) return null;
      return {
        ...stat,
        question: question.question,
        explanation: question.explanation,
        correctChoice: question.choices[question.correctAnswer],
        domain: getDomainByQuizLabel(question.domain),
        domainLabel: question.domain,
      };
    })
    .filter(Boolean)
    .sort((a, b) => b.missed - a.missed || b.seen - a.seen)
    .slice(0, limit);
};

/** Most recent attempts first, for the activity list. */
export const getRecentAttempts = (history = getQuizHistory(), limit = 8) =>
  [...history]
    .reverse()
    .slice(0, limit)
    .map((attempt) => ({
      ...attempt,
      label: describeAttempt(attempt),
      // 750/900 on the real exam is ~83%; TakeQuiz uses the same threshold.
      passed: attempt.type === 'mock' ? (attempt.score || 0) >= 83 : null,
    }));

/** Human-readable name for an attempt, e.g. "Mock Exam" or a domain title. */
export function describeAttempt(attempt) {
  if (!attempt) return '';
  if (attempt.type === 'mock') return 'Mock Exam';
  if (attempt.type === 'weakest') return 'Weakest Subject Practice';
  if (attempt.domainTitle) return attempt.domainTitle;

  // Pre-`domainTitle` records: fall back to the single domain they covered.
  const breakdown = attempt.domainBreakdown || [];
  if (breakdown.length === 1) {
    const domain = getDomainByQuizLabel(breakdown[0].domain);
    return domain ? domain.numberedTitle : breakdown[0].domain;
  }
  return 'Domain Quiz';
}

/** Seconds -> "1h 20m" / "45m" / "30s", for the Time Spent card. */
export const formatDuration = (seconds) => {
  if (!seconds) return '0m';
  if (seconds < 60) return `${seconds}s`;
  const hours = Math.floor(seconds / 3600);
  const minutes = Math.round((seconds % 3600) / 60);
  if (hours === 0) return `${minutes}m`;
  return minutes > 0 ? `${hours}h ${minutes}m` : `${hours}h`;
};
