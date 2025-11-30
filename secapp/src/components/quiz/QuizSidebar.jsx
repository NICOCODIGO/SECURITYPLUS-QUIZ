import React from 'react';
import { Card } from '@/components/ui/card';
import { BookOpen, Target, FileText } from 'lucide-react';

export default function QuizSidebar({ selectedSection, onSectionChange }) {
  const sections = [
    { id: 'dashboard', label: 'Dashboard', icon: BookOpen },
    { id: 'domain1', label: 'Domain 1', icon: Target },
    { id: 'domain2', label: 'Domain 2', icon: Target },
    { id: 'domain3', label: 'Domain 3', icon: Target },
    { id: 'domain4', label: 'Domain 4', icon: Target },
    { id: 'domain5', label: 'Domain 5', icon: Target },
    { id: 'mock', label: 'Mock Exam Simulator', icon: FileText },
  ];

  return (
    <Card className="border-2 border-slate-200 shadow-lg h-fit sticky top-8">
      <div className="p-4 border-b-2 border-slate-200 bg-slate-50">
        <h2 className="font-bold text-slate-900 text-lg">Quiz Center</h2>
      </div>
      <nav className="p-2">
        {sections.map((section) => {
          const Icon = section.icon;
          const isActive = selectedSection === section.id;
          return (
            <button
              key={section.id}
              onClick={() => onSectionChange(section.id)}
              className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-all text-left ${
                isActive
                  ? 'bg-red-600 text-white font-semibold'
                  : 'text-slate-700 hover:bg-slate-100'
              }`}
            >
              <Icon className="w-4 h-4 flex-shrink-0" />
              <span className="text-sm">{section.label}</span>
            </button>
          );
        })}
      </nav>
    </Card>
  );
}