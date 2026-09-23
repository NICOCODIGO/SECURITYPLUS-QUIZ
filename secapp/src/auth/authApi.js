// The five auth calls. Thin on purpose — AuthProvider owns the state, this
// owns the URLs.

import { postJson, getJson } from '@/api/apiClient';

const BASE = '/api/v1/auth';

/** `auth: false` because these carry no bearer token by definition. */
export const register = (email, password, displayName) =>
  postJson(`${BASE}/register`, { email, password, displayName }, { auth: false });

export const login = (email, password) =>
  postJson(`${BASE}/login`, { email, password }, { auth: false });

export const logout = () => postJson(`${BASE}/logout`, null, { auth: false });

export const me = () => getJson(`${BASE}/me`);
