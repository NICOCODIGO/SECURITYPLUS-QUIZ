import { NavLink, Outlet } from "react-router-dom";
import ScrollToTop from "@/components/ScrollToTop.jsx";

function Layout() {
  const baseLinkClasses =
    "px-3 py-2 rounded-md text-sm font-medium transition hover:bg-slate-800";
  const activeClasses = "bg-slate-900 text-slate-100";
  const inactiveClasses = "text-slate-300";

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100">
      <ScrollToTop />
      <header className="border-b border-slate-800 bg-slate-950/70 backdrop-blur">
        <div className="mx-auto max-w-6xl px-4 py-3 flex items-center justify-between">
          <NavLink to="/" className="text-lg font-semibold">
            Security+ Study Lab
          </NavLink>
          <nav className="flex gap-2">
            <NavLink
              to="/"
              className={({ isActive }) =>
                `${baseLinkClasses} ${isActive ? activeClasses : inactiveClasses}`
              }
              end
            >
              Home
            </NavLink>
            <NavLink
              to="/lessons"
              className={({ isActive }) =>
                `${baseLinkClasses} ${isActive ? activeClasses : inactiveClasses}`
              }
            >
              Lessons
            </NavLink>
            <NavLink
              to="/quiz"
              className={({ isActive }) =>
                `${baseLinkClasses} ${isActive ? activeClasses : inactiveClasses}`
              }
            >
              Take Quiz
            </NavLink>
            <NavLink
              to="/progress"
              className={({ isActive }) =>
                `${baseLinkClasses} ${isActive ? activeClasses : inactiveClasses}`
              }
            >
              Progress
            </NavLink>
          </nav>
        </div>
      </header>

      <main className="mx-auto max-w-6xl px-4 py-6">
        <Outlet />
      </main>
    </div>
  );
}

export default Layout;
