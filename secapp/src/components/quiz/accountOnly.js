// What needs an account — the one list, so the Overview, the sidebar, the
// sections and /daily can't disagree about it.
//
// All three are built on saved study data, and study data is only kept while
// signed in (components/data/persistence.js). The five domain quizzes and the
// mock exam stay open. docs/decisions.md records why these moved.
//
// Signed out, Weakest Subject and Build Your Own show as locked; Question of
// the Day is hidden altogether, and /daily explains why if reached directly.
import { isSignedIn, isSignedOut } from '@/auth/AuthContext';

export const ACCOUNT_ONLY_MODES = {
  weakest: {
    title: 'Weakest Subject',
    reason: 'It drills whichever domain your saved results show you score lowest in.',
    path: '/lessons?section=weakest',
  },
  custom: {
    title: 'Build Your Own',
    reason: "It builds quizzes from the questions you've missed and flagged, which are saved to your account.",
    path: '/lessons?section=custom',
  },
  daily: {
    title: 'Question of the Day',
    reason: "It's one new question every day, with a streak that's saved to your account.",
    path: '/daily',
  },
};

/**
 * True when `mode` is account-only and it is settled that nobody is signed
 * in. False while auth is loading, so a signed-in visitor never sees a lock.
 */
export const isSectionLocked = (mode, status) =>
  Object.hasOwn(ACCOUNT_ONLY_MODES, mode) && isSignedOut(status);

/**
 * Whether to offer Question of the Day at all. Only once signed in: it is
 * hidden rather than locked, so showing it while auth loads and then pulling
 * it away would be worse than letting it appear a moment late.
 */
export const showsDailyQuestion = (status) => isSignedIn(status);

/** Sign-up and sign-in links that come back to `mode` afterwards. */
export const authLinks = (mode) => {
  const next = encodeURIComponent(ACCOUNT_ONLY_MODES[mode].path);
  return { signUp: `/signup?next=${next}`, signIn: `/login?next=${next}` };
};
