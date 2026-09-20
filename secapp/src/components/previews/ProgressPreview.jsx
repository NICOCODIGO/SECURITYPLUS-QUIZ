import React, { useMemo } from 'react';
import { Clock, ListChecks, Target } from 'lucide-react';
import ScoreTrendChart from '../progress/ScoreTrendChart';
import DomainPerformancePanel from '../progress/DomainPerformancePanel';
import KpiTile from '../progress/KpiTile';
import {
  getQuizHistory,
  getQuizStats,
  getScoreTrend,
  canDrawTrend,
  getDomainPerformance,
  formatDuration,
} from '../data/quizHistoryData';
import { demoQuizHistory } from '@/lib/demoProgressData';

/**
 * Home page teaser for the Progress dashboard.
 *
 * Three real pieces of the dashboard — the headline tiles, the score trend
 * and accuracy by domain — each laid out at its natural width and then scaled
 * from its corner, so they keep their true proportions while taking a
 * fraction of the height. At working size they ran to nearly a thousand
 * pixels and read as a second dashboard bolted onto Home.
 *
 * Shows the visitor's own results once there are enough to plot, and falls
 * back to clearly-labelled sample data otherwise — an empty dashboard makes a
 * poor advertisement, but showing invented progress to someone who has real
 * progress is worse. The threshold is two attempts of the same kind (two
 * practice quizzes or two mocks), because the trend chart plots the two
 * apart and needs two points to draw a line.
 *
 * The stage is inert and pointer-events-none: it is a picture of the
 * dashboard, not the dashboard. The band's own button goes to the real one.
 */
export default function ProgressPreview({ className = '' }) {
  const realHistory = useMemo(() => getQuizHistory(), []);
  const hasReal = useMemo(() => canDrawTrend(getScoreTrend(realHistory)), [realHistory]);
  const history = hasReal ? realHistory : demoQuizHistory;

  const stats = useMemo(() => getQuizStats(history), [history]);
  const trend = useMemo(() => getScoreTrend(history), [history]);
  const performance = useMemo(() => getDomainPerformance(history), [history]);

  const tiles = (
    <div className="grid grid-cols-3 gap-3">
      <KpiTile
        icon={ListChecks}
        tint="bg-sky-600"
        label="Quizzes taken"
        value={stats.attempts}
        detail={`${stats.questionsAnswered} questions answered`}
      />
      <KpiTile
        icon={Target}
        tint="bg-red-600"
        label="Accuracy"
        value={`${stats.averageScore}%`}
        detail={`${stats.correctAnswers} of ${stats.questionsAnswered} questions correct`}
      />
      <KpiTile
        icon={Clock}
        tint="bg-amber-600"
        label="Time studying"
        value={formatDuration(stats.studySeconds)}
        detail="Time spent answering questions"
      />
    </div>
  );

  return (
    <div className={`space-y-4 ${className}`}>
      {!hasReal && (
        <p className="text-center text-xs font-bold uppercase tracking-wide text-slate-400">
          Sample data — take a couple of quizzes to see your own
        </p>
      )}

      <div aria-hidden="true" inert={true} className="pointer-events-none select-none">
        {/* Phones: the tiles and the chart at their own width. Scaled screens
            shrunk to phone width read as clutter, not as a product. */}
        <div className="lg:hidden space-y-4">
          {tiles}
          <ScoreTrendChart trend={trend} />
        </div>

        {/* lg and up: the three pieces scaled and overlapped. The tiles sit
            on top, where nothing covers them — underneath, the panel that
            overlaps the chart was hiding them. */}
        <div className="hidden lg:block relative h-[550px] w-full">
          <div className="absolute left-0 top-0 w-[640px] origin-top-left scale-[0.72] -rotate-1 drop-shadow-2xl">
            {tiles}
          </div>
          <div className="absolute left-0 top-[112px] w-[700px] origin-top-left scale-[0.62] -rotate-1 drop-shadow-2xl">
            <ScoreTrendChart trend={trend} />
          </div>
          <div className="absolute left-[44%] top-[232px] w-[580px] origin-top-left scale-[0.55] rotate-[1.5deg] drop-shadow-2xl">
            <DomainPerformancePanel performance={performance} />
          </div>
        </div>
      </div>
    </div>
  );
}
