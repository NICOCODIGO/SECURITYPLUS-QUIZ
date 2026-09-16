// Sample data used to show what a populated dashboard looks like.
//
// Two consumers:
//  - ProgressPreview (Home) uses `demoProgressData` for the marketing teaser
//    shown to visitors with no progress of their own.
//  - The Progress page's "Sample data" toggle uses `demoQuizHistory`.
//
// Neither is ever written to localStorage — sample mode passes the fixture
// straight into the quizHistoryData selectors, so what you see is rendered by
// the same code that renders real results.

import { quizQuestions, hashQuestion } from '../components/data/quizData';
import { securityDomains } from '../components/data/securityDomains';

// Placeholder numbers for the Home page dashboard teaser.
export const demoProgressData = {
  lessonsCompleted: 4,
  totalLessons: 6,
  averageQuizScore: 87,
  timeSpent: '12h',
  completionRate: 67,
};

// Per-domain accuracy the fixture should reproduce. Domain 4 is deliberately
// the weak one — it matches the real gap in the question bank and gives the
// "needs work" states something to highlight.
const DOMAIN_ACCURACY = {
  domain1: 0.82,
  domain2: 0.76,
  domain3: 0.71,
  domain4: 0.44,
  domain5: 0.88,
};

// Attempts, oldest first. `improve` nudges accuracy upward over time so the
// trend chart has a visible upward slope instead of noise.
const ATTEMPTS = [
  { daysAgo: 34, domain: 'domain1', count: 15, minutes: 11, improve: -0.10 },
  { daysAgo: 31, domain: 'domain2', count: 15, minutes: 13, improve: -0.09 },
  { daysAgo: 27, domain: 'domain4', count: 12, minutes: 14, improve: -0.08 },
  { daysAgo: 24, domain: 'domain1', count: 20, minutes: 16, improve: -0.04 },
  { daysAgo: 20, domain: 'domain3', count: 15, minutes: 12, improve: -0.04 },
  { daysAgo: 17, type: 'mock', count: 40, minutes: 44, improve: -0.03 },
  { daysAgo: 13, domain: 'domain4', count: 20, minutes: 19, improve: 0.00, weakest: true },
  { daysAgo: 10, domain: 'domain5', count: 15, minutes: 11, improve: 0.02 },
  { daysAgo: 7, domain: 'domain2', count: 20, minutes: 15, improve: 0.04 },
  { daysAgo: 5, domain: 'domain4', count: 20, minutes: 18, improve: 0.05, weakest: true },
  { daysAgo: 2, domain: 'domain3', count: 20, minutes: 14, improve: 0.07 },
  { daysAgo: 1, type: 'mock', count: 40, minutes: 41, improve: 0.08 },
];

const clamp = (value, min, max) => Math.min(max, Math.max(min, value));

// Deterministic picker — the fixture must look identical on every render, so
// no Math.random() here.
const pickQuestions = (domainId, count, offset) => {
  const pool = quizQuestions[domainId] || [];
  if (pool.length === 0) return [];
  return Array.from({ length: count }, (_, i) => pool[(offset + i * 3) % pool.length]);
};

const buildAttempt = (spec, seed) => {
  const isMock = spec.type === 'mock';

  // A mock spreads its questions across all five domains, weighted by exam
  // weight, the way MockExam builds a real one.
  const slices = isMock
    ? securityDomains.map((d) => ({
        domainId: d.id,
        count: Math.max(2, Math.round(spec.count * (parseInt(d.weight, 10) / 100))),
      }))
    : [{ domainId: spec.domain, count: spec.count }];

  const answers = [];
  const domainBreakdown = [];

  slices.forEach((slice, sliceIndex) => {
    const domain = securityDomains.find((d) => d.id === slice.domainId);
    const questions = pickQuestions(slice.domainId, slice.count, seed + sliceIndex * 7);
    if (questions.length === 0) return;

    const accuracy = clamp(
      (DOMAIN_ACCURACY[slice.domainId] ?? 0.7) + spec.improve,
      0.2,
      0.97
    );
    const correctCount = Math.round(questions.length * accuracy);

    questions.forEach((question, i) => {
      // Spread the wrong answers through the set rather than bunching them at
      // the end, so "most missed" lands on a varied spread of questions.
      const ok = (i * correctCount) % questions.length < correctCount;
      answers.push({ id: hashQuestion(question.question), ok });
    });

    const correct = answers.slice(-questions.length).filter((a) => a.ok).length;
    domainBreakdown.push({
      domain: domain.quizLabel,
      percentage: Math.round((correct / questions.length) * 100),
      correct,
      total: questions.length,
    });
  });

  const totalQuestions = domainBreakdown.reduce((sum, d) => sum + d.total, 0);
  const totalCorrect = domainBreakdown.reduce((sum, d) => sum + d.correct, 0);

  const date = new Date();
  date.setDate(date.getDate() - spec.daysAgo);
  date.setHours(19, 30, 0, 0);

  const domain = spec.domain
    ? securityDomains.find((d) => d.id === spec.domain)
    : null;

  return {
    date: date.toISOString(),
    type: isMock ? 'mock' : spec.weakest ? 'weakest' : 'domain',
    score: totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0,
    questionsCount: totalQuestions,
    durationSeconds: spec.minutes * 60,
    domainTitle: domain ? domain.numberedTitle : null,
    domainBreakdown,
    answers,
  };
};

export const demoQuizHistory = ATTEMPTS.map((spec, i) => buildAttempt(spec, i * 5));
