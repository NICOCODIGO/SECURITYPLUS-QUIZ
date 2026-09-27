import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Lock, ServerOff } from 'lucide-react';
import { useAuth } from '@/auth/AuthContext';
import { ACCOUNT_ONLY_MODES, authLinks } from './accountOnly';

/**
 * What an account-only mode shows to a signed-out visitor, in place of the
 * mode itself — reached from the Practice sidebar, a shared `?section=` link,
 * or /daily directly.
 *
 * It says what the mode needs and why, then points at what still works, so
 * it reads as a signpost rather than a wall. `hideTitle` drops the heading
 * where the page around it already names the mode.
 */
export default function AccountRequired({ mode, hideTitle = false }) {
  const { status } = useAuth();
  const { title, reason } = ACCOUNT_ONLY_MODES[mode];

  // No API, so no account to offer. Say so rather than inviting someone to
  // sign up to a server that isn't there.
  const unavailable = status === 'unavailable';
  const links = authLinks(mode);

  return (
    <div className="space-y-6">
      {!hideTitle && <h2 className="text-3xl font-black text-comptia-charcoal">{title}</h2>}

      <Card className="border border-slate-200 shadow-sm">
        <CardContent className="p-8 sm:p-12 text-center space-y-4">
          <div
            className={`w-16 h-16 rounded-full flex items-center justify-center mx-auto shadow-lg ${
              unavailable ? 'bg-slate-400' : 'bg-red-600'
            }`}
          >
            {unavailable ? <ServerOff className="w-8 h-8 text-white" /> : <Lock className="w-8 h-8 text-white" />}
          </div>
          <h3 className="text-2xl font-black text-comptia-charcoal">
            {unavailable ? 'This needs an account' : 'To access this, create an account'}
          </h3>
          <p className="text-slate-600 max-w-lg mx-auto">
            {reason}{' '}
            {unavailable
              ? 'This build has no server configured, so there are no accounts — but the domain quizzes and the mock exam still work.'
              : 'The domain quizzes and the mock exam work without one.'}
          </p>
          {!unavailable && (
            <div className="flex flex-col sm:flex-row gap-3 justify-center pt-1">
              <Link to={links.signUp}>
                <Button className="w-full sm:w-auto bg-red-600 hover:bg-red-700 text-white font-bold px-8 py-6 rounded-lg">
                  Create free account
                </Button>
              </Link>
              <Link to={links.signIn}>
                <Button variant="outline" className="w-full sm:w-auto border-2 font-bold px-8 py-6 rounded-lg">
                  Sign in
                </Button>
              </Link>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
