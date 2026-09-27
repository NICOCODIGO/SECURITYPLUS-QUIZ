import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { LogOut, ShieldAlert, UserCog } from 'lucide-react';
import { useAuth } from '@/auth/AuthContext';

/**
 * The nav's account control.
 *
 * Owns its wrapper div, including the `md:border-l` divider, because the
 * divider must disappear with the control — left on Layout it renders as a
 * stray hairline whenever this returns null.
 */
export default function AuthNav() {
  const { status, user, signOut } = useAuth();
  const location = useLocation();

  // No API means no accounts, so there is nothing to offer. Not a disabled
  // button: a permanently dead control in the nav advertises a broken app, and
  // a clean checkout with VITE_API_URL unset is the supported default.
  if (status === 'unavailable') return null;

  const wrapper = 'ml-auto shrink-0 md:ml-0 md:pl-4 lg:pl-6 md:border-l md:border-slate-200';

  // Fixed size, so the nav does not reflow when auth resolves a moment later.
  if (status === 'loading') {
    return (
      <div className={wrapper}>
        <div className="w-[104px] h-10 rounded-md bg-slate-100 animate-pulse" aria-hidden="true" />
      </div>
    );
  }

  if (status === 'anonymous') {
    // Come back to where they were, not to a default page.
    const next = encodeURIComponent(location.pathname + location.search);
    return (
      <div className={wrapper}>
        <Link to={`/login?next=${next}`}>
          <Button className="bg-red-600 hover:bg-red-700 text-white font-semibold px-6">
            Sign In
          </Button>
        </Link>
      </div>
    );
  }

  const label = user?.displayName || user?.email || 'Account';
  const initial = label.charAt(0).toUpperCase();

  return (
    <div className={wrapper}>
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <button
            type="button"
            className="flex items-center gap-2 rounded-md border-2 border-slate-200 bg-white px-2 py-1.5 md:px-3 hover:bg-slate-50"
          >
            <span
              className="w-7 h-7 shrink-0 rounded-full bg-red-600 text-white text-xs font-bold flex items-center justify-center"
              aria-hidden="true"
            >
              {initial}
            </span>
            {/* Icon-only under md: the top bar has to fit 360px. */}
            <span className="hidden md:block max-w-[140px] truncate text-sm font-bold text-comptia-charcoal">
              {label}
            </span>
            <span className="md:hidden sr-only">Account</span>
          </button>
        </DropdownMenuTrigger>

        <DropdownMenuContent align="end" className="w-56">
          <div className="px-2 py-1.5">
            <p className="text-xs text-slate-500">Signed in as</p>
            <p className="text-sm font-bold text-comptia-charcoal truncate">{user?.email}</p>
          </div>
          <DropdownMenuSeparator />
          <DropdownMenuItem asChild className="gap-2 cursor-pointer">
            <Link to="/account">
              <UserCog className="w-4 h-4" />
              Account settings
              {/* The one nudge worth making visible: without a confirmed
                  address there is no way to reset a forgotten password, and
                  nobody goes looking for that setting until it is too late. */}
              {user && user.emailVerified === false && (
                <ShieldAlert className="w-4 h-4 ml-auto text-amber-600" aria-label="Email not confirmed" />
              )}
            </Link>
          </DropdownMenuItem>
          <DropdownMenuSeparator />
          <DropdownMenuItem onClick={signOut} className="gap-2 cursor-pointer">
            <LogOut className="w-4 h-4" />
            Sign out
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  );
}
