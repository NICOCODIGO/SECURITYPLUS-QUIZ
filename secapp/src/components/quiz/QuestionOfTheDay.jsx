import React, { useMemo, useState } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Flame, CheckCircle2, XCircle, CalendarDays, Clock } from 'lucide-react';
import {
  getDateKey,
  getDailyQuestion,
  getDailyRecord,
  saveDailyAnswer,
  getStreak,
  getDailyTotals,
  msUntilTomorrow,
} from '../data/dailyQuestion';

/**
 * One question, the same for the whole day, with a day streak.
 *
 * Answering does not write to `quiz_history` — see the note in
 * dailyQuestion.js. The streak is the only thing being tracked.
 */
export default function QuestionOfTheDay() {
  const dateKey = getDateKey();
  const question = useMemo(() => getDailyQuestion(dateKey), [dateKey]);

  const [record, setRecord] = useState(() => getDailyRecord(dateKey));
  const [streak, setStreak] = useState(() => getStreak(dateKey));
  const [totals, setTotals] = useState(() => getDailyTotals());

  if (!question) return null;

  const answered = record !== null;
  const domain = question.domainMeta;

  const handleAnswer = (choiceIndex) => {
    if (answered) return;
    const correct = choiceIndex === question.correctAnswer;
    setRecord(saveDailyAnswer(dateKey, choiceIndex, correct));
    setStreak(getStreak(dateKey));
    setTotals(getDailyTotals());
  };

  const hoursLeft = Math.max(1, Math.round(msUntilTomorrow() / 3600000));

  return (
    <Card className="border-2 border-slate-200 shadow-lg overflow-hidden">
      {/* Header band carries the domain's own colour ring and icon. */}
      <div className="bg-comptia-charcoal px-6 py-5">
        <div className="flex items-center justify-between gap-4 flex-wrap">
          <div className="flex items-center gap-3">
            <CalendarDays className="w-5 h-5 text-red-400" />
            <div>
              <h2 className="text-lg font-black text-white uppercase tracking-wide">
                Question of the Day
              </h2>
              <p className="text-xs text-slate-400">
                {new Date().toLocaleDateString(undefined, {
                  weekday: 'long',
                  month: 'long',
                  day: 'numeric',
                })}
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2 bg-white/10 px-4 py-2 rounded-full">
            <Flame className={`w-4 h-4 ${streak > 0 ? 'text-amber-400' : 'text-slate-500'}`} />
            <span className="text-sm font-bold text-white tabular-nums">
              {streak} day{streak === 1 ? '' : 's'}
            </span>
          </div>
        </div>
      </div>

      <CardContent className="p-6 space-y-5">
        <div className="flex items-center gap-3 flex-wrap">
          {domain && (
            <span className="inline-flex items-center gap-2">
              <span className={`w-8 h-8 rounded-full bg-white border-2 ${domain.ringColor} flex items-center justify-center`}>
                <img src={domain.icon} alt="" className="w-4 h-4" />
              </span>
              <span className={`text-xs font-bold ${domain.badgeColor} border px-3 py-1 rounded-full`}>
                {domain.numberedTitle}
              </span>
            </span>
          )}
          <span className="text-xs font-bold text-slate-600 bg-slate-100 border border-slate-200 px-3 py-1 rounded-full">
            {question.difficulty}
          </span>
        </div>

        <p className="text-lg font-bold text-comptia-charcoal leading-snug">
          {question.question}
        </p>

        <div className="space-y-2">
          {question.choices.map((choice, i) => {
            const isCorrect = i === question.correctAnswer;
            const isChosen = answered && record.choice === i;

            let tone = 'border-slate-200 bg-white hover:border-slate-400 hover:bg-slate-50';
            if (answered && isCorrect) tone = 'border-emerald-300 bg-emerald-50';
            else if (isChosen) tone = 'border-red-300 bg-red-50';
            else if (answered) tone = 'border-slate-200 bg-white opacity-60';

            return (
              <button
                key={i}
                onClick={() => handleAnswer(i)}
                disabled={answered}
                className={`w-full flex items-center gap-3 p-4 rounded-xl border-2 text-left transition-all ${tone} ${
                  answered ? 'cursor-default' : 'cursor-pointer'
                }`}
              >
                <span className="w-7 h-7 flex-shrink-0 rounded-full border-2 border-slate-300 flex items-center justify-center text-xs font-bold text-slate-600">
                  {String.fromCharCode(65 + i)}
                </span>
                <span className="flex-1 text-sm text-slate-800">{choice}</span>
                {answered && isCorrect && (
                  <CheckCircle2 className="w-5 h-5 text-emerald-700 flex-shrink-0" />
                )}
                {answered && isChosen && !isCorrect && (
                  <XCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
                )}
              </button>
            );
          })}
        </div>

        {answered && (
          <div
            className={`rounded-xl border-2 p-4 space-y-2 ${
              record.correct ? 'border-emerald-200 bg-emerald-50' : 'border-red-200 bg-red-50'
            }`}
          >
            <p
              className={`text-sm font-black uppercase tracking-wide ${
                record.correct ? 'text-emerald-800' : 'text-red-800'
              }`}
            >
              {record.correct ? 'Correct' : 'Not quite'}
            </p>
            <p className="text-sm text-slate-700 leading-relaxed">{question.explanation}</p>
          </div>
        )}

        <div className="flex items-center justify-between gap-4 flex-wrap pt-1 border-t-2 border-slate-100 mt-1">
          <p className="text-xs text-slate-500 pt-3">
            {totals.answered > 0
              ? `${totals.correct} of ${totals.answered} daily questions correct`
              : 'Answer to start your streak'}
          </p>
          {answered && (
            <p className="text-xs text-slate-500 pt-3 inline-flex items-center gap-1.5">
              <Clock className="w-3.5 h-3.5" />
              Next question in {hoursLeft}h
            </p>
          )}
        </div>
      </CardContent>
    </Card>
  );
}
