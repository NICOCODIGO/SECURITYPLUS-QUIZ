import React, { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Switch } from '@/components/ui/switch';
import {
  Target,
  Clock,
  TrendingUp,
  Award,
  ThumbsUp,
  ThumbsDown,
  ListChecks,
  FlaskConical,
  ArrowRight,
} from 'lucide-react';
import StatsCard from '../components/progress/StatsCard';
import DomainPerformancePanel from '../components/progress/DomainPerformancePanel';
import ScoreTrendChart from '../components/progress/ScoreTrendChart';
import MostMissedPanel from '../components/progress/MostMissedPanel';
import RecentActivityPanel from '../components/progress/RecentActivityPanel';
import {
  getQuizHistory,
  getQuizStats,
  getDomainPerformance,
  getScoreTrend,
  getMostMissed,
  getRecentAttempts,
  formatDuration,
} from '../components/data/quizHistoryData';
import { demoQuizHistory } from '@/lib/demoProgressData';

/**
 * Progress Page
 * --------------------------------------------------
 * Learning analytics derived from `quiz_history`, the key TakeQuiz writes
 * when a quiz is submitted.
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
  const performance = useMemo(() => getDomainPerformance(history), [history]);
  const trend = useMemo(() => getScoreTrend(history), [history]);
  const missed = useMemo(() => getMostMissed(history, 5), [history]);
  const attempts = useMemo(() => getRecentAttempts(history, 8), [history]);

  const hasHistory = history.length > 0;

  return (
    <div className="relative">
      <div className="max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 space-y-8">

        {/* Header */}
        <div className="text-center space-y-4">
          <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
            <TrendingUp className="w-5 h-5 text-red-600" />
            <span className="text-sm font-bold text-red-700 uppercase tracking-wide">
              Your Learning Journey
            </span>
          </div>
          <h1 className="text-5xl font-black text-comptia-charcoal uppercase tracking-tight">
            Progress Dashboard
          </h1>
          <p className="text-lg text-slate-700 max-w-2xl mx-auto font-medium">
            Track your learning progress and quiz performance
          </p>
        </div>

        {/* Sample-data switch */}
        <Card className={`border-2 shadow-sm ${showSample ? 'border-amber-300 bg-amber-50' : 'border-slate-200 bg-white'}`}>
          <CardContent className="p-4 flex items-center justify-between gap-4 flex-wrap">
            <div className="flex items-center gap-3">
              <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${showSample ? 'bg-amber-500' : 'bg-slate-200'}`}>
                <FlaskConical className={`w-5 h-5 ${showSample ? 'text-white' : 'text-slate-500'}`} />
              </div>
              <div>
                <p className="text-sm font-bold text-comptia-charcoal">
                  {showSample ? 'Showing sample data — not your results' : 'Preview with sample data'}
                </p>
                <p className="text-xs text-slate-600">
                  {showSample
                    ? 'Nothing here is saved. Switch off to see your own progress.'
                    : 'See what this dashboard looks like once you have taken some quizzes.'}
                </p>
              </div>
            </div>
            <div className="flex items-center gap-3">
              <span className="text-sm font-bold text-slate-700">Sample data</span>
              <Switch
                checked={showSample}
                onCheckedChange={setShowSample}
                aria-label="Preview the dashboard with sample data"
              />
            </div>
          </CardContent>
        </Card>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <StatsCard
            icon={ListChecks}
            title="Quizzes Taken"
            value={`${stats.attempts}`}
            subtitle={hasHistory ? `${stats.questionsAnswered} questions answered` : 'No quizzes yet'}
            color="green"
          />
          <StatsCard
            icon={Target}
            title="Average Score"
            value={`${stats.averageScore}%`}
            subtitle={
              hasHistory
                ? `${stats.correctAnswers} of ${stats.questionsAnswered} correct`
                : 'Take a quiz to get started'
            }
            color="blue"
          />
          <StatsCard
            icon={Award}
            title="Best Score"
            value={`${stats.bestScore}%`}
            subtitle={stats.bestScoreLabel || 'No quizzes yet'}
            color="purple"
          />
          <StatsCard
            icon={Clock}
            title="Time Spent"
            value={formatDuration(stats.studySeconds)}
            subtitle="Total time in quizzes"
            color="amber"
          />
        </div>

        {/* Empty state — one clear call to action beats five empty panels */}
        {!hasHistory && (
          <Card className="border-2 border-slate-200 shadow-lg">
            <CardContent className="p-12 text-center space-y-4">
              <div className="w-16 h-16 bg-red-600 rounded-full flex items-center justify-center mx-auto shadow-lg">
                <Target className="w-8 h-8 text-white" />
              </div>
              <h2 className="text-2xl font-black text-comptia-charcoal">
                No quiz results yet
              </h2>
              <p className="text-slate-600 max-w-lg mx-auto">
                Take a domain quiz or a mock exam and this dashboard fills in — accuracy
                per domain, your score trend, and the questions you keep getting wrong.
                Flip the switch above to see what that looks like first.
              </p>
              <Link to="/lessons">
                <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg inline-flex items-center gap-2">
                  Take your first quiz
                  <ArrowRight className="w-5 h-5" />
                </Button>
              </Link>
            </CardContent>
          </Card>
        )}

        {hasHistory && (
          <>
            {/* Strongest / Weakest */}
            {performance.strongest && performance.weakest && (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <HighlightCard
                  tone="good"
                  icon={ThumbsUp}
                  title="Strongest Domain"
                  row={performance.strongest}
                />
                <HighlightCard
                  tone="bad"
                  icon={ThumbsDown}
                  title="Weakest Domain"
                  row={performance.weakest}
                />
              </div>
            )}

            <DomainPerformancePanel performance={performance} />

            <ScoreTrendChart trend={trend} />

            <MostMissedPanel missed={missed} hasHistory={hasHistory} />

            <RecentActivityPanel attempts={attempts} />
          </>
        )}
      </div>
    </div>
  );
}

function HighlightCard({ tone, icon, title, row }) {
  const Icon = icon;
  const good = tone === 'good';

  return (
    <Card className={`border-2 shadow-lg ${good ? 'border-emerald-200 bg-emerald-50' : 'border-red-200 bg-red-50'}`}>
      <CardHeader>
        <div className="flex items-center gap-3">
          <div className={`w-12 h-12 rounded-full flex items-center justify-center ${good ? 'bg-emerald-700' : 'bg-red-600'}`}>
            <Icon className="w-6 h-6 text-white" />
          </div>
          <CardTitle className="text-comptia-charcoal">{title}</CardTitle>
        </div>
      </CardHeader>
      <CardContent>
        <div className="flex items-center gap-4">
          {row.domain && (
            <div className={`w-14 h-14 flex-shrink-0 rounded-full bg-white border-4 ${row.domain.ringColor} flex items-center justify-center`}>
              <img src={row.domain.icon} alt="" className="w-8 h-8" />
            </div>
          )}
          <div className="min-w-0">
            <h3 className="font-bold text-base text-comptia-charcoal">{row.title}</h3>
            <p className={`text-4xl font-black ${good ? 'text-emerald-700' : 'text-red-600'}`}>
              {row.accuracy}%
            </p>
            <p className="text-xs text-slate-600 mt-1">
              {row.correct} of {row.total} correct
            </p>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
