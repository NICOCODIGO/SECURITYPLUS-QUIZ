import React from "react";
import { Link } from "react-router-dom";
import { Shield, GraduationCap, BookOpen, BarChart3, ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import ScrollToTop from "./components/ScrollToTop";

export default function Layout({ children, currentPageName }) {

  // ✅ Correct lowercase route paths that match App.jsx
  const navItems = [
    { name: "Home", path: "/", icon: GraduationCap },
    { name: "About", path: "/about", icon: Shield },
    { name: "Lessons", path: "/lessons", icon: BookOpen },
    { name: "Progress", path: "/progress", icon: BarChart3 },
  ];

  const isQuizPage = currentPageName === "TakeQuiz";

  return (
    <div className="min-h-screen bg-slate-50">
      <ScrollToTop />

      {/* Color Palette Fix */}
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

      {/* Top Navigation */}
      {!isQuizPage && (
        <nav className="bg-white border-b border-slate-200 sticky top-0 z-50 shadow-sm">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex justify-between items-center h-16">

              {/* Logo */}
              <Link to="/" className="flex items-center gap-3 group">
                <div className="w-12 h-12 bg-red-600 rounded-full flex items-center justify-center shadow-lg group-hover:shadow-xl transition-all border-4 border-slate-300">
                  <Shield className="w-6 h-6 text-white" />
                </div>
                <div>
                  <h1 className="text-xl font-bold text-slate-900">EduPrep</h1>
                  <p className="text-xs text-red-600 font-bold tracking-wide -mt-0.5">SECURITY+</p>
                </div>
              </Link>

              {/* Desktop Navigation */}
              <div className="hidden md:flex items-center gap-1">
                {navItems.map((item) => {
                  const Icon = item.icon;
                  const isActive = window.location.pathname === item.path;

                  return (
                    <Link
                      key={item.path}
                      to={item.path}
                      className={`flex items-center gap-2 px-4 py-2 rounded-lg transition-all font-medium ${
                        isActive
                          ? "bg-red-600 text-white"
                          : "text-slate-700 hover:bg-slate-100 hover:text-slate-900"
                      }`}
                    >
                      <Icon className="w-4 h-4" />
                      {item.name}
                    </Link>
                  );
                })}

                <Link
                  to="/resources"
                  className={`flex items-center gap-2 px-4 py-2 rounded-lg transition-all font-medium ${
                    currentPageName === "AdminContentManager"
                      ? "bg-red-600 text-white"
                      : "text-slate-700 hover:bg-slate-100 hover:text-slate-900"
                  }`}
                >
                  <ExternalLink className="w-4 h-4" />
                  Resources
                </Link>
              </div>

              {/* Sign In Button Placeholder */}
              <Button className="bg-red-600 hover:bg-red-700 text-white font-semibold px-6">
                Sign In
              </Button>
            </div>
          </div>

          {/* Mobile Navigation */}
          <div className="md:hidden border-t border-slate-200 bg-white">
            <div className="flex justify-around py-2">
              {navItems.map((item) => {
                const Icon = item.icon;
                const isActive = window.location.pathname === item.path;

                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    className={`flex flex-col items-center gap-1 px-3 py-2 rounded-lg transition-all ${
                      isActive ? "text-red-600 font-semibold" : "text-slate-500"
                    }`}
                  >
                    <Icon className="w-5 h-5" />
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

      {/* Page Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">{children}</main>

      {/* Footer */}
      {!isQuizPage && (
        <footer className="bg-slate-100 border-t border-slate-200 mt-20">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            <p className="text-center text-sm text-slate-500">
              © 2024 EduPrep. Preparing you for CompTIA Security+ certification.
            </p>
          </div>
        </footer>
      )}
    </div>
  );
}
