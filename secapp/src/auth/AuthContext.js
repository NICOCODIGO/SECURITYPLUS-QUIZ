import { createContext, useContext } from 'react';

// Split from AuthProvider.jsx on purpose, and it is a lint requirement rather
// than taste: eslint.config.js extends react-refresh's vite config, which sets
// `only-export-components` to error. Exporting `useAuth` (a function) from the
// same file as `AuthProvider` (a component) trips it. This file holds no
// component, so the rule never fires here.

/**
 * Four states, not two. `unavailable` is the one that matters:
 * it means VITE_API_URL is unset, so there is no back end and therefore no
 * such thing as an account. Auth UI must not render at all in that mode — a
 * permanently dead Sign In button advertises a broken app, and a clean
 * checkout with no API is the supported default configuration.
 */
export const AuthContext = createContext({
  status: 'unavailable',
  user: null,
  signIn: async () => {},
  signUp: async () => {},
  signOut: async () => {},
});

export const useAuth = () => useContext(AuthContext);

/** True only where an account exists and is signed in. */
export const isSignedIn = (status) => status === 'authenticated';
