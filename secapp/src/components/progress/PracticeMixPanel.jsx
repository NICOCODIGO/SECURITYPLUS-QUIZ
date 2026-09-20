import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { BookOpen, FileText, TrendingDown, Wrench, CalendarDays, ChevronRight } from 'lucide-react';

/**
 * How much of each kind of practice has been done.
 *
 * Question of the Day sits alongside the quiz types but is counted from its
 * own key — it never enters quiz_history, so it can't skew the averages.
 * Each row links to that mode in the Quiz Center.
 */
export default function PracticeMixPanel({ modes, daily, className = '' }) {
  const quizDetail = (mode, extra) =>
    mode.count === 0 ? 'None yet' : extra || `${mode.averageScore}% correct`;

  const rows = [
    {
      key: 'domain',
      section: 'dashboard',
      icon: BookOpen,
      tint: 'bg-sky-50 text-sky-700',
      label: 'Domain quizzes',
      value: modes.domain.count,
      detail: quizDetail(modes.domain),
    },
    {
      key: 'mock',
      section: 'mock',
      icon: FileText,
      tint: 'bg-red-50 text-red-700',
      label: 'Mock exams',
      value: modes.mock.count,
      detail: quizDetail(modes.mock, `best ${modes.mock.bestScore}% · ${modes.mock.passes} passed`),
    },
    {
      key: 'weakest',
      section: 'weakest',
      icon: TrendingDown,
      tint: 'bg-violet-50 text-violet-700',
      label: 'Weakest subject',
      value: modes.weakest.count,
      detail: quizDetail(modes.weakest),
    },
    {
      key: 'custom',
      section: 'custom',
      icon: Wrench,
      tint: 'bg-slate-100 text-slate-700',
      label: 'Custom quizzes',
      value: modes.custom.count,
      detail: quizDetail(modes.custom),
    },
    {
      key: 'daily',
      section: 'daily',
      icon: CalendarDays,
      tint: 'bg-amber-50 text-amber-700',
      label: 'Question of the Day',
      value: daily.streak,
      unit: 'day streak',
      detail: daily.answered ? `${daily.correct} of ${daily.answered} correct` : 'None answered yet',
    },
  ];

  return (
    <Card className={`border border-slate-200 shadow-sm flex flex-col ${className}`}>
      <CardHeader className="p-5 pb-2">
        <CardTitle className="text-base font-bold text-comptia-charcoal">How You've Practiced</CardTitle>
        <p className="text-xs text-slate-500 mt-1">
          Quizzes by type. Question of the Day is tracked separately so single answers never swing your averages.
        </p>
      </CardHeader>
      <CardContent className="px-3 pb-3 flex-1 flex flex-col">
        <ul className="flex-1 flex flex-col justify-between">
          {rows.map((row) => {
            const Icon = row.icon;
            return (
              <li key={row.key}>
                <Link
                  to={`/lessons?section=${row.section}`}
                  className="group flex items-center gap-3 rounded-lg px-2 py-2.5 hover:bg-slate-50 transition-colors"
                >
                  <span className={`w-9 h-9 rounded-lg flex items-center justify-center flex-shrink-0 ${row.tint}`}>
                    <Icon className="w-4 h-4" />
                  </span>
                  <span className="min-w-0 flex-1">
                    <span className="block text-sm font-bold text-comptia-charcoal">{row.label}</span>
                    <span className="block text-xs text-slate-500 truncate">{row.detail}</span>
                  </span>
                  <span className="text-right flex-shrink-0">
                    <span className="text-xl font-black text-comptia-charcoal tabular-nums">{row.value}</span>
                    {row.unit && <span className="block text-[10px] font-bold text-slate-500">{row.unit}</span>}
                  </span>
                  <ChevronRight className="w-4 h-4 text-slate-300 group-hover:text-red-600 transition-colors flex-shrink-0" />
                </Link>
              </li>
            );
          })}
        </ul>
      </CardContent>
    </Card>
  );
}
