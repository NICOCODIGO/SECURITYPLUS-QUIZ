import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { Card } from '@/components/ui/card';
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
 * Dashboard entry point for the daily question.
 *
 * The dashboard used to render the whole `QuestionOfTheDay` card, which made
 * the sidebar's "Question of the Day" tab show the identical card a second
 * time. This is the teaser instead — the date and the streak, but not the
 * question — and answering happens on its own screen at /daily.
 *
 * It deliberately doesn't name today's domain: knowing the topic in advance
 * is a hint, and the daily question is meant to be answered cold.
 */
export default function DailyQuestionStrip() {
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
    : 'One question, about a minute';

  return (
    <Card className="border-2 border-comptia-charcoal shadow-lg overflow-hidden">
      <Link
        to="/daily"
        className="w-full bg-comptia-charcoal hover:bg-comptia-charcoal-light transition-colors px-5 py-4 flex items-center gap-4 flex-wrap text-left group"
      >
        <CalendarDays className="w-6 h-6 text-red-400 flex-shrink-0" />

        <div className="flex-1 min-w-[12rem]">
          <h3 className="text-lg font-black text-white uppercase tracking-wide leading-tight">
            Question of the Day
          </h3>
          <p className="text-xs text-slate-400 mt-0.5">
            {dateLabel} · {status}
          </p>
        </div>

        {totals.answered > 0 && (
          <span className="inline-flex items-center gap-2 bg-white/10 px-3 py-1.5 rounded-full flex-shrink-0">
            <CheckCircle2 className="w-4 h-4 text-emerald-400" />
            <span className="text-sm font-bold text-white tabular-nums">
              {totals.correct}/{totals.answered} correct
            </span>
          </span>
        )}

        {/* A zero-day streak is a discouraging thing to greet someone with. */}
        {streak > 0 && (
          <span className="inline-flex items-center gap-2 bg-white/10 px-3 py-1.5 rounded-full flex-shrink-0">
            <Flame className="w-4 h-4 text-amber-400" />
            <span className="text-sm font-bold text-white tabular-nums">
              {streak} day{streak === 1 ? '' : 's'}
            </span>
          </span>
        )}

        <span className="inline-flex items-center gap-2 bg-red-600 group-hover:bg-red-700 transition-colors px-4 py-2 rounded-lg text-sm font-bold text-white flex-shrink-0">
          {answered ? 'Review answer' : 'Answer now'}
          <ArrowRight className="w-4 h-4 group-hover:translate-x-0.5 transition-transform" />
        </span>
      </Link>
    </Card>
  );
}
