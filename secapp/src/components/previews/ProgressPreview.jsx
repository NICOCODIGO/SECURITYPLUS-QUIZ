import React from 'react';
import { CheckCircle2, Target, Clock, Award } from 'lucide-react';
import StatsCard from '../progress/StatsCard';
import OverallProgressCard from '../progress/OverallProgressCard';
import { lessons } from '../data/lessonsData';
import {
  getCompletedLessonsCount,
  getAverageQuizScore,
  getTotalTimeSpent,
} from '../data/progressData';
import { demoProgressData } from '../../lib/demoProgressData';

/**
 * Home page teaser for the Progress dashboard.
 *
 * Shows the visitor's real numbers once they have any, and falls back to
 * clearly-labelled sample data for first-time visitors — an empty dashboard
 * makes a poor advertisement, but showing invented progress to someone who
 * has real progress is worse.
 */
export default function ProgressPreview() {
  const completedLessons = getCompletedLessonsCount();
  const averageScore = getAverageQuizScore();
  const timeSpent = getTotalTimeSpent();

  const hasRealProgress = completedLessons > 0 || averageScore > 0;

  const stats = hasRealProgress
    ? {
        lessonsCompleted: completedLessons,
        totalLessons: lessons.length,
        averageQuizScore: averageScore,
        timeSpent: `${timeSpent}h`,
        completionRate:
          lessons.length > 0
            ? Math.round((completedLessons / lessons.length) * 100)
            : 0,
      }
    : {
        lessonsCompleted: demoProgressData.lessonsCompleted,
        totalLessons: demoProgressData.totalLessons,
        averageQuizScore: demoProgressData.averageQuizScore,
        timeSpent: demoProgressData.timeSpent,
        completionRate: demoProgressData.completionRate,
      };

  return (
    <div className="space-y-6">
      {!hasRealProgress && (
        <p className="text-center text-xs font-bold uppercase tracking-wide text-slate-400">
          Sample data — start a lesson to see your own
        </p>
      )}

      <div
        className={!hasRealProgress ? 'pointer-events-none select-none' : ''}
        aria-hidden={!hasRealProgress}
      >
        <div className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <StatsCard
              icon={CheckCircle2}
              title="Lessons Completed"
              value={`${stats.lessonsCompleted}/${stats.totalLessons}`}
              subtitle={`${stats.completionRate}% complete`}
              color="green"
            />
            <StatsCard
              icon={Target}
              title="Average Quiz Score"
              value={`${stats.averageQuizScore}%`}
              subtitle="Keep up the good work!"
              color="blue"
            />
            <StatsCard
              icon={Clock}
              title="Time Spent"
              value={stats.timeSpent}
              subtitle="Total learning time"
              color="amber"
            />
            <StatsCard
              icon={Award}
              title="Completion Rate"
              value={`${stats.completionRate}%`}
              subtitle="Keep up the great work!"
              color="purple"
            />
          </div>

          <OverallProgressCard
            completionRate={stats.completionRate}
            completedLessons={stats.lessonsCompleted}
            totalLessons={stats.totalLessons}
          />
        </div>
      </div>
    </div>
  );
}
