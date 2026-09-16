import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { FileText, Target, TrendingDown, History } from 'lucide-react';
import { formatDuration } from '../data/quizHistoryData';
import { statusForAccuracy } from '@/lib/performanceStatus';

/**
 * Every recorded attempt, newest first.
 *
 * Doubles as the table view for the score trend chart — each score plotted
 * there is also readable here as text, so no value is locked behind a hover.
 */

const TYPE_ICON = {
  mock: FileText,
  weakest: TrendingDown,
  domain: Target,
};

export default function RecentActivityPanel({ attempts }) {
  if (attempts.length === 0) {
    return (
      <Card className="border-2 border-slate-200 shadow-lg">
        <CardHeader>
          <CardTitle className="text-xl font-bold text-comptia-charcoal">Recent Activity</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col items-center justify-center gap-3 py-10 text-center">
            <History className="w-10 h-10 text-slate-300" />
            <p className="text-sm text-slate-600">No quizzes yet — your attempts will be listed here.</p>
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="border-2 border-slate-200 shadow-lg">
      <CardHeader>
        <CardTitle className="text-xl font-bold text-comptia-charcoal">Recent Activity</CardTitle>
        <p className="text-sm text-slate-600">Your most recent attempts, newest first.</p>
      </CardHeader>
      <CardContent>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b-2 border-slate-100 text-left">
                <th className="pb-2 font-bold text-xs text-slate-500 uppercase tracking-wide">Quiz</th>
                <th className="pb-2 font-bold text-xs text-slate-500 uppercase tracking-wide">Date</th>
                <th className="pb-2 font-bold text-xs text-slate-500 uppercase tracking-wide text-right">Questions</th>
                <th className="pb-2 font-bold text-xs text-slate-500 uppercase tracking-wide text-right">Time</th>
                <th className="pb-2 font-bold text-xs text-slate-500 uppercase tracking-wide text-right">Score</th>
              </tr>
            </thead>
            <tbody>
              {attempts.map((attempt, i) => {
                const Icon = TYPE_ICON[attempt.type] || Target;
                const status = statusForAccuracy(attempt.score || 0);

                return (
                  <tr key={i} className="border-b border-slate-100 last:border-0">
                    <td className="py-3 pr-4">
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                          <Icon className="w-4 h-4 text-slate-600" />
                        </div>
                        <div className="min-w-0">
                          <p className="font-bold text-comptia-charcoal truncate">{attempt.label}</p>
                          {attempt.passed !== null && (
                            <p className={`text-xs font-bold ${attempt.passed ? 'text-emerald-700' : 'text-red-700'}`}>
                              {attempt.passed ? 'Pass' : 'Below pass mark'}
                            </p>
                          )}
                        </div>
                      </div>
                    </td>
                    <td className="py-3 pr-4 text-slate-600 whitespace-nowrap">
                      {new Date(attempt.date).toLocaleDateString(undefined, {
                        month: 'short',
                        day: 'numeric',
                        year: 'numeric',
                      })}
                    </td>
                    <td className="py-3 pr-4 text-right text-slate-600 tabular-nums">
                      {attempt.questionsCount}
                    </td>
                    <td className="py-3 pr-4 text-right text-slate-600 tabular-nums whitespace-nowrap">
                      {attempt.durationSeconds ? formatDuration(attempt.durationSeconds) : '—'}
                    </td>
                    <td className="py-3 text-right">
                      <span
                        className="font-black tabular-nums"
                        style={{ color: status.color }}
                      >
                        {attempt.score}%
                      </span>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </CardContent>
    </Card>
  );
}
