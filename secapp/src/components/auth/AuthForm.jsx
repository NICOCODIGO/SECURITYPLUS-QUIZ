import React, { useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { AlertCircle, Loader2 } from 'lucide-react';
import { useAuth } from '@/auth/AuthContext';
import { safeNext } from '@/auth/safeNext';

/** BCrypt truncates at 72 bytes, so the server caps it there. Match, or a valid password 400s. */
const MAX_PASSWORD = 72;

const MIN_PASSWORD = 10;

export default function AuthForm({ mode }) {
  const isSignUp = mode === 'signup';
  const { status, signIn, signUp, completeTwoFactor } = useAuth();
  const navigate = useNavigate();
  const [params] = useSearchParams();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [displayName, setDisplayName] = useState('');
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);

  // Set only when the account has a second step. Holding it here rather than
  // in a route keeps it out of the URL and out of history.
  const [challenge, setChallenge] = useState(null);
  const [method, setMethod] = useState(null);
  const [code, setCode] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError(null);
    setBusy(true);

    // Caught here rather than by the server, so the message can point at the
    // field that is wrong instead of rejecting the whole form.
    if (isSignUp && password !== confirmPassword) {
      setError('Those passwords do not match.');
      setBusy(false);
      return;
    }

    try {
      if (isSignUp) {
        await signUp(email, password, displayName.trim() || null);
      } else {
        const result = await signIn(email, password);
        if (result?.challenge) {
          // Right password, but not signed in yet - and deliberately holding
          // nothing that could read or write study data until the code lands.
          setChallenge(result.challenge);
          setMethod(result.method);
          setBusy(false);
          return;
        }
      }
      navigate(safeNext(params.get('next')), { replace: true });
    } catch (submitError) {
      // ApiError carries the server's ProblemDetail `detail`, which is already
      // written to be shown to a person and deliberately generic on a bad
      // sign-in. isOffline means the API is unreachable, which is a different
      // problem and must not read as "wrong password".
      setError(
        submitError?.isOffline
          ? 'Cannot reach the server. Check your connection and try again.'
          : submitError?.message?.replace(/^API \d+: /, '') || 'Something went wrong.'
      );
      setBusy(false);
    }
  };

  const handleVerify = async (event) => {
    event.preventDefault();
    setError(null);
    setBusy(true);

    try {
      await completeTwoFactor(challenge, code.trim());
      navigate(safeNext(params.get('next')), { replace: true });
    } catch (verifyError) {
      setError(
        verifyError?.isOffline
          ? 'Cannot reach the server. Check your connection and try again.'
          : verifyError?.message?.replace(/^API \d+: /, '') || 'Something went wrong.'
      );
      setBusy(false);
      setCode('');
    }
  };

  // Reachable by direct URL even though AuthNav hides its link. Offering a
  // form that cannot possibly succeed, and then blaming the connection for it,
  // is worse than saying plainly that this build has no server.
  if (status === 'unavailable') {
    return (
      <div className="max-w-md mx-auto py-10 px-4">
        <h1 className="text-3xl font-black text-comptia-charcoal">Accounts aren&apos;t available</h1>
        <p className="text-slate-600 mt-2">
          This build has no server configured, so there&apos;s nothing to sign in to. The domain
          quizzes and the mock exam still work — results just aren&apos;t saved.
        </p>
        <Link to="/lessons" className="inline-block mt-6">
          <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
            Go to Practice
          </Button>
        </Link>
      </div>
    );
  }

  if (challenge) {
    return (
      <div className="max-w-md mx-auto py-10 px-4">
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">One more step</p>
        <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Enter your code</h1>
        <p className="text-slate-600 mt-2">
          {method === 'totp'
            ? 'Open your authenticator app and enter the six-digit code it shows.'
            : `We sent a six-digit code to ${email}. It expires in ten minutes.`}
        </p>

        <Card className="border border-slate-200 shadow-sm mt-6">
          <CardContent className="p-6">
            <form onSubmit={handleVerify} className="space-y-4" noValidate>
              {error && (
                <div
                  role="alert"
                  className="flex items-start gap-2 rounded-lg border border-red-300 bg-red-50 px-3 py-2.5 text-sm text-red-900"
                >
                  <AlertCircle className="w-4 h-4 mt-0.5 flex-shrink-0" />
                  <span>{error}</span>
                </div>
              )}

              <div className="space-y-1.5">
                <Label htmlFor="code" className="font-bold text-comptia-charcoal">
                  Code
                </Label>
                <Input
                  id="code"
                  type="text"
                  inputMode="text"
                  autoComplete="one-time-code"
                  autoFocus
                  required
                  maxLength={32}
                  value={code}
                  onChange={(event) => setCode(event.target.value)}
                  className="text-lg tracking-[0.3em] font-mono"
                />
                <p className="text-xs text-slate-500">
                  Lost your device? Enter one of your recovery codes instead.
                </p>
              </div>

              <Button
                type="submit"
                disabled={busy}
                className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-6 gap-2"
              >
                {busy && <Loader2 className="w-4 h-4 animate-spin" />}
                Verify and sign in
              </Button>
            </form>

            <p className="text-sm text-slate-600 text-center mt-5">
              <button
                type="button"
                onClick={() => {
                  setChallenge(null);
                  setCode('');
                  setError(null);
                }}
                className="font-bold text-red-600 hover:text-red-700 underline"
              >
                Start over
              </button>
            </p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="max-w-md mx-auto py-10 px-4">
      <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">
        {isSignUp ? 'Create an account' : 'Welcome back'}
      </p>
      <h1 className="text-3xl font-black text-comptia-charcoal mt-1">
        {isSignUp ? 'Save your progress' : 'Sign in'}
      </h1>
      <p className="text-slate-600 mt-2">
        {isSignUp
          ? 'An account keeps your quiz results, streak and flagged questions.'
          : 'Sign in to pick up where you left off.'}
      </p>

      <Card className="border border-slate-200 shadow-sm mt-6">
        <CardContent className="p-6">
          <form onSubmit={handleSubmit} className="space-y-4" noValidate>
            {error && (
              <div
                role="alert"
                className="flex items-start gap-2 rounded-lg border border-red-300 bg-red-50 px-3 py-2.5 text-sm text-red-900"
              >
                <AlertCircle className="w-4 h-4 mt-0.5 flex-shrink-0" />
                <span>{error}</span>
              </div>
            )}

            <div className="space-y-1.5">
              <Label htmlFor="email" className="font-bold text-comptia-charcoal">
                Email
              </Label>
              <Input
                id="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(event) => setEmail(event.target.value)}
              />
            </div>

            {isSignUp && (
              <div className="space-y-1.5">
                <Label htmlFor="displayName" className="font-bold text-comptia-charcoal">
                  Display name <span className="font-normal text-slate-500">(optional)</span>
                </Label>
                <Input
                  id="displayName"
                  type="text"
                  autoComplete="nickname"
                  maxLength={80}
                  value={displayName}
                  onChange={(event) => setDisplayName(event.target.value)}
                />
                {/* Nothing here is comparative, so say where it shows. */}
                <p className="text-xs text-slate-500">Only ever shown back to you.</p>
              </div>
            )}

            <div className="space-y-1.5">
              <Label htmlFor="password" className="font-bold text-comptia-charcoal">
                Password
              </Label>
              <Input
                id="password"
                type="password"
                autoComplete={isSignUp ? 'new-password' : 'current-password'}
                required
                minLength={isSignUp ? MIN_PASSWORD : undefined}
                maxLength={MAX_PASSWORD}
                value={password}
                onChange={(event) => setPassword(event.target.value)}
              />
              {isSignUp && (
                <p className="text-xs text-slate-500">
                  At least {MIN_PASSWORD} characters. A short phrase works well.
                </p>
              )}
            </div>

            {isSignUp && (
              <div className="space-y-1.5">
                <Label htmlFor="confirmPassword" className="font-bold text-comptia-charcoal">
                  Confirm password
                </Label>
                <Input
                  id="confirmPassword"
                  type="password"
                  autoComplete="new-password"
                  required
                  maxLength={MAX_PASSWORD}
                  value={confirmPassword}
                  onChange={(event) => setConfirmPassword(event.target.value)}
                />
              </div>
            )}

            <Button
              type="submit"
              disabled={busy}
              className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-6 gap-2"
            >
              {busy && <Loader2 className="w-4 h-4 animate-spin" />}
              {isSignUp ? 'Create free account' : 'Sign in'}
            </Button>
          </form>

          {!isSignUp && (
            <p className="text-sm text-center mt-4">
              <Link to="/forgot-password" className="text-slate-600 hover:text-red-600 underline">
                Forgot your password?
              </Link>
            </p>
          )}

          <p className="text-sm text-slate-600 text-center mt-5">
            {isSignUp ? 'Already have an account? ' : "Don't have an account? "}
            <Link
              to={isSignUp ? '/login' : '/signup'}
              className="font-bold text-red-600 hover:text-red-700 underline"
            >
              {isSignUp ? 'Sign in' : 'Create one free'}
            </Link>
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
