import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { BarChart3, CalendarDays, Lock, RefreshCw, ServerOff, Target, TrendingDown, Wrench } from 'lucide-react';
import { useAuth } from '@/auth/AuthContext';

// What an account gets you. Keep it true: every item is something a signed-out
// visitor genuinely doesn't have (see quiz/accountOnly.js).
const BENEFITS = [
  {
    icon: BarChart3,
    title: 'Your progress dashboard',
    detail: 'Accuracy in each of the five domains, your score trend, and the questions you keep missing.',
  },
  {
    icon: Target,
    title: 'Your weakest domain, found for you',
    detail: 'Every quiz you take feeds it, so you always know where to focus next.',
  },
  {
    icon: TrendingDown,
    title: 'Weakest Subject drills',
    detail: '20 questions aimed at whichever domain you score lowest in.',
  },
  {
    icon: Wrench,
    title: 'Build your own quizzes',
    detail: "Mix the questions you've missed and flagged, by domain and difficulty.",
  },
  {
    icon: CalendarDays,
    title: 'Question of the Day',
    detail: 'One new question every day, with a streak to keep going.',
  },
  {
    icon: RefreshCw,
    title: 'On every device',
    detail: 'Your history follows you to wherever you sign in.',
  },
];

/**
 * What Progress shows when there is nothing it is allowed to read.
 *
 * Study data is kept only while an account is signed in — see
 * components/data/persistence.js — so for a signed-out visitor this dashboard
 * has no data by design rather than because they have taken no quizzes. Saying
 * "no quiz results yet" there would be a lie; this says why, and lists what an
 * account gets you.
 *
 * Returns null when signed in, so the real dashboard renders untouched.
 */
export default function ProgressGate() {
  const { status } = useAuth();

  if (status === 'authenticated') return null;

  // Don't flash a sign-in prompt at someone who turns out to be signed in.
  if (status === 'loading') {
    return (
      <Card className="border border-slate-200 shadow-sm">
        <CardContent className="p-12">
          <div className="h-6 w-56 mx-auto rounded bg-slate-100 animate-pulse" aria-hidden="true" />
        </CardContent>
      </Card>
    );
  }

  // No API configured, so there is no account to offer. Be straight about it
  // rather than inviting someone to sign in to a server that isn't there.
  if (status === 'unavailable') {
    return (
      <Card className="border border-slate-200 shadow-sm">
        <CardContent className="p-12 text-center space-y-4">
          <div className="w-16 h-16 bg-slate-400 rounded-full flex items-center justify-center mx-auto shadow-lg">
            <ServerOff className="w-8 h-8 text-white" />
          </div>
          <h2 className="text-2xl font-black text-comptia-charcoal">Progress needs an account</h2>
          <p className="text-slate-600 max-w-lg mx-auto">
            Saving your results requires signing in, and this build has no server configured.
            The domain quizzes and the mock exam still work — results just aren&apos;t
            recorded.
          </p>
          <Link to="/lessons" className="inline-block">
            <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
              Go to Practice
            </Button>
          </Link>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="border border-slate-200 shadow-sm">
      <CardContent className="p-6 sm:p-12 space-y-6">
        <div className="text-center space-y-4">
          <div className="w-16 h-16 bg-red-600 rounded-full flex items-center justify-center mx-auto shadow-lg">
            <Lock className="w-8 h-8 text-white" />
          </div>
          <h2 className="text-2xl font-black text-comptia-charcoal">Sign in to save your progress</h2>
          <p className="text-slate-600 max-w-lg mx-auto">
            You can take the domain quizzes and the mock exam without an account — but results
            aren&apos;t saved, so there&apos;s no history to chart here. A free account gets you:
          </p>
        </div>

        <ul className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 max-w-4xl mx-auto">
          {BENEFITS.map((benefit) => {
            const Icon = benefit.icon;
            return (
              <li key={benefit.title} className="flex items-start gap-3 rounded-xl border border-slate-200 bg-slate-50/60 p-4">
                <span className="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-lg bg-red-50 text-red-600">
                  <Icon className="h-5 w-5" />
                </span>
                <span className="min-w-0">
                  <span className="block text-sm font-bold text-comptia-charcoal">{benefit.title}</span>
                  <span className="block text-sm text-slate-600 mt-0.5">{benefit.detail}</span>
                </span>
              </li>
            );
          })}
        </ul>

        <div className="flex flex-col sm:flex-row gap-3 justify-center pt-1">
          <Link to="/signup?next=/progress">
            <Button className="w-full sm:w-auto bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
              Create free account
            </Button>
          </Link>
          <Link to="/login?next=/progress">
            <Button
              variant="outline"
              className="w-full sm:w-auto border-2 font-bold px-8 py-6 rounded-lg"
            >
              Sign in
            </Button>
          </Link>
        </div>
      </CardContent>
    </Card>
  );
}
