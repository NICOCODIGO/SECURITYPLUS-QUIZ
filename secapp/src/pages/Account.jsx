import React, { useCallback, useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  AlertCircle,
  AlertTriangle,
  CheckCircle2,
  KeyRound,
  Loader2,
  Mail,
  ShieldAlert,
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
 * The two states a setting can be in. The same emerald/amber pair as
 * lib/performanceStatus.js, and for the same reason it pairs every colour with
 * a word: the meaning must never rest on colour alone.
 *
 * Amber, not red, for "off": 2FA is optional, so off is a recommendation rather
 * than an error — and red is already the brand and the destructive button.
 */
const TONES = {
  good: {
    badge: 'text-emerald-900 bg-emerald-100 border-emerald-300',
    dot: 'bg-emerald-600',
    icon: 'text-emerald-700 bg-emerald-50',
  },
  attention: {
    badge: 'text-amber-900 bg-amber-100 border-amber-300',
    dot: 'bg-amber-500',
    icon: 'text-amber-700 bg-amber-50',
  },
};

const METHODS = {
  email: {
    name: 'Email',
    icon: Mail,
    choose: "We'll email you a 6-digit code each time you sign in.",
    active: "We'll email you a 6-digit code each time you sign in.",
  },
  totp: {
    name: 'Authenticator app',
    icon: Smartphone,
    choose: 'Get a code from an app on your phone, such as Google Authenticator or Microsoft Authenticator.',
    active: 'Each time you sign in, enter the 6-digit code from your authenticator app.',
  },
};

/** Below this many, the count becomes a warning. */
const LOW_RECOVERY_CODES = 2;

/**
 * Icon, title and status on one row, so the state reads before the detail.
 * On a narrow card the badge wraps under the title rather than squeezing it
 * onto two lines.
 */
function SettingHeader({ icon, title, tone, status }) {
  const Icon = icon;
  const colours = TONES[tone];
  return (
    <div className="flex items-center gap-3">
      <span
        className={`w-9 h-9 rounded-full flex items-center justify-center flex-shrink-0 ${colours.icon}`}
      >
        <Icon className="w-5 h-5" />
      </span>
      <div className="flex-1 min-w-0 flex flex-wrap items-center justify-between gap-x-3 gap-y-1">
        <h2 className="font-bold text-comptia-charcoal">{title}</h2>
        <Badge
          variant="outline"
          className={`gap-1.5 flex-shrink-0 text-sm font-bold px-2.5 py-0.5 ${colours.badge}`}
        >
          <span className={`w-2 h-2 rounded-full ${colours.dot}`} aria-hidden="true" />
          {status}
        </Badge>
      </div>
    </div>
  );
}

function MethodTile({ method, disabled, disabledReason, onChoose }) {
  const { name, icon: Icon, choose } = METHODS[method];
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onChoose}
      className="flex items-start gap-3 rounded-lg border-2 border-slate-200 bg-white p-4 text-left transition-colors hover:border-red-300 hover:bg-red-50/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-500 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-60 disabled:hover:border-slate-200 disabled:hover:bg-white"
    >
      <Icon className="w-5 h-5 mt-0.5 text-red-600 flex-shrink-0" />
      <span className="min-w-0">
        <span className="block font-bold text-comptia-charcoal">{name}</span>
        <span className="block text-sm text-slate-600 mt-1">{disabledReason || choose}</span>
      </span>
    </button>
  );
}

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
        Each code can be used once to sign in if you lose access to your email or authenticator
        app. Store them somewhere safe — they won&apos;t be shown again.
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

  const beginSetup = async (chosen) => {
    const started = await run(() => authApi.beginTwoFactorSetup(chosen));
    if (started) setSetup(started);
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
          Sign in to manage your email address and two-factor sign-in.
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
  // Once the status has loaded it wins, including its null for "off" — `??`
  // would read that null as "unknown" and fall back to a stale `user`.
  const method = twoFactor ? twoFactor.method : (user?.twoFactorMethod ?? null);
  const codesLeft = twoFactor?.recoveryCodesRemaining ?? 0;

  return (
    <div className="max-w-2xl mx-auto py-10 px-4">
      <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Your account</p>
      <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Account settings</h1>
      <p className="text-slate-600 mt-2 break-all">{user?.email}</p>

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
          <SettingHeader
            icon={Mail}
            title="Email address"
            tone={verified ? 'good' : 'attention'}
            status={verified ? 'Confirmed' : 'Not confirmed'}
          />
          <div className="mt-3 sm:pl-12">
            <p className="text-sm text-slate-600">
              {verified
                ? 'Used to sign in and to reset your password.'
                : 'Confirm your email address so you can reset your password if you forget it.'}
            </p>
            {!verified && (
              <Button
                type="button"
                disabled={busy}
                onClick={() =>
                  run(
                    () => authApi.resendVerification(),
                    'Confirmation email sent. Check your inbox and spam folder.'
                  )
                }
                className="bg-red-600 hover:bg-red-700 text-white font-bold mt-4 gap-2"
              >
                {busy && <Loader2 className="w-4 h-4 animate-spin" />}
                Resend confirmation
              </Button>
            )}
          </div>
        </CardContent>
      </Card>

      {/* --------------------------------------------- two-factor sign-in -- */}
      <Card className="border border-slate-200 shadow-sm mt-4">
        <CardContent className="p-6">
          <SettingHeader
            icon={method ? ShieldCheck : ShieldAlert}
            title="Two-factor sign-in"
            tone={method ? 'good' : 'attention'}
            status={method ? 'On' : 'Off'}
          />
          <div className="mt-3 sm:pl-12">
            {method && METHODS[method] ? (
              <>
                <p className="text-sm text-slate-600">
                  <span className="font-semibold text-comptia-charcoal">Method:</span>{' '}
                  {METHODS[method].name}
                </p>
                <p className="text-sm text-slate-600 mt-1">{METHODS[method].active}</p>
              </>
            ) : (
              <p className="text-sm text-slate-600">
                Add a second step when you sign in, so a password alone isn&apos;t enough to
                access your account.
              </p>
            )}

            {method && twoFactor && !recoveryCodes && (
              codesLeft <= LOW_RECOVERY_CODES ? (
                <div className="flex items-start gap-2 rounded-lg border border-amber-200 bg-amber-50 px-3 py-2.5 text-sm text-amber-900 mt-3">
                  <AlertTriangle className="w-4 h-4 mt-0.5 flex-shrink-0" />
                  <span>
                    {codesLeft === 0
                      ? 'No recovery codes left.'
                      : `Only ${codesLeft} recovery code${codesLeft === 1 ? '' : 's'} left.`}{' '}
                    Generate new ones below so you can still sign in if you lose access to your
                    email or app.
                  </span>
                </div>
              ) : (
                <p className="text-sm text-slate-600 mt-2">
                  <span className="font-semibold">{codesLeft}</span> recovery codes left.
                </p>
              )
            )}

            {recoveryCodes && (
              <div className="mt-4">
                <RecoveryCodes
                  codes={recoveryCodes}
                  onDone={() => {
                    setNotice(
                      setup
                        ? 'Two-factor sign-in is on.'
                        : 'New recovery codes created. Your previous codes no longer work.'
                    );
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
              <div className="mt-4">
                <p className="text-sm font-bold text-comptia-charcoal">
                  Choose how to get your sign-in code
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mt-2">
                  <MethodTile
                    method="email"
                    disabled={busy || !verified}
                    disabledReason={
                      verified ? null : 'Confirm your email address to use this option.'
                    }
                    onChoose={() => beginSetup('email')}
                  />
                  <MethodTile
                    method="totp"
                    disabled={busy}
                    onChoose={() => beginSetup('totp')}
                  />
                </div>
              </div>
            )}

            {/* ------------------------------------ confirming setup -- */}
            {setup && !recoveryCodes && (
              <div className="mt-4 space-y-4">
                {setup.method === 'totp' && (
                  <div className="rounded-lg border border-slate-200 bg-slate-50 p-4">
                    <p className="text-sm text-slate-700">
                      Add this account to your authenticator app, then enter the code it shows.
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
                    <p className="text-xs text-slate-500 mt-3">Or enter this key manually:</p>
                    <code className="block mt-1 font-mono text-sm tracking-wider bg-white border border-slate-200 rounded px-3 py-2 break-all">
                      {setup.secret}
                    </code>
                  </div>
                )}

                {setup.method === 'email' && (
                  <p className="text-sm text-slate-600">
                    We&apos;ve emailed a 6-digit code to {user?.email}. Enter it below to finish
                    setup.
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
                    Enter your password to generate new recovery codes or turn off two-factor
                    sign-in.
                  </p>
                </div>
                <div className="flex flex-wrap gap-3">
                  <Button
                    type="button"
                    disabled={busy || !password}
                    onClick={async () => {
                      const result = await run(() => authApi.regenerateRecoveryCodes(password));
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
                      // Disable answers 204, which resolves to null — the same
                      // value `run` returns on failure — so return true to tell
                      // the two apart.
                      const ok = await run(async () => {
                        await authApi.disableTwoFactor(password);
                        return true;
                      }, 'Two-factor sign-in has been turned off.');
                      setPassword('');
                      if (ok) {
                        setTwoFactor(
                          (prev) => prev && { ...prev, method: null, recoveryCodesRemaining: 0 }
                        );
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
        </CardContent>
      </Card>
    </div>
  );
}
