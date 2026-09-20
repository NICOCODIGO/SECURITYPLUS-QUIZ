import React, { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Switch } from '@/components/ui/switch';
import {
  Target,
  Clock,
  Award,
  ListChecks,
  FlaskConical,
  ArrowRight,
} from 'lucide-react';
import DomainPerformancePanel from '../components/progress/DomainPerformancePanel';
import ScoreTrendChart from '../components/progress/ScoreTrendChart';
import MostMissedPanel from '../components/progress/MostMissedPanel';
import RecentActivityPanel from '../components/progress/RecentActivityPanel';
import PracticeMixPanel from '../components/progress/PracticeMixPanel';
import KpiTile from '../components/progress/KpiTile';
import {
  getQuizHistory,
  getQuizStats,
  getModeStats,
  getDomainPerformance,
  getScoreTrend,
  getMostMissed,
  getRecentAttempts,
  formatDuration,
} from '../components/data/quizHistoryData';
import { getDailyTotals, getStreak } from '../components/data/dailyQuestion';
import { demoQuizHistory, demoDailyStats } from '@/lib/demoProgressData';
import { MOCK_PASS_MARK } from '@/lib/performanceStatus';

/**
 * Progress Page
 * --------------------------------------------------
 * Learning analytics derived from `quiz_history`, the key TakeQuiz writes
 * when a quiz is submitted.
 *
 * Laid out as a dashboard: a header band with the headline numbers,
 * then a grid of panels that pair up side by side from lg, so the whole
 * picture reads without a long single-column scroll.
 *
 * The "Sample data" switch swaps the history array for a fixture and feeds it
 * through the identical selectors, so the populated layout can be reviewed
 * before taking a single quiz. It never writes to localStorage — turning it
 * off returns you to your real results untouched.
 *
 * When real auth arrives, this is where per-user data gets fetched instead of
 * read from localStorage.
 */
export default function Progress() {
  const [showSample, setShowSample] = useState(false);

  const realHistory = useMemo(() => getQuizHistory(), []);
  const history = showSample ? demoQuizHistory : realHistory;

  const stats = useMemo(() => getQuizStats(history), [history]);
  const modes = useMemo(() => getModeStats(history), [history]);
  const performance = useMemo(() => getDomainPerformance(history), [history]);
  // The daily question keeps its own key, so sample mode swaps it separately.
  const daily = useMemo(
    () => (showSample ? demoDailyStats : { ...getDailyTotals(), streak: getStreak() }),
    [showSample]
  );
  const trend = useMemo(() => getScoreTrend(history), [history]);
  const missed = useMemo(() => getMostMissed(history, 5), [history]);
  const attempts = useMemo(() => getRecentAttempts(history, 8), [history]);

  const hasHistory = history.length > 0;
  const averageQuizTime =
    stats.attempts > 0 ? formatDuration(Math.round(stats.studySeconds / stats.attempts)) : null;

  return (
    <div className="-mt-8 space-y-6">
      {/* ── Header band ─────────────────────────────────── */}
      <section className="full-bleed bg-white border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-6">
          <div className="flex flex-col md:flex-row md:items-end md:justify-between gap-4">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Your learning journey</p>
              <h1 className="text-3xl md:text-4xl font-black text-comptia-charcoal mt-1">Progress Dashboard</h1>
              <p className="text-slate-600 mt-1">Every quiz you take, measured in one place.</p>
            </div>

            <div className="flex items-center gap-3 flex-wrap">
              <label className="inline-flex items-center gap-3 rounded-lg border-2 border-slate-200 bg-white px-3 py-2 cursor-pointer">
                <FlaskConical className="w-4 h-4 text-amber-600" />
                <span className="text-sm font-bold text-comptia-charcoal">Sample data</span>
                <Switch
                  checked={showSample}
                  onCheckedChange={setShowSample}
                  aria-label="Preview the dashboard with sample data"
                />
              </label>
              <Link to="/lessons">
                <Button className="bg-red-600 hover:bg-red-700 text-white font-bold gap-2">
                  Take a quiz
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
            </div>
          </div>

          <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
            <KpiTile
              icon={ListChecks}
              tint="bg-sky-600"
              label="Quizzes taken"
              value={stats.attempts}
              detail={hasHistory ? `${stats.questionsAnswered} questions answered` : 'No quizzes yet'}
            />
            {/* "Accuracy", not "Average score": it is every question you have
                answered, right over asked, so it says how often you get a
                question right rather than averaging quizzes of unequal size. */}
            <KpiTile
              icon={Target}
              tint="bg-red-600"
              label="Accuracy"
              value={`${stats.averageScore}%`}
              detail={
                hasHistory
                  ? `${stats.correctAnswers} of ${stats.questionsAnswered} questions correct`
                  : 'Take a quiz to get started'
              }
            />
            <KpiTile
              icon={Award}
              tint="bg-emerald-600"
              label="Best quiz score"
              value={`${stats.bestScore}%`}
              detail={stats.bestScoreLabel ? `Your best: ${stats.bestScoreLabel}` : 'No quizzes yet'}
            />
            <KpiTile
              icon={Clock}
              tint="bg-amber-600"
              label="Time studying"
              value={formatDuration(stats.studySeconds)}
              detail={averageQuizTime ? `Answering questions · about ${averageQuizTime} per quiz` : 'Time spent answering questions'}
            />
          </div>
        </div>
      </section>

      {showSample && (
        <div className="flex items-center gap-3 rounded-lg border border-amber-300 bg-amber-50 px-4 py-2.5 text-sm">
          <FlaskConical className="w-4 h-4 text-amber-700 flex-shrink-0" />
          <p className="text-amber-900">
            <span className="font-bold">Showing sample data, not your results.</span> Nothing here is saved. Switch it
            off to see your own progress.
          </p>
        </div>
      )}

      {!hasHistory ? (
        // One clear call to action beats a grid of empty panels.
        <Card className="border border-slate-200 shadow-sm">
          <CardContent className="p-12 text-center space-y-4">
            <div className="w-16 h-16 bg-red-600 rounded-full flex items-center justify-center mx-auto shadow-lg">
              <Target className="w-8 h-8 text-white" />
            </div>
            <h2 className="text-2xl font-black text-comptia-charcoal">No quiz results yet</h2>
            <p className="text-slate-600 max-w-lg mx-auto">
              Take a domain quiz or a mock exam and this dashboard fills in — accuracy per domain, your score trend,
              and the questions you keep getting wrong. Flip on sample data above to see what that looks like first.
            </p>
            <Link to="/lessons" className="inline-block">
              <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg inline-flex items-center gap-2">
                Take your first quiz
                <ArrowRight className="w-5 h-5" />
              </Button>
            </Link>
          </CardContent>
        </Card>
      ) : (
        <div className="grid grid-cols-1 gap-4 lg:grid-cols-12">
          <ScoreTrendChart trend={trend} className="lg:col-span-8" />
          {/* Readiness has the column to itself. Strongest / weakest domain
              cards used to sit under it, repeating Accuracy by Domain below —
              which already ranks every domain and names the weakest. */}
          <ReadinessCard mock={modes.mock} className="lg:col-span-4" />

          <DomainPerformancePanel performance={performance} className="lg:col-span-7" />
          <PracticeMixPanel modes={modes} daily={daily} className="lg:col-span-5" />

          <MostMissedPanel missed={missed} hasHistory={hasHistory} className="lg:col-span-7" />
          <RecentActivityPanel attempts={attempts} className="lg:col-span-5" />
        </div>
      )}
    </div>
  );
}

// Ring geometry for the readiness gauge.
const RING_R = 34;
const RING_C = 2 * Math.PI * RING_R;

/**
 * Latest mock score against the pass mark, as a ring. Mock exams are the
 * only attempts that mirror the real test, so they alone decide readiness.
 *
 * Stretches to the height of the score trend beside it, so from lg the ring
 * is large and everything is stacked and centred; below lg it's a compact row.
 */
function ReadinessCard({ mock, className = '' }) {
  const score = mock.lastScore;
  const hasMock = score !== null;
  const passed = hasMock && score >= MOCK_PASS_MARK;
  const close = hasMock && !passed && score >= MOCK_PASS_MARK - 10;
  const color = passed ? '#047857' : close ? '#D97706' : '#C8102E';

  // Tick for the pass mark, measured clockwise from 12 o'clock.
  const angle = (MOCK_PASS_MARK / 100) * 2 * Math.PI - Math.PI / 2;
  const tick = (r) => [40 + r * Math.cos(angle), 40 + r * Math.sin(angle)];
  const [tx1, ty1] = tick(RING_R - 7);
  const [tx2, ty2] = tick(RING_R + 7);

  return (
    <Card className={`border border-slate-200 shadow-sm ${className}`}>
      <CardContent className="p-5 lg:p-6 h-full flex items-center gap-4 lg:flex-col lg:justify-center lg:gap-5 lg:text-center">
        <div className="relative w-20 h-20 lg:w-40 lg:h-40 flex-shrink-0" aria-hidden="true">
          <svg viewBox="0 0 80 80" className="w-full h-full">
            <circle cx="40" cy="40" r={RING_R} fill="none" stroke="#E2E8F0" strokeWidth="8" />
            {hasMock && (
              <circle
                cx="40"
                cy="40"
                r={RING_R}
                fill="none"
                stroke={color}
                strokeWidth="8"
                strokeLinecap="round"
                strokeDasharray={`${(score / 100) * RING_C} ${RING_C}`}
                transform="rotate(-90 40 40)"
              />
            )}
            <line x1={tx1} y1={ty1} x2={tx2} y2={ty2} stroke="#1D252D" strokeWidth="2" />
          </svg>
          <span className="absolute inset-0 flex items-center justify-center text-lg lg:text-4xl font-black text-comptia-charcoal tabular-nums">
            {hasMock ? `${score}%` : '—'}
          </span>
        </div>

        <div className="min-w-0">
          <p className="text-[11px] font-bold uppercase tracking-wider text-slate-500">Exam readiness</p>
          <p className="text-base lg:text-xl font-black leading-snug" style={{ color: hasMock ? color : '#1D252D' }}>
            {!hasMock ? 'No mock exam yet' : passed ? 'Passing' : close ? 'Almost there' : 'Not there yet'}
          </p>
          <p className="text-xs text-slate-500 mt-0.5">
            {hasMock
              ? `Last mock ${score}% · pass mark ${MOCK_PASS_MARK}% · ${mock.passes} of ${mock.count} passed`
              : `A full mock shows how close you are to the ${MOCK_PASS_MARK}% pass mark.`}
          </p>
          <Link
            to="/lessons?section=mock"
            className="inline-flex items-center gap-1 mt-1.5 text-xs font-bold text-red-600 hover:underline"
          >
            {hasMock ? 'Take another mock' : 'Take a mock exam'}
            <ArrowRight className="w-3.5 h-3.5" />
          </Link>
        </div>
      </CardContent>
    </Card>
  );
}

