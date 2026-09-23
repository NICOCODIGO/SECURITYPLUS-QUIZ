import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Lock, ServerOff } from 'lucide-react';
import { useAuth } from '@/auth/AuthContext';

/**
 * What Progress shows when there is nothing it is allowed to read.
 *
 * Study data is kept only while an account is signed in — see
 * components/data/persistence.js — so for a signed-out visitor this dashboard
 * has no data by design rather than because they have taken no quizzes. Saying
 * "no quiz results yet" there would be a lie; this says why.
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
            Every quiz, the full question bank and Question of the Day all still work — results
            just aren&apos;t recorded.
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
      <CardContent className="p-12 text-center space-y-4">
        <div className="w-16 h-16 bg-red-600 rounded-full flex items-center justify-center mx-auto shadow-lg">
          <Lock className="w-8 h-8 text-white" />
        </div>
        <h2 className="text-2xl font-black text-comptia-charcoal">Sign in to save your progress</h2>
        <p className="text-slate-600 max-w-lg mx-auto">
          You can take every quiz and mock exam without an account — but results aren&apos;t
          saved, so there&apos;s no history to chart here. Create a free account and this
          dashboard fills in: accuracy per domain, your score trend, and the questions you keep
          getting wrong.
        </p>
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
