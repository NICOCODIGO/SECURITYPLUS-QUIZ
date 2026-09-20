import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { FileText, ArrowRight, AlertCircle, Clock, Flag, EyeOff, TriangleAlert, Headphones } from 'lucide-react';
import { createPageUrl } from "@/lib/utils";
import { MOCK_PASS_MARK } from '@/lib/performanceStatus';

// What the exam actually does, stated once so the card and the dialog can
// never drift apart. Each line is checked against TakeQuiz's real behaviour:
// the timer calls handleSubmit() at zero, mock questions withhold feedback
// until submit (revealsAnswersImmediately), and the flag button plus the
// navigator are on screen throughout.
const EXAM_RULES = [
  {
    icon: Clock,
    title: '90 minutes for 90 questions',
    body: 'The timer starts as soon as you begin and runs even if you switch tabs. When it hits zero the exam submits itself with whatever you have answered.',
  },
  {
    icon: EyeOff,
    title: 'No feedback until you submit',
    body: 'Unlike practice quizzes, you will not be told whether an answer was right while you work. You get the full breakdown — including why each wrong choice was wrong — on the results screen.',
  },
  {
    icon: Flag,
    title: 'Skip, flag, and come back',
    body: 'You can leave a question unanswered and return to it, and flag anything you want to revisit. The question navigator shows what you have answered, skipped and flagged.',
  },
];

export default function MockExam({ allQuestions }) {

  const handleStartExam = () => {
    const shuffled = [...allQuestions].sort(() => Math.random() - 0.5).slice(0, 90);

    // Store questions in sessionStorage to avoid URL length limits
    const quizId = `quiz_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(shuffled));

    const params = new URLSearchParams({
      type: 'mock',
      timer: 'true',
      quizId: quizId,
      returnTo: 'mock'
    });
    window.location.href = createPageUrl('TakeQuiz') + '?' + params.toString();
  };

  return (
      <div className="space-y-6">
        <Card className="border-2 border-slate-200 shadow-lg">
          <CardHeader className="space-y-4">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-red-600 rounded-lg flex items-center justify-center">
                <FileText className="w-6 h-6 text-white" />
              </div>
              <div>
                <CardTitle className="text-2xl font-bold text-slate-900">Mock Exam Simulator</CardTitle>
                <p className="text-slate-600 mt-1">Full Security+ SY0-701 Practice Test</p>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="bg-blue-50 border-2 border-blue-200 rounded-lg p-4">
              <div className="flex items-start gap-3">
                <AlertCircle className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
                <div className="text-sm text-blue-900">
                  <p className="font-semibold mb-1">Exam Conditions</p>
                  <p>This mock exam simulates the actual Security+ certification test. You will have 90 minutes to complete 90 questions covering all five domains.</p>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4">
              <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
                <p className="text-2xl font-bold text-slate-900">90</p>
                <p className="text-sm text-slate-600">Questions</p>
              </div>
              <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
                <p className="text-2xl font-bold text-slate-900">90</p>
                <p className="text-sm text-slate-600">Minutes</p>
              </div>
              <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
                <p className="text-2xl font-bold text-slate-900">750</p>
                <p className="text-sm text-slate-600">Passing Score</p>
              </div>
            </div>

            {/* Starting is a 90-minute commitment that cannot be paused or
                resumed, so it asks first rather than dropping you straight
                into a running timer. AlertDialog (not Dialog) on purpose:
                it takes a deliberate answer and cannot be dismissed by
                clicking the backdrop. */}
            <AlertDialog>
              <AlertDialogTrigger asChild>
                <Button className="w-full bg-red-600 hover:bg-red-700 h-12 font-semibold">
                  Start Mock Exam
                  <ArrowRight className="w-4 h-4 ml-2" />
                </Button>
              </AlertDialogTrigger>

              {/* Column layout rather than the default grid: only the middle
                  section scrolls, so the two buttons stay on screen. Letting
                  the whole dialog scroll put the start button ~40px below the
                  fold on a 720px-tall laptop, with no scrollbar to hint at it. */}
              <AlertDialogContent className="max-w-xl max-h-[85vh] flex flex-col gap-0 p-0">
                <AlertDialogHeader className="shrink-0 p-6 pb-4">
                  <AlertDialogTitle className="text-xl">Before you start</AlertDialogTitle>
                  <AlertDialogDescription>
                    This runs under the same conditions as the real SY0-701 exam. Here is
                    what that means.
                  </AlertDialogDescription>
                </AlertDialogHeader>

                <div className="flex-1 overflow-y-auto px-6 space-y-4">
                <ul className="space-y-4">
                  {EXAM_RULES.map((rule) => {
                    // Assigned, not destructured in the parameter list: with no
                    // eslint react plugin here, `varsIgnorePattern: '^[A-Z_]'` is
                    // what stops components used only in JSX being called unused —
                    // and it covers variables, not parameters.
                    const Icon = rule.icon;
                    return (
                      <li key={rule.title} className="flex items-start gap-3">
                        <Icon className="w-5 h-5 text-slate-500 flex-shrink-0 mt-0.5" aria-hidden="true" />
                        <div>
                          <p className="font-semibold text-slate-900 text-sm">{rule.title}</p>
                          <p className="text-sm text-slate-600 mt-0.5">{rule.body}</p>
                        </div>
                      </li>
                    );
                  })}
                </ul>

                {/* The one thing someone can lose real work to, so it is
                    separated out and coloured rather than buried in the list
                    above. Answers live in TakeQuiz's React state and are only
                    written to quiz_history on submit. */}
                <div className="rounded-lg border-2 border-amber-200 bg-amber-50 p-4">
                  <div className="flex items-start gap-3">
                    <TriangleAlert className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" aria-hidden="true" />
                    <div className="text-sm text-amber-900">
                      <p className="font-semibold">Your progress is not saved if you leave</p>
                      <p className="mt-0.5">
                        Quitting the exam, closing the tab or refreshing ends the attempt and
                        your answers are gone — there is no way to pick it back up. Nothing is
                        recorded until you submit.
                      </p>
                    </div>
                  </div>
                </div>

                <div className="flex items-start gap-3 text-sm text-slate-600 pb-2">
                  <Headphones className="w-5 h-5 text-slate-400 flex-shrink-0 mt-0.5" aria-hidden="true" />
                  <p>
                    Set aside a full 90 uninterrupted minutes somewhere you can concentrate.
                    You need {MOCK_PASS_MARK}% to pass, and rushing a mock tells you less than
                    not taking one.
                  </p>
                </div>
                </div>

                <AlertDialogFooter className="shrink-0 border-t border-slate-200 p-6 pt-4">
                  <AlertDialogCancel>Not right now</AlertDialogCancel>
                  <AlertDialogAction
                    onClick={handleStartExam}
                    className="bg-red-600 hover:bg-red-700"
                  >
                    I&apos;m ready — start the exam
                  </AlertDialogAction>
                </AlertDialogFooter>
              </AlertDialogContent>
            </AlertDialog>
          </CardContent>
        </Card>
      </div>
  );
}
