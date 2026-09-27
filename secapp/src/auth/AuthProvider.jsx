import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { isConfigured, refreshSession } from '@/api/apiClient';
import {
  clearAccessToken,
  setAccessToken,
  setSessionActive,
  setUnauthenticatedHandler,
  setUserId,
} from '@/api/authSession';
import { hydrate as hydrateStudyData } from '@/components/data/source';
import * as authApi from './authApi';
import { AuthContext } from './AuthContext';

/**
 * Holds who is signed in.
 *
 * **The boot refresh below is load-bearing — do not remove it.** The access
 * token is held in memory (see api/authSession.js for why), and the quiz flow
 * navigates with `window.location.href`, so it crosses two full page reloads
 * and loses that variable each time. The silent refresh on mount is what makes
 * an in-memory token survivable at all: the httpOnly cookie outlives the
 * reload and re-mints. Delete it and signing in appears to work until the
 * moment someone starts a quiz.
 *
 * With VITE_API_URL unset the status is `unavailable` and stays there. No
 * request is made, nothing renders, and the app behaves exactly as it did
 * before accounts existed.
 */
export default function AuthProvider({ children }) {
  const [status, setStatus] = useState(isConfigured() ? 'loading' : 'unavailable');
  const [user, setUser] = useState(null);

  useEffect(() => {
    if (!isConfigured()) return;

    let cancelled = false;

    refreshSession()
      .then((session) => {
        if (cancelled) return;
        // Both before the status flips, so the first render that can read
        // storage already sees persistence allowed and knows whose it is.
        setUserId(session.user.id);
        setSessionActive(true);
        // And the server's copy before that, so the first signed-in render
        // already has real data. Hydrating afterwards paints an empty
        // dashboard for a beat, which reads as data loss. Never throws: a
        // failed pull leaves whatever is local in place.
        hydrateStudyData().finally(() => {
          if (cancelled) return;
          setUser(session.user);
          setStatus('authenticated');
        });
      })
      .catch(() => {
        // No cookie, an expired one, or no server. All mean "signed out" —
        // this is the normal first-visit path, not an error worth surfacing.
        if (cancelled) return;
        clearAccessToken();
        setSessionActive(false);
        setUserId(null);
        setStatus('anonymous');
      });

    return () => {
      cancelled = true;
    };
  }, []);

  // A refresh that fails mid-session drops us to anonymous rather than leaving
  // the UI claiming to be signed in.
  useEffect(() => {
    setUnauthenticatedHandler(() => {
      setUser(null);
      setStatus('anonymous');
    });
    return () => setUnauthenticatedHandler(null);
  }, []);

  const adopt = useCallback(async (session) => {
    setAccessToken(session.accessToken);
    setUserId(session.user.id);
    setSessionActive(true);
    // Pull this account's history before anything renders as signed in, so
    // somebody signing in on a second device sees their results rather than an
    // empty dashboard that fills in a moment later. Never throws.
    await hydrateStudyData();
    setUser(session.user);
    setStatus('authenticated');
    return session;
  }, []);

  /**
   * Resolves to `{ signedIn: true }` or `{ challenge, method }`.
   *
   * The challenge branch deliberately adopts nothing: there is no access token
   * and no refresh cookie until the second step passes, so a caller holding
   * only the password cannot read or write any study data.
   */
  const signIn = useCallback(
    async (email, password) => {
      const result = await authApi.login(email, password);
      if (result?.challenge) {
        return { challenge: result.challenge, method: result.twoFactorMethod };
      }
      await adopt(result);
      return { signedIn: true };
    },
    [adopt]
  );

  const completeTwoFactor = useCallback(
    async (challenge, code) => adopt(await authApi.verifyTwoFactor(challenge, code)),
    [adopt]
  );

  const signUp = useCallback(
    async (email, password, displayName) =>
      adopt(await authApi.register(email, password, displayName)),
    [adopt]
  );

  const signOut = useCallback(async () => {
    try {
      await authApi.logout();
    } catch {
      // Logout is best-effort: the cookie may already be expired. Either way
      // this browser is signed out, so never leave the UI stuck.
    }
    clearAccessToken();
    setSessionActive(false);
    setUserId(null);
    setUser(null);
    setStatus('anonymous');
  }, []);

  /**
   * Lets the account page reflect a change — verifying an address, turning 2FA
   * on — without a reload. `user` is what AuthNav and the account page read, so
   * a stale copy shows the wrong state until the next refresh.
   */
  const refreshUser = useCallback(async () => {
    const current = await authApi.me();
    setUser(current);
    return current;
  }, []);

  const value = useMemo(
    () => ({ status, user, signIn, signUp, signOut, completeTwoFactor, refreshUser }),
    [status, user, signIn, signUp, signOut, completeTwoFactor, refreshUser]
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}
