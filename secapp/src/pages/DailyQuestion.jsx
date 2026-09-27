import React from 'react';
import { Link } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';
import { Button } from '@/components/ui/button';
import QuestionOfTheDay from '../components/quiz/QuestionOfTheDay';
import AccountRequired from '../components/quiz/AccountRequired';
import { useAuth } from '@/auth/AuthContext';
import { showsDailyQuestion } from '../components/quiz/accountOnly';

/**
 * Question of the Day on its own screen, the way a quiz gets one.
 *
 * It used to be a section of the Practice page, behind a sidebar tab that
 * duplicated the strip on the Overview. Now the Overview's card comes here,
 * and the page wears the same chrome as TakeQuiz: Layout drops its nav and
 * footer (see `isFullScreen` there), leaving an exit button, the title, and
 * the question.
 *
 * Account-only (see accountOnly.js). The Overview doesn't offer it signed
 * out, but a bookmark or shared link still lands here, so this says why
 * rather than showing a question whose streak can't be kept.
 *
 * The card keeps its own date and streak, so the bar above doesn't repeat
 * them. Answering still writes only to `daily_question` — the card owns that.
 */
export default function DailyQuestion() {
  const { status } = useAuth();

  return (
    <div className="max-w-3xl mx-auto space-y-4">
      <div className="flex items-center gap-3 flex-wrap">
        <Link to="/lessons?section=dashboard">
          <Button variant="outline" size="sm" className="border-2">
            <ArrowLeft className="w-4 h-4 mr-1.5" />
            Exit
          </Button>
        </Link>

        <h1 className="text-base font-bold text-slate-900 leading-tight">Question of the Day</h1>
      </div>

      {showsDailyQuestion(status) ? (
        <>
          <QuestionOfTheDay hideTitle />

          <p className="text-center text-xs text-slate-500">
            One question, the same for everyone, refreshed every midnight. It is kept out of your quiz history, so a
            single answer can't swing your accuracy.
          </p>
        </>
      ) : status === 'loading' ? (
        // Neither the question nor the lock until auth settles: showing either
        // and swapping it a moment later reads as a glitch.
        <div className="h-72 rounded-xl border border-slate-200 bg-white animate-pulse" aria-hidden="true" />
      ) : (
        <AccountRequired mode="daily" hideTitle />
      )}
    </div>
  );
}
