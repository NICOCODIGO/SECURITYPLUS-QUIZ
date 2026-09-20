import React from "react";
import { Link } from "react-router-dom";
import { ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import ScrollToTop from "./components/ScrollToTop";
import Logo from "./components/Logo";

// Filenames are matched exactly, including case and the space in the folder
// name — the Alpine Docker build resolves these case-sensitively even though
// the dev machine does not, so "homeicon.png" would build here and 404 there.
import homeIcon from "./assets/Nav icons/HomeIcon.png";
import aboutIcon from "./assets/Nav icons/icon.png";
import practiceIcon from "./assets/home page/openbook.png";
import progressIcon from "./assets/home page/graphfork.png";

export default function Layout({ children, currentPageName }) {

  const navItems = [
    { name: "Home", path: "/", icon: homeIcon },
    { name: "About", path: "/about", icon: aboutIcon },
    { name: "Practice", path: "/lessons", icon: practiceIcon },
    { name: "Progress", path: "/progress", icon: progressIcon },
  ];

  // Answering questions gets the whole screen: no nav, no footer, less
  // padding. Both the quiz and the daily question do.
  const isFullScreen = ["TakeQuiz", "DailyQuestion"].includes(currentPageName);

  return (
    <div className="relative min-h-screen bg-comptia-canvas">
      <ScrollToTop />

      {/* Neutral technical grid. Replaces the old red blur field — CompTIA
          uses red as an accent only, never as an ambient page wash. */}
      <div
        className="fixed inset-0 pointer-events-none"
        style={{
          zIndex: 0,
          backgroundImage:
            'linear-gradient(#1D252D 1px, transparent 1px), linear-gradient(90deg, #1D252D 1px, transparent 1px)',
          backgroundSize: '64px 64px',
          opacity: 0.03,
        }}
      />

      {/* Content wrapper. Flex column so <main> absorbs the slack and the
          footer is pinned to the bottom of the viewport on short pages. */}
      <div className="relative flex flex-col min-h-screen" style={{ zIndex: 1 }}>

        <style>{`
          .text-red-600, .text-red-700 { color: #C8102E !important; }
          .bg-red-600 { background-color: #C8102E !important; }
          .bg-red-700 { background-color: #B01D2A !important; }
          .hover\\:bg-red-700:hover { background-color: #B01D2A !important; }
          .bg-red-50 { background-color: #FEF2F3 !important; }
          .border-red-200 { border-color: #FECDD3 !important; }
          .border-red-600 { border-color: #C8102E !important; }
          .hover\\:border-red-600:hover { border-color: #C8102E !important; }
        `}</style>

        {!isFullScreen && (
          <nav className="bg-white/90 backdrop-blur-md border-b border-slate-200 sticky top-0 shadow-sm" style={{ zIndex: 50 }}>
            {/* Full-bleed bar: the brand pins to the far left, the actions to
                the far right, and the links take the slack in the middle. */}
            <div className="w-full px-4 sm:px-6 lg:px-10">
              <div className="flex items-center gap-3 lg:gap-6 h-[4.5rem]">

                <Link to="/" className="flex items-center gap-3 group shrink-0 md:pr-4 lg:pr-6 md:border-r md:border-slate-200">
                  <Logo markClassName="w-12 h-12 drop-shadow-md group-hover:drop-shadow-xl transition-all" />
                </Link>

                <div className="hidden md:flex flex-1 min-w-0 items-center justify-center gap-0.5 lg:gap-1">
                  {navItems.map((item) => {
                    const isActive = window.location.pathname === item.path;

                    return (
                      <Link
                        key={item.path}
                        to={item.path}
                        className={`flex items-center gap-2 px-2.5 lg:px-4 py-2 rounded-lg transition-all font-medium whitespace-nowrap ${
                          isActive
                            ? "bg-red-600 text-white"
                            : "text-slate-700 hover:bg-slate-100 hover:text-slate-900"
                        }`}
                      >
                        {/* decorative: the link's own text already names it */}
                        <img src={item.icon} alt="" aria-hidden="true" className="w-4 h-4 object-contain" />
                        {item.name}
                      </Link>
                    );
                  })}

                  <Link
                    to="/resources"
                    className={`flex items-center gap-2 px-2.5 lg:px-4 py-2 rounded-lg transition-all font-medium whitespace-nowrap ${
                      currentPageName === "AdminContentManager"
                        ? "bg-red-600 text-white"
                        : "text-slate-700 hover:bg-slate-100 hover:text-slate-900"
                    }`}
                  >
                    <ExternalLink className="w-4 h-4" />
                    Resources
                  </Link>
                </div>

                <div className="ml-auto shrink-0 md:ml-0 md:pl-4 lg:pl-6 md:border-l md:border-slate-200">
                  <Button className="bg-red-600 hover:bg-red-700 text-white font-semibold px-6">
                    Sign In
                  </Button>
                </div>
              </div>
            </div>

            <div className="md:hidden border-t border-slate-200 bg-white/90 backdrop-blur-md">
              <div className="flex justify-around py-2 px-2">
                {navItems.map((item) => {
                  const isActive = window.location.pathname === item.path;

                  return (
                    <Link
                      key={item.path}
                      to={item.path}
                      className={`flex flex-col items-center gap-1 px-3 py-2 rounded-lg transition-all ${
                        isActive ? "text-red-600 font-semibold" : "text-slate-500"
                      }`}
                    >
                      <img src={item.icon} alt="" aria-hidden="true" className="w-5 h-5 object-contain" />
                      <span className="text-xs font-medium">{item.name}</span>
                    </Link>
                  );
                })}

                <Link
                  to="/resources"
                  className={`flex flex-col items-center gap-1 px-3 py-2 rounded-lg transition-all ${
                    currentPageName === "AdminContentManager"
                      ? "text-red-600 font-semibold"
                      : "text-slate-500"
                  }`}
                >
                  <ExternalLink className="w-5 h-5" />
                  <span className="text-xs font-medium">Resources</span>
                </Link>
              </div>
            </div>
          </nav>
        )}

        {/* The quiz page has no nav to clear and must fit one screen, so it
            gets less vertical padding. */}
        <main className={`flex-1 w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 ${isFullScreen ? 'py-5' : 'py-8'}`}>
          {children}
        </main>

        {!isFullScreen && (
          // No top margin: <main> already contributes py-8 beneath page
          // content, and pages ending in a full-width colour band cancel that
          // themselves so the band meets the footer edge to edge.
          <footer className="bg-comptia-charcoal">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
              <div className="flex flex-col sm:flex-row items-center justify-center gap-3">
                <span className="h-1 w-10 bg-red-600 rounded-full" />
                <p className="text-center text-sm text-slate-400">
                  © {new Date().getFullYear()} Certucation. Preparing you for CompTIA Security+ certification.
                </p>
              </div>
            </div>
          </footer>
        )}

      </div>
    </div>
  );
}