import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { AlertCircle, Loader2, MailCheck } from 'lucide-react';
import { forgotPassword } from '@/auth/authApi';

/**
 * Asks for a reset link.
 *
 * The confirmation below is deliberately non-committal — "if that address has
 * an account". The server answers identically either way, and a page that said
 * "no account found" would hand back the enumeration oracle the API works to
 * close.
 */
export default function ForgotPassword() {
  const [email, setEmail] = useState('');
  const [sent, setSent] = useState(false);
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError(null);
    setBusy(true);

    try {
      await forgotPassword(email);
      setSent(true);
    } catch (submitError) {
      setError(
        submitError?.isOffline
          ? 'Cannot reach the server. Check your connection and try again.'
          : submitError?.message?.replace(/^API \d+: /, '') || 'Something went wrong.'
      );
    } finally {
      setBusy(false);
    }
  };

  if (sent) {
    return (
      <div className="max-w-md mx-auto py-10 px-4">
        <div className="flex items-center gap-2 text-green-700">
          <MailCheck className="w-5 h-5" />
          <p className="text-xs font-bold uppercase tracking-[0.18em]">Check your inbox</p>
        </div>
        <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Reset link sent</h1>
        <p className="text-slate-600 mt-2">
          If <span className="font-semibold">{email}</span> has an account, a reset link is on its
          way. It works for one hour and can only be used once.
        </p>
        <p className="text-slate-600 mt-4 text-sm">
          Nothing arrived? Check spam, and make sure you confirmed your email address when you
          signed up — an unconfirmed address cannot be reset.
        </p>
        <Link to="/login" className="inline-block mt-6">
          <Button className="bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
            Back to sign in
          </Button>
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-md mx-auto py-10 px-4">
      <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Account recovery</p>
      <h1 className="text-3xl font-black text-comptia-charcoal mt-1">Forgot your password?</h1>
      <p className="text-slate-600 mt-2">
        Enter your email and we&apos;ll send a link to set a new one. Your study data stays exactly
        where it is.
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
                autoFocus
                value={email}
                onChange={(event) => setEmail(event.target.value)}
              />
            </div>

            <Button
              type="submit"
              disabled={busy}
              className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-6 gap-2"
            >
              {busy && <Loader2 className="w-4 h-4 animate-spin" />}
              Send reset link
            </Button>
          </form>

          <p className="text-sm text-slate-600 text-center mt-5">
            Remembered it?{' '}
            <Link to="/login" className="font-bold text-red-600 hover:text-red-700 underline">
              Sign in
            </Link>
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
