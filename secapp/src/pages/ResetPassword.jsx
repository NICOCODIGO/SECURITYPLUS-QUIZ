import React, { useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { AlertCircle, Loader2 } from 'lucide-react';
import { resetPassword } from '@/auth/authApi';

/** Matches the server. BCrypt truncates at 72 bytes, so a longer one would be silently cut. */
const MAX_PASSWORD = 72;

const MIN_PASSWORD = 10;

/**
 * Sets a new password from an emailed link.
 *
 * The token arrives as `?token=` because the email links here, not at the API —
 * a link the mail provider can prefetch must not be the thing that spends it.
 * The page reads it and POSTs.
 */
export default function ResetPassword() {
  const [params] = useSearchParams();
  const navigate = useNavigate();
  const token = params.get('token');

  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);
  const [done, setDone] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError(null);

    if (password !== confirmPassword) {
      setError('Those passwords do not match.');
      return;
    }

    setBusy(true);
    try {
      await resetPassword(token, password);
      setDone(true);
    } catch (submitError) {
      setError(
        submitError?.isOffline
          ? 'Cannot reach the server. Check your connection and try again.'
          : submitError?.message?.replace(/^API \d+: /, '') || 'Something went wrong.'
      );
      setBusy(false);
    }
  };

  // Someone who opened /reset-password directly, or whose mail client mangled
  // the link. Saying so beats a form that can only ever fail.
  if (!token) {
    return (
      <div className="max-w-md mx-auto py-10 px-4">
        <h1 className="text-3xl font-black text-comptia-charcoal">That link is incomplete</h1>
        <p className="text-slate-600 mt-2">
          Open the link from your email directly, or request a new one.
        </p>
        <Link to="/forgot-password" className="inline-block mt-6">
          <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
            Request a new link
          </Button>
        </Link>
      </div>
    );
  }

  if (done) {
    return (
      <div className="max-w-md mx-auto py-10 px-4">
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-green-700">All set</p>
        <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Password changed</h1>
        <p className="text-slate-600 mt-2">
          You&apos;ve been signed out everywhere else, which is the point — if someone else had
          access, they no longer do.
        </p>
        <Button
          onClick={() => navigate('/login', { replace: true })}
          className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg mt-6"
        >
          Sign in
        </Button>
      </div>
    );
  }

  return (
    <div className="max-w-md mx-auto py-10 px-4">
      <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Account recovery</p>
      <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Choose a new password</h1>
      <p className="text-slate-600 mt-2">
        This also signs you out on every other device.
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
              <Label htmlFor="password" className="font-bold text-comptia-charcoal">
                New password
              </Label>
              <Input
                id="password"
                type="password"
                autoComplete="new-password"
                required
                autoFocus
                minLength={MIN_PASSWORD}
                maxLength={MAX_PASSWORD}
                value={password}
                onChange={(event) => setPassword(event.target.value)}
              />
              <p className="text-xs text-slate-500">
                At least {MIN_PASSWORD} characters. A short phrase works well.
              </p>
            </div>

            <div className="space-y-1.5">
              <Label htmlFor="confirmPassword" className="font-bold text-comptia-charcoal">
                Confirm new password
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

            <Button
              type="submit"
              disabled={busy}
              className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-6 gap-2"
            >
              {busy && <Loader2 className="w-4 h-4 animate-spin" />}
              Set new password
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
