import React, { useEffect, useRef, useState } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { AlertCircle, CheckCircle2, Loader2 } from 'lucide-react';
import { verifyEmail } from '@/auth/authApi';

/**
 * Where the verification link lands.
 *
 * The token is spent on mount, which is the one place a side effect on mount is
 * right: arriving here IS the click. The ref guards React 18 StrictMode, which
 * runs effects twice in development — without it the second run would report
 * "already used" for a link that had just worked.
 */
export default function VerifyEmail() {
  const [params] = useSearchParams();
  const token = params.get('token');
  const [state, setState] = useState(token ? 'working' : 'missing');
  const [error, setError] = useState(null);
  const attempted = useRef(false);

  useEffect(() => {
    if (!token || attempted.current) return;
    attempted.current = true;

    verifyEmail(token)
      .then(() => setState('done'))
      .catch((verifyError) => {
        setError(
          verifyError?.isOffline
            ? 'Cannot reach the server. Check your connection and try again.'
            : verifyError?.message?.replace(/^API \d+: /, '') ||
                'That link has expired or has already been used.'
        );
        setState('failed');
      });
  }, [token]);

  if (state === 'working') {
    return (
      <div className="max-w-md mx-auto py-16 px-4 text-center">
        <Loader2 className="w-8 h-8 animate-spin text-red-600 mx-auto" />
        <p className="text-slate-600 mt-4">Confirming your email address…</p>
      </div>
    );
  }

  if (state === 'done') {
    return (
      <div className="max-w-md mx-auto py-10 px-4">
        <div className="flex items-center gap-2 text-green-700">
          <CheckCircle2 className="w-5 h-5" />
          <p className="text-xs font-bold uppercase tracking-[0.18em]">Confirmed</p>
        </div>
        <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Email confirmed</h1>
        <p className="text-slate-600 mt-2">
          You can now reset your password if you ever lose it, and turn on two-factor sign-in from
          your account page.
        </p>
        <div className="flex flex-wrap gap-3 mt-6">
          <Link to="/account">
            <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
              Account settings
            </Button>
          </Link>
          <Link to="/lessons">
            <Button
              variant="outline"
              className="border-slate-300 font-bold px-8 py-6 rounded-lg"
            >
              Back to practice
            </Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-md mx-auto py-10 px-4">
      <div className="flex items-center gap-2 text-red-700">
        <AlertCircle className="w-5 h-5" />
        <p className="text-xs font-bold uppercase tracking-[0.18em]">Not confirmed</p>
      </div>
      <h1 className="text-3xl font-black text-comptia-charcoal mt-1">
        {state === 'missing' ? 'That link is incomplete' : 'That link did not work'}
      </h1>
      <p className="text-slate-600 mt-2">
        {state === 'missing'
          ? 'Open the link from your email directly.'
          : error}
      </p>
      <p className="text-slate-600 mt-4 text-sm">
        Sign in and use <span className="font-semibold">Resend confirmation</span> on your account
        page to get a fresh link. Nothing about your studying is affected either way — every quiz
        works exactly as before.
      </p>
      <Link to="/account" className="inline-block mt-6">
        <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
          Go to account settings
        </Button>
      </Link>
    </div>
  );
}
