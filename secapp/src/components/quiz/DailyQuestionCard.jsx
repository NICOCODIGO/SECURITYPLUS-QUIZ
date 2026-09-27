import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { CalendarDays, Flame, ArrowRight, CheckCircle2 } from 'lucide-react';
import {
  getDateKey,
  getDailyQuestion,
  getDailyRecord,
  getDailyTotals,
  getStreak,
  msUntilTomorrow,
} from '../data/dailyQuestion';

/**
 * Dashboard entry point for the daily question — the only place on the
 * Practice page that offers it, and only while signed in (the Dashboard
 * checks showsDailyQuestion in accountOnly.js).
 *
 * A teaser, not the question: the date and the streak, and answering happens
 * on its own screen at /daily. It deliberately doesn't name today's domain:
 * knowing the topic in advance is a hint, and the daily question is meant to
 * be answered cold.
 *
 * `lead` is set when the daily question is the page's recommended next step
 * (signed in, no quizzes yet, not answered today). The card then takes the red
 * accent and the primary button; otherwise it sits below the recommendation
 * and stays secondary, so the page still has one obvious thing to do.
 */
export default function DailyQuestionCard({ lead = false }) {
  const dateKey = getDateKey();
  const question = useMemo(() => getDailyQuestion(dateKey), [dateKey]);

  if (!question) return null;

  const record = getDailyRecord(dateKey);
  const streak = getStreak(dateKey);
  const totals = getDailyTotals();
  const answered = record !== null;
  const hoursLeft = Math.max(1, Math.round(msUntilTomorrow() / 3600000));

  const dateLabel = new Date().toLocaleDateString(undefined, {
    weekday: 'long',
    month: 'long',
    day: 'numeric',
  });

  const status = answered
    ? `${record.correct ? 'Answered correctly' : 'Answered — missed it'} · new question in ${hoursLeft}h`
    : lead
    ? 'One question, about a minute. Then try a short quiz on any domain below.'
    : 'One question, about a minute.';

  return (
    <Link
      to="/daily"
      className="group relative block overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm hover:border-slate-300 transition-colors"
    >
      {lead && <span className="absolute inset-y-0 left-0 w-1 bg-red-600" aria-hidden="true" />}
      <div className="flex flex-col sm:flex-row sm:items-center gap-4 p-5 pl-6">
        <span className="flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-xl bg-red-50 text-red-600">
          <CalendarDays className="h-6 w-6" />
        </span>

        <div className="min-w-0 flex-1">
          <p className="text-[11px] font-bold uppercase tracking-wider text-red-600">
            {lead ? 'Start here' : dateLabel}
          </p>
          <h2 className="text-lg font-black leading-snug text-comptia-charcoal">Question of the Day</h2>
          <p className="text-sm text-slate-600 mt-0.5">{status}</p>

          {/* A zero-day streak is a discouraging thing to greet someone with. */}
          {(totals.answered > 0 || streak > 0) && (
            <div className="mt-2 flex flex-wrap gap-2">
              {totals.answered > 0 && (
                <span className="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-2.5 py-1 text-xs font-bold text-slate-700 tabular-nums">
                  <CheckCircle2 className="h-3.5 w-3.5 text-emerald-600" />
                  {totals.correct}/{totals.answered} correct
                </span>
              )}
              {streak > 0 && (
                <span className="inline-flex items-center gap-1.5 rounded-full bg-slate-100 px-2.5 py-1 text-xs font-bold text-slate-700 tabular-nums">
                  <Flame className="h-3.5 w-3.5 text-amber-500" />
                  {streak} day{streak === 1 ? '' : 's'}
                </span>
              )}
            </div>
          )}
        </div>

        <span
          className={`inline-flex flex-shrink-0 items-center justify-center gap-2 rounded-lg px-5 py-2.5 text-sm font-bold transition-colors ${
            lead
              ? 'bg-red-600 text-white group-hover:bg-red-700'
              : 'border-2 border-slate-200 text-comptia-charcoal group-hover:border-comptia-charcoal'
          }`}
        >
          {answered ? 'Review answer' : "Answer today's question"}
          <ArrowRight className="h-4 w-4 group-hover:translate-x-0.5 transition-transform" />
        </span>
      </div>
    </Link>
  );
}
