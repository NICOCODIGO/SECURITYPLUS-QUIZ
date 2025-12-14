import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import {
  CheckCircle2,
  Target,
  Clock,
  TrendingUp,
  Award,
  ThumbsUp,
  ThumbsDown,
} from 'lucide-react';
import { Progress as ProgressBar } from '@/components/ui/progress';
import StatsCard from '../components/progress/StatsCard';
import { format } from 'date-fns';
import { lessons } from '../components/data/lessonsData';
import {
  getProgress,
  getCompletedLessonsCount,
  getAverageQuizScore,
  getTotalTimeSpent,
} from '../components/data/progressData';

/**
 * Progress Page
 * --------------------------------------------------
 * This page shows detailed learning analytics.
 *
 * IMPORTANT DESIGN DECISION:
 * - Guests can VIEW the dashboard (blurred)
 * - Only authenticated users can INTERACT with it
 *
 * Authentication is simulated using localStorage.
 * This will later be replaced by real backend auth
 * WITHOUT changing the UI logic.
 */

export default function Progress() {
  /**
   * TEMP AUTH CHECK (frontend-only)
   * --------------------------------
   * If auth_user exists → user is "signed in"
   * Later this becomes a real auth state.
   */
  const isAuthenticated = Boolean(localStorage.getItem('auth_user'));

  /**
   * PROGRESS DATA (localStorage-backed for now)
   * -------------------------------------------
   * This logic stays the same when backend is added.
   */
  const progress = getProgress();
  const completedLessons = getCompletedLessonsCount();
  const totalLessons = lessons.length;
  const completionRate =
    totalLessons > 0
      ? Math.round((completedLessons / totalLessons) * 100)
      : 0;
  const averageScore = getAverageQuizScore();
  const totalTimeSpent = getTotalTimeSpent();

  const completedProgress = progress.filter((p) => p.completed);

  const getLessonById = (lessonId) => {
    return lessons.find((l) => l.id === lessonId);
  };

  /**
   * DOMAIN PERFORMANCE CALCULATION
   * -------------------------------
   * Aggregates quiz scores by domain
   */
  const getDomainPerformance = () => {
    const quizScores = JSON.parse(
      localStorage.getItem('quizScores') || '[]'
    );

    if (quizScores.length === 0) return null;

    const domainStats = {};

    quizScores.forEach((quiz) => {
      if (quiz.domain) {
        if (!domainStats[quiz.domain]) {
          domainStats[quiz.domain] = {
            total: 0,
            count: 0,
          };
        }
        domainStats[quiz.domain].total += quiz.score;
        domainStats[quiz.domain].count += 1;
      }
    });

    const domainAverages = Object.keys(domainStats).map((domain) => ({
      domain,
      average: Math.round(
        domainStats[domain].total / domainStats[domain].count
      ),
      quizzesTaken: domainStats[domain].count,
    }));

    if (domainAverages.length === 0) return null;

    domainAverages.sort((a, b) => b.average - a.average);

    return {
      strongest: domainAverages[0],
      weakest: domainAverages[domainAverages.length - 1],
      all: domainAverages,
    };
  };

  const domainPerformance = getDomainPerformance();

  return (
    <div className="relative">
      {/* -------------------------------------------------
          DASHBOARD CONTENT
          - Blurred + disabled for guests
          - Fully interactive for authenticated users
      -------------------------------------------------- */}
      <div
        className={
          !isAuthenticated
            ? 'blur-sm pointer-events-none select-none'
            : ''
        }
      >
        <div className="max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 space-y-8">
          {/* Header */}
          <div className="text-center space-y-4">
            <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
              <TrendingUp className="w-5 h-5 text-red-600" />
              <span className="text-sm font-bold text-red-700 uppercase tracking-wide">
                Your Learning Journey
              </span>
            </div>
            <h1 className="text-5xl font-black text-slate-900 uppercase tracking-tight">
              Progress Dashboard
            </h1>
            <p className="text-lg text-slate-700 max-w-2xl mx-auto font-medium">
              Track your learning progress and quiz performance
            </p>
          </div>

          {/* Stats Cards */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <StatsCard
              icon={CheckCircle2}
              title="Lessons Completed"
              value={`${completedLessons}/${totalLessons}`}
              subtitle={`${completionRate}% complete`}
              color="green"
            />
            <StatsCard
              icon={Target}
              title="Average Quiz Score"
              value={`${averageScore}%`}
              subtitle={
                averageScore > 0
                  ? 'Keep up the good work!'
                  : 'No quizzes taken yet'
              }
              color="blue"
            />
            <StatsCard
              icon={Clock}
              title="Time Spent"
              value={`${totalTimeSpent}h`}
              subtitle="Total learning time"
              color="amber"
            />
            <StatsCard
              icon={Award}
              title="Completion Rate"
              value={`${completionRate}%`}
              subtitle="Keep up the great work!"
              color="purple"
            />
          </div>

          {/* Overall Progress */}
          <Card className="border-slate-200 shadow-lg">
            <CardHeader>
              <CardTitle className="text-xl font-bold text-slate-900">
                Overall Progress
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600">
                    Course Completion
                  </span>
                  <span className="font-semibold text-slate-900">
                    {completionRate}%
                  </span>
                </div>
                <ProgressBar value={completionRate} className="h-3" />
              </div>
              <p className="text-sm text-slate-600">
                {completedLessons === totalLessons
                  ? "🎉 Congratulations! You've completed all lessons!"
                  : `${totalLessons - completedLessons} lessons remaining`}
              </p>
            </CardContent>
          </Card>

          {/* Domain Performance */}
          {domainPerformance && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <Card className="border-2 border-green-200 bg-green-50 shadow-lg">
                <CardHeader>
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-green-600 rounded-full flex items-center justify-center">
                      <ThumbsUp className="w-6 h-6 text-white" />
                    </div>
                    <CardTitle>Strongest Domain</CardTitle>
                  </div>
                </CardHeader>
                <CardContent>
                  <h3 className="font-bold text-lg">
                    {domainPerformance.strongest.domain}
                  </h3>
                  <p className="text-4xl font-black text-green-600">
                    {domainPerformance.strongest.average}%
                  </p>
                </CardContent>
              </Card>

              <Card className="border-2 border-red-200 bg-red-50 shadow-lg">
                <CardHeader>
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 bg-red-600 rounded-full flex items-center justify-center">
                      <ThumbsDown className="w-6 h-6 text-white" />
                    </div>
                    <CardTitle>Weakest Domain</CardTitle>
                  </div>
                </CardHeader>
                <CardContent>
                  <h3 className="font-bold text-lg">
                    {domainPerformance.weakest.domain}
                  </h3>
                  <p className="text-4xl font-black text-red-600">
                    {domainPerformance.weakest.average}%
                  </p>
                </CardContent>
              </Card>
            </div>
          )}
        </div>
      </div>

      {/* -------------------------------------------------
          GUEST OVERLAY (CALL TO ACTION)
          - Only shown when NOT authenticated
      -------------------------------------------------- */}
      {!isAuthenticated && (
        <div className="absolute inset-0 flex items-center justify-center">
          <div className="bg-white/90 backdrop-blur-md border border-slate-200 rounded-2xl p-8 max-w-md text-center shadow-xl">
            <h2 className="text-2xl font-bold text-slate-900 mb-2">
              Track Your Progress
            </h2>
            <p className="text-sm text-slate-600 mb-6">
              Create an account to save quiz results, monitor improvement,
              and view detailed learning analytics.
            </p>

            {/* TEMP AUTH SIMULATION */}
            <button
              onClick={() =>
                localStorage.setItem(
                  'auth_user',
                  JSON.stringify({ id: 'demo-user' })
                )
              }
              className="w-full bg-red-600 hover:bg-red-700 text-white font-semibold py-3 rounded-lg"
            >
              Create Free Account
            </button>

            <p className="text-xs text-slate-500 mt-3">
              Already have an account? Sign in
            </p>
          </div>
        </div>
      )}
    </div>
  );
}
