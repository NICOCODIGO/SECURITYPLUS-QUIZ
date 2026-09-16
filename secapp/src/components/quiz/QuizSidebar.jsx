//this is for the "Quiz Center" sidebar component, the reason it has its own
// file is to keep things modular and clean, otherwise the main quiz page
// would be too cluttered and too long with sidebar code
import React from 'react';
import { Card } from '@/components/ui/card';
import { BookOpen, FileText, CalendarDays, Wrench, TrendingDown } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';

export default function QuizSidebar({ selectedSection, onSectionChange }) {
  // Domains render from the canonical list so their icons and colour rings
  // match everywhere else; the rest are fixed entries.
  const topSections = [
    { id: 'dashboard', label: 'Dashboard', icon: BookOpen },
    { id: 'daily', label: 'Question of the Day', icon: CalendarDays },
    { id: 'custom', label: 'Build Your Own Quiz', icon: Wrench },
  ];

  const bottomSections = [
    { id: 'weakest', label: 'Weakest Subject', icon: TrendingDown },
    { id: 'mock', label: 'Mock Exam Simulator', icon: FileText },
  ];

  const renderButton = (section) => {
    const Icon = section.icon;
    const isActive = selectedSection === section.id;

    return (
      <button
        key={section.id}
        onClick={() => onSectionChange(section.id)}
        className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-all text-left ${
          isActive ? 'bg-red-600 text-white font-semibold' : 'text-slate-700 hover:bg-slate-100'
        }`}
      >
        <Icon className="w-4 h-4 flex-shrink-0" />
        <span className="text-sm">{section.label}</span>
      </button>
    );
  };

  return (
    <Card className="border-2 border-slate-200 shadow-lg h-fit sticky top-8">
      <div className="p-4 border-b-2 border-slate-200 bg-slate-50">
        <h2 className="font-bold text-comptia-charcoal text-lg">Quiz Center</h2>
      </div>

      <nav className="p-2 space-y-0.5">
        {topSections.map(renderButton)}

        <p className="px-4 pt-4 pb-1.5 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
          Practice by domain
        </p>

        {securityDomains.map((domain) => {
          const isActive = selectedSection === domain.id;

          return (
            <button
              key={domain.id}
              onClick={() => onSectionChange(domain.id)}
              title={domain.numberedTitle}
              className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-left ${
                isActive ? 'bg-red-600 text-white font-semibold' : 'text-slate-700 hover:bg-slate-100'
              }`}
            >
              <span className={`w-8 h-8 flex-shrink-0 rounded-full bg-white border-2 ${domain.ringColor} flex items-center justify-center`}>
                <img src={domain.icon} alt="" className="w-4 h-4" />
              </span>
              <span className="min-w-0">
                <span className="block text-sm truncate">Domain {domain.number}</span>
                <span className={`block text-[11px] truncate ${isActive ? 'text-white/70' : 'text-slate-500'}`}>
                  {domain.questionCount} questions
                </span>
              </span>
            </button>
          );
        })}

        <div className="pt-3 mt-2 border-t-2 border-slate-100 space-y-0.5">
          {bottomSections.map(renderButton)}
        </div>
      </nav>
    </Card>
  );
}
