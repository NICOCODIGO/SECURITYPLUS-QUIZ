import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { FileText, Target, TrendingDown, History, Wrench } from 'lucide-react';
import { formatDuration } from '../data/quizHistoryData';
import { statusForAccuracy } from '@/lib/performanceStatus';

/**
 * Every recorded attempt, newest first.
 *
 * Doubles as the table view for the score trend chart — each score plotted
 * there is also readable here as text, so no value is locked behind a hover.
 * A compact list rather than a table, so it fits the dashboard's side column.
 */

const TYPE_ICON = {
  mock: FileText,
  weakest: TrendingDown,
  custom: Wrench,
  domain: Target,
};

export default function RecentActivityPanel({ attempts, className = '' }) {
  return (
    <Card className={`border border-slate-200 shadow-sm ${className}`}>
      <CardHeader className="p-5 pb-2">
        <CardTitle className="text-base font-bold text-comptia-charcoal">Recent Activity</CardTitle>
        <p className="text-xs text-slate-500 mt-1">Your latest attempts, newest first.</p>
      </CardHeader>
      <CardContent className="px-5 pb-5">
        {attempts.length === 0 ? (
          <div className="flex flex-col items-center justify-center gap-3 py-10 text-center">
            <History className="w-10 h-10 text-slate-300" />
            <p className="text-sm text-slate-600">No quizzes yet — your attempts will be listed here.</p>
          </div>
        ) : (
          <ul className="divide-y divide-slate-100">
            {attempts.map((attempt, i) => {
              const Icon = TYPE_ICON[attempt.type] || Target;
              const status = statusForAccuracy(attempt.score || 0);
              const date = new Date(attempt.date).toLocaleDateString(undefined, {
                month: 'short',
                day: 'numeric',
              });
              const meta = [
                date,
                `${attempt.questionsCount} questions`,
                attempt.durationSeconds ? formatDuration(attempt.durationSeconds) : null,
              ]
                .filter(Boolean)
                .join(' · ');

              return (
                <li key={i} className="flex items-center gap-3 py-2.5">
                  <span className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <Icon className="w-4 h-4 text-slate-600" />
                  </span>
                  <span className="min-w-0 flex-1">
                    <span className="block text-sm font-bold text-comptia-charcoal truncate">{attempt.label}</span>
                    <span className="block text-xs text-slate-500 truncate">{meta}</span>
                  </span>
                  <span className="text-right flex-shrink-0">
                    <span className="block text-sm font-black tabular-nums" style={{ color: status.color }}>
                      {attempt.score}%
                    </span>
                    {attempt.passed !== null && (
                      <span
                        className={`block text-[10px] font-bold uppercase tracking-wide ${
                          attempt.passed ? 'text-emerald-700' : 'text-red-700'
                        }`}
                      >
                        {attempt.passed ? 'Pass' : 'Below pass'}
                      </span>
                    )}
                  </span>
                </li>
              );
            })}
          </ul>
        )}
      </CardContent>
    </Card>
  );
}
