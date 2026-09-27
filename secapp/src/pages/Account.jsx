import React, { useCallback, useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  AlertCircle,
  CheckCircle2,
  KeyRound,
  Loader2,
  Mail,
  ShieldCheck,
  Smartphone,
} from 'lucide-react';
import { useAuth } from '@/auth/AuthContext';
import * as authApi from '@/auth/authApi';

const readableError = (error, fallback) =>
  error?.isOffline
    ? 'Cannot reach the server. Check your connection and try again.'
    : error?.message?.replace(/^API \d+: /, '') || fallback;

/**
 * Recovery codes, shown the once.
 *
 * They are hashed at rest, so there is no endpoint that can show them again —
 * only one that replaces them. That is why this blocks rather than sitting in
 * a corner of the page: a dismissable notice would be missed, and the next
 * time these matter is the day the phone is gone.
 */
function RecoveryCodes({ codes, onDone }) {
  return (
    <div className="rounded-lg border-2 border-amber-300 bg-amber-50 p-4">
      <div className="flex items-center gap-2 text-amber-900">
        <KeyRound className="w-5 h-5 flex-shrink-0" />
        <p className="font-bold">Save these recovery codes now</p>
      </div>
      <p className="text-sm text-amber-900 mt-2">
        Each one signs you in once if you lose your phone or mailbox. This is the only time they
        can be shown — we store them hashed, so nobody can look them up again, including us.
      </p>
      <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2 mt-4">
        {codes.map((code) => (
          <li
            key={code}
            className="font-mono text-sm tracking-wider bg-white border border-amber-200 rounded px-3 py-2 text-comptia-charcoal"
          >
            {code}
          </li>
        ))}
      </ul>
      <div className="flex flex-wrap gap-3 mt-4">
        <Button
          type="button"
          onClick={() => navigator.clipboard?.writeText(codes.join('\n'))}
          variant="outline"
          className="border-amber-400 font-bold"
        >
          Copy all
        </Button>
        <Button
          type="button"
          onClick={onDone}
          className="bg-amber-700 hover:bg-amber-800 text-white font-bold"
        >
          I&apos;ve saved them
        </Button>
      </div>
    </div>
  );
}

export default function Account() {
  const { status, user, refreshUser } = useAuth();

  const [twoFactor, setTwoFactor] = useState(null);
  const [error, setError] = useState(null);
  const [notice, setNotice] = useState(null);
  const [busy, setBusy] = useState(false);

  // Setup in progress: which method, and the TOTP secret if there is one.
  const [setup, setSetup] = useState(null);
  const [code, setCode] = useState('');
  const [password, setPassword] = useState('');
  const [recoveryCodes, setRecoveryCodes] = useState(null);

  const load = useCallback(() => {
    authApi
      .twoFactorStatus()
      .then(setTwoFactor)
      .catch((loadError) => setError(readableError(loadError, 'Could not load your settings.')));
  }, []);

  useEffect(() => {
    if (status === 'authenticated') load();
  }, [status, load]);

  const run = async (work, successNotice) => {
    setError(null);
    setNotice(null);
    setBusy(true);
    try {
      const result = await work();
      if (successNotice) setNotice(successNotice);
      return result;
    } catch (actionError) {
      setError(readableError(actionError, 'Something went wrong.'));
      return null;
    } finally {
      setBusy(false);
    }
  };

  if (status === 'loading') {
    return (
      <div className="max-w-2xl mx-auto py-16 px-4 text-center">
        <Loader2 className="w-8 h-8 animate-spin text-red-600 mx-auto" />
      </div>
    );
  }

  // Studying never needs an account, so this page is the one place that simply
  // asks you to sign in rather than blocking anything.
  if (status !== 'authenticated') {
    return (
      <div className="max-w-2xl mx-auto py-10 px-4">
        <h1 className="text-3xl font-black text-comptia-charcoal">Account settings</h1>
        <p className="text-slate-600 mt-2">
          Sign in to manage your email address and two-factor sign-in. The domain quizzes, the
          mock exam and all 444 questions work without an account — this page is only about
          keeping the account itself safe.
        </p>
        <Link to="/login?next=/account" className="inline-block mt-6">
          <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
            Sign in
          </Button>
        </Link>
      </div>
    );
  }

  const verified = twoFactor?.emailVerified ?? user?.emailVerified;
  const method = twoFactor?.method ?? user?.twoFactorMethod ?? null;

  return (
    <div className="max-w-2xl mx-auto py-10 px-4">
      <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Your account</p>
      <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Account settings</h1>
      <p className="text-slate-600 mt-2">{user?.email}</p>

      {error && (
        <div
          role="alert"
          className="flex items-start gap-2 rounded-lg border border-red-300 bg-red-50 px-3 py-2.5 text-sm text-red-900 mt-6"
        >
          <AlertCircle className="w-4 h-4 mt-0.5 flex-shrink-0" />
          <span>{error}</span>
        </div>
      )}

      {notice && (
        <div
          role="status"
          className="flex items-start gap-2 rounded-lg border border-green-300 bg-green-50 px-3 py-2.5 text-sm text-green-900 mt-6"
        >
          <CheckCircle2 className="w-4 h-4 mt-0.5 flex-shrink-0" />
          <span>{notice}</span>
        </div>
      )}

      {/* ------------------------------------------------ email address -- */}
      <Card className="border border-slate-200 shadow-sm mt-6">
        <CardContent className="p-6">
          <div className="flex items-start gap-3">
            <Mail className="w-5 h-5 text-slate-500 mt-0.5 flex-shrink-0" />
            <div className="min-w-0 flex-1">
              <h2 className="font-bold text-comptia-charcoal">Email address</h2>
              <p className="text-sm text-slate-600 mt-1">
                {verified
                  ? 'Confirmed. You can reset your password if you ever lose it.'
                  : 'Not confirmed yet. Until it is, we cannot send you a password reset — so losing your password would mean losing the account.'}
              </p>
              {!verified && (
                <Button
                  type="button"
                  disabled={busy}
                  onClick={() =>
                    run(
                      () => authApi.resendVerification(),
                      'Confirmation sent. Check your inbox, and your spam folder.'
                    )
                  }
                  className="bg-red-600 hover:bg-red-700 text-white font-bold mt-4 gap-2"
                >
                  {busy && <Loader2 className="w-4 h-4 animate-spin" />}
                  Resend confirmation
                </Button>
              )}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* --------------------------------------------- two-factor sign-in -- */}
      <Card className="border border-slate-200 shadow-sm mt-4">
        <CardContent className="p-6">
          <div className="flex items-start gap-3">
            <ShieldCheck
              className={`w-5 h-5 mt-0.5 flex-shrink-0 ${method ? 'text-green-600' : 'text-slate-500'}`}
            />
            <div className="min-w-0 flex-1">
              <h2 className="font-bold text-comptia-charcoal">Two-factor sign-in</h2>
              <p className="text-sm text-slate-600 mt-1">
                {method === 'totp' &&
                  'On, using an authenticator app. Signing in asks for a code from your app.'}
                {method === 'email' &&
                  'On, by email. Signing in asks for a six-digit code sent to your inbox.'}
                {!method &&
                  'Off. A second step means a stolen password alone is not enough to reach your account.'}
              </p>

              {method && twoFactor && (
                <p className="text-sm text-slate-600 mt-2">
                  <span className="font-semibold">{twoFactor.recoveryCodesRemaining}</span> recovery
                  code{twoFactor.recoveryCodesRemaining === 1 ? '' : 's'} left.
                </p>
              )}

              {recoveryCodes && (
                <div className="mt-4">
                  <RecoveryCodes
                    codes={recoveryCodes}
                    onDone={() => {
                      setRecoveryCodes(null);
                      setSetup(null);
                      setCode('');
                      load();
                      refreshUser().catch(() => {});
                    }}
                  />
                </div>
              )}

              {/* ---------------------------------------- turning it on -- */}
              {!method && !setup && !recoveryCodes && (
                <div className="flex flex-wrap gap-3 mt-4">
                  <Button
                    type="button"
                    disabled={busy || !verified}
                    onClick={async () => {
                      const started = await run(() => authApi.beginTwoFactorSetup('email'));
                      if (started) setSetup(started);
                    }}
                    className="bg-red-600 hover:bg-red-700 text-white font-bold gap-2"
                  >
                    <Mail className="w-4 h-4" />
                    Use email codes
                  </Button>
                  <Button
                    type="button"
                    disabled={busy}
                    onClick={async () => {
                      const started = await run(() => authApi.beginTwoFactorSetup('totp'));
                      if (started) setSetup(started);
                    }}
                    variant="outline"
                    className="border-slate-300 font-bold gap-2"
                  >
                    <Smartphone className="w-4 h-4" />
                    Use an authenticator app
                  </Button>
                </div>
              )}

              {!verified && !method && (
                <p className="text-xs text-slate-500 mt-2">
                  Confirm your email first before using email codes — otherwise a code sent to an
                  address you cannot read would lock you out.
                </p>
              )}

              {/* ------------------------------------ confirming setup -- */}
              {setup && !recoveryCodes && (
                <div className="mt-4 space-y-4">
                  {setup.method === 'totp' && (
                    <div className="rounded-lg border border-slate-200 bg-slate-50 p-4">
                      <p className="text-sm text-slate-700">
                        Add this to your authenticator app, then enter the code it shows.
                      </p>
                      {/* Authenticator apps register the otpauth:// scheme, so on
                          a phone this opens the app directly — a QR code without
                          the dependency a QR code would cost. */}
                      <a
                        href={setup.provisioningUri}
                        className="inline-block mt-3 font-bold text-red-600 hover:text-red-700 underline text-sm"
                      >
                        Open in your authenticator app
                      </a>
                      <p className="text-xs text-slate-500 mt-3">Or enter this key by hand:</p>
                      <code className="block mt-1 font-mono text-sm tracking-wider bg-white border border-slate-200 rounded px-3 py-2 break-all">
                        {setup.secret}
                      </code>
                    </div>
                  )}

                  {setup.method === 'email' && (
                    <p className="text-sm text-slate-600">
                      We sent a six-digit code to {user?.email}. Enter it below to finish.
                    </p>
                  )}

                  <div className="space-y-1.5">
                    <Label htmlFor="setupCode" className="font-bold text-comptia-charcoal">
                      Code
                    </Label>
                    <Input
                      id="setupCode"
                      type="text"
                      autoComplete="one-time-code"
                      maxLength={32}
                      value={code}
                      onChange={(event) => setCode(event.target.value)}
                      className="font-mono tracking-[0.3em] max-w-xs"
                    />
                  </div>

                  <div className="flex flex-wrap gap-3">
                    <Button
                      type="button"
                      disabled={busy || !code.trim()}
                      onClick={async () => {
                        const result = await run(() =>
                          authApi.confirmTwoFactorSetup(setup.method, code.trim())
                        );
                        if (result) setRecoveryCodes(result.codes);
                      }}
                      className="bg-red-600 hover:bg-red-700 text-white font-bold gap-2"
                    >
                      {busy && <Loader2 className="w-4 h-4 animate-spin" />}
                      Turn on
                    </Button>
                    <Button
                      type="button"
                      onClick={() => {
                        setSetup(null);
                        setCode('');
                        setError(null);
                      }}
                      variant="outline"
                      className="border-slate-300 font-bold"
                    >
                      Cancel
                    </Button>
                  </div>
                </div>
              )}

              {/* --------------------------------------- turning it off -- */}
              {method && !recoveryCodes && (
                <div className="mt-4 space-y-3 border-t border-slate-200 pt-4">
                  <div className="space-y-1.5">
                    <Label htmlFor="password" className="font-bold text-comptia-charcoal text-sm">
                      Your password
                    </Label>
                    <Input
                      id="password"
                      type="password"
                      autoComplete="current-password"
                      value={password}
                      onChange={(event) => setPassword(event.target.value)}
                      className="max-w-xs"
                    />
                    {/* A borrowed unlocked laptop is exactly what 2FA defends
                        against, and it arrives holding a valid session. */}
                    <p className="text-xs text-slate-500">
                      Needed to change either of these, so a borrowed session cannot.
                    </p>
                  </div>
                  <div className="flex flex-wrap gap-3">
                    <Button
                      type="button"
                      disabled={busy || !password}
                      onClick={async () => {
                        const result = await run(() =>
                          authApi.regenerateRecoveryCodes(password)
                        );
                        setPassword('');
                        if (result) setRecoveryCodes(result.codes);
                      }}
                      variant="outline"
                      className="border-slate-300 font-bold"
                    >
                      New recovery codes
                    </Button>
                    <Button
                      type="button"
                      disabled={busy || !password}
                      onClick={async () => {
                        const ok = await run(
                          () => authApi.disableTwoFactor(password),
                          'Two-factor sign-in is off.'
                        );
                        setPassword('');
                        if (ok !== null) {
                          load();
                          refreshUser().catch(() => {});
                        }
                      }}
                      variant="outline"
                      className="border-red-300 text-red-700 hover:bg-red-50 font-bold"
                    >
                      Turn off two-factor
                    </Button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
