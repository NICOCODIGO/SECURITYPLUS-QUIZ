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
import AnswerExplanation from './AnswerExplanation';

/**
 * One question, the same for the whole day, with a day streak.
 *
 * Answering does not write to `quiz_history` — see the note in
 * dailyQuestion.js. The streak is the only thing being tracked.
 *
 * Only ever rendered signed in: /daily shows AccountRequired otherwise (see
 * accountOnly.js), so there is no untracked case to explain here.
 *
 * The question's domain is deliberately not shown, here or on the dashboard
 * strip: naming the topic is a hint, and the question is meant to be
 * answered cold.
 *
 * `hideTitle` drops the band's heading for the dedicated daily tab, where the
 * page already carries an h1 saying the same thing; the date and streak stay
 * because the live streak is owned by this component.
 */
export default function QuestionOfTheDay({ hideTitle = false }) {
  const dateKey = getDateKey();
  const question = useMemo(() => getDailyQuestion(dateKey), [dateKey]);

  const [record, setRecord] = useState(() => getDailyRecord(dateKey));
  const [streak, setStreak] = useState(() => getStreak(dateKey));
  const [totals, setTotals] = useState(() => getDailyTotals());

  if (!question) return null;

  const answered = record !== null;

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
      <div className="bg-comptia-charcoal px-6 py-5">
        <div className="flex items-center justify-between gap-4 flex-wrap">
          <div className="flex items-center gap-3">
            <CalendarDays className="w-5 h-5 text-red-400" />
            <div>
              {!hideTitle && (
                <h2 className="text-lg font-black text-white uppercase tracking-wide">
                  Question of the Day
                </h2>
              )}
              <p className={hideTitle ? 'text-sm font-bold text-white' : 'text-xs text-slate-400'}>
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
        <span className="inline-block text-xs font-bold text-slate-600 bg-slate-100 border border-slate-200 px-3 py-1 rounded-full">
          {question.difficulty}
        </span>

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
            <AnswerExplanation question={question} answer={record.choice} bare />
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
