// Analytics over the `quiz_history` key written by TakeQuiz.
//
// This is the only module that derives statistics from quiz results. The
// Progress dashboard and the Weakest Subject quiz both read from here so the
// two can never disagree about which domain is weakest.
//
// Every selector takes an optional `history` argument. Passing one in is how
// Home's ProgressPreview renders a populated teaser from a fixture through the
// exact same code path as real results — and it is the seam the back end plugs
// into in phase 3.
//
// Records are written by TakeQuiz.handleSubmit() and look like:
//   { date, type, score, questionsCount, durationSeconds, domainTitle,
//     domainBreakdown: [{ domain, percentage, correct, total }],
//     answers:         [{ id, ok }] }
// Records written before `answers` / `durationSeconds` existed are still in
// people's browsers, so every selector below tolerates them being absent.

import { getDomainByQuizLabel } from './securityDomains';
import { getQuestionsByHash } from './quizData';
import { isPersistenceAllowed, scopedKey } from './persistence';
import { pushAttempt } from './source';
import { MOCK_PASS_MARK } from '@/lib/performanceStatus';

/** Namespaced per account by scopedKey — see persistence.js. */
const STORAGE_KEY = 'quiz_history';

/** Keeps localStorage bounded — the array was previously unbounded. */
export const MAX_HISTORY_ENTRIES = 50;

export const getQuizHistory = () => {
  // Signed out, there is no history to report. The key is not cleared — see
  // persistence.js; this hides it, it does not destroy it.
  if (!isPersistenceAllowed()) return [];

  try {
    const stored = JSON.parse(localStorage.getItem(scopedKey(STORAGE_KEY)) || '[]');
    if (!Array.isArray(stored)) return [];
    return [...stored].sort((a, b) => new Date(a.date) - new Date(b.date));
  } catch {
    // Corrupt or unparseable history should degrade to an empty dashboard,
    // never crash the page.
    return [];
  }
};

/**
 * Appends an attempt, trimming to the most recent MAX_HISTORY_ENTRIES.
 *
 * A no-op when signed out. The quiz still scores and still shows its results —
 * the score lives in TakeQuiz's own state — it just leaves nothing behind.
 */
export const saveQuizAttempt = (attempt) => {
  if (!isPersistenceAllowed()) return [];

  const history = getQuizHistory();
  history.push(attempt);
  const trimmed = history.slice(-MAX_HISTORY_ENTRIES);
  localStorage.setItem(scopedKey(STORAGE_KEY), JSON.stringify(trimmed));

  // Local first so the results screen is instant and works offline, then up.
  // The local cap of 50 does not apply to the server, which keeps everything —
  // so an older attempt trimmed from here is still there on the next sign-in.
  pushAttempt(attempt);
  return trimmed;
};

export const clearQuizHistory = () => {
  if (!isPersistenceAllowed()) return;
  localStorage.removeItem(scopedKey(STORAGE_KEY));
};

/**
 * Questions answered and answered correctly in one attempt, from its
 * domainBreakdown. Records too old to have one fall back to questionsCount
 * and the score; with neither, the attempt carries no weight.
 */
const attemptCounts = (attempt) => {
  const breakdown = attempt.domainBreakdown || [];
  if (breakdown.length > 0) {
    return breakdown.reduce(
      (sum, d) => ({ correct: sum.correct + (d.correct || 0), total: sum.total + (d.total || 0) }),
      { correct: 0, total: 0 },
    );
  }
  const total = attempt.questionsCount || 0;
  return { correct: Math.round(((attempt.score || 0) / 100) * total), total };
};

/**
 * Average accuracy weighted by question, not by attempt: total correct over
 * total answered. Averaging per-attempt scores instead let a 10-question quiz
 * count as much as a 90-question mock, so getting 0/10 after 72/90 dragged
 * the average from 80% to 40% rather than to 72%. Falls back to the plain
 * mean of scores only when no attempt has question counts at all.
 */
const weightedAverage = (attempts) => {
  if (attempts.length === 0) return 0;
  let correct = 0;
  let total = 0;
  attempts.forEach((attempt) => {
    const counts = attemptCounts(attempt);
    correct += counts.correct;
    total += counts.total;
  });
  if (total > 0) return Math.round((correct / total) * 100);
  return Math.round(attempts.reduce((sum, a) => sum + (a.score || 0), 0) / attempts.length);
};

/**
 * Headline numbers for the stat cards.
 *
 * `questionsAnswered` / `correctAnswers` come from domainBreakdown rather
 * than from `score`, because a percentage alone cannot be re-weighted across
 * attempts of different lengths. `averageScore` is weighted the same way, so
 * it always agrees with "correctAnswers of questionsAnswered".
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
    const counts = attemptCounts(attempt);
    questionsAnswered += counts.total;
    correctAnswers += counts.correct;
    studySeconds += attempt.durationSeconds || 0;
    if ((attempt.score || 0) > (best.score || 0)) best = attempt;
  });

  return {
    attempts: history.length,
    averageScore: weightedAverage(history),
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
 * `ranked` holds only attempted domains, weakest first. `strongest` and
 * `weakest` stay null until there is a real spread to compare — with one
 * attempted domain, or all tied, they would otherwise name the same score.
 * Callers that just need "the lowest domain so far" should use `ranked[0]`.
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
  const lowest = ranked[0];
  const highest = ranked[ranked.length - 1];
  const hasSpread = ranked.length > 1 && highest.accuracy > lowest.accuracy;

  return {
    rows,
    ranked,
    weakest: hasSpread ? lowest : null,
    strongest: hasSpread ? highest : null,
  };
};

/** Every value `type` takes on a stored attempt. */
export const PRACTICE_MODES = ['domain', 'mock', 'weakest', 'custom'];

/**
 * Per-mode numbers — how many of each kind of quiz were taken, and how they
 * went. Feeds the Quiz Center cards and the Progress page's practice mix.
 *
 * Attempts with no (or an unknown) `type` count as domain quizzes, which is
 * what TakeQuiz defaults to. `averageScore` is weighted by question, like
 * getQuizStats — custom quizzes run from 10 to 50 questions.
 */
export const getModeStats = (history = getQuizHistory()) => {
  const stats = {};
  const byMode = {};
  PRACTICE_MODES.forEach((mode) => {
    stats[mode] = { count: 0, averageScore: 0, bestScore: 0, lastScore: null, passes: 0 };
    byMode[mode] = [];
  });

  history.forEach((attempt) => {
    const mode = stats[attempt.type] ? attempt.type : 'domain';
    const entry = stats[mode];
    const score = attempt.score || 0;

    entry.count += 1;
    entry.bestScore = Math.max(entry.bestScore, score);
    entry.lastScore = score; // history is chronological
    if (mode === 'mock' && score >= MOCK_PASS_MARK) entry.passes += 1;
    byMode[mode].push(attempt);
  });

  PRACTICE_MODES.forEach((mode) => {
    stats[mode].averageScore = weightedAverage(byMode[mode]);
  });

  return stats;
};

/**
 * Chronological scores for the trend chart, with mock exams kept apart from
 * practice (domain, weakest-subject and custom quizzes). A short practice
 * quiz and a full mock on one line made a bad 10-question quiz look like a
 * failed exam, and the mock pass mark only means anything for mocks.
 */
export const getScoreTrend = (history = getQuizHistory()) => {
  const points = history.map((attempt) => ({
    score: attempt.score || 0,
    date: attempt.date,
    label: describeAttempt(attempt),
    isMock: attempt.type === 'mock',
  }));
  return {
    practice: points.filter((point) => !point.isMock),
    mock: points.filter((point) => point.isMock),
  };
};

/** Whether the plotted series has the two points a line needs. */
export const canDrawTrend = (trend) => trend.practice.length >= 2;

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
      passed: attempt.type === 'mock' ? (attempt.score || 0) >= MOCK_PASS_MARK : null,
    }));

/** Human-readable name for an attempt, e.g. "Mock Exam" or a domain title. */
export function describeAttempt(attempt) {
  if (!attempt) return '';
  if (attempt.type === 'mock') return 'Mock Exam';
  if (attempt.type === 'weakest') return 'Weakest Subject Practice';
  if (attempt.type === 'custom') return 'Custom Quiz';
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
