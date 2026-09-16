import React, { useState } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { BookOpen } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import { hasObjectives } from '../data/examObjectives';
import DomainDetailModal from './DomainDetailModal';

/**
 * The full five-domain card grid — icon, title, topic list and exam weight.
 *
 * This is the reference presentation, used on the About page. The Home page
 * deliberately shows the same data as a compact <ExamBlueprint /> instead, so
 * the two pages don't repeat an identical section.
 *
 * Each card opens a floating detail card with that domain's official exam
 * objectives.
 */
export default function DomainGrid() {
  const [openDomain, setOpenDomain] = useState(null);

  return (
    <>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-6 gap-x-8 gap-y-16 justify-items-center">
        {securityDomains.map((d, i) => (
          <button
            key={d.id}
            onClick={() => setOpenDomain(d)}
            aria-haspopup="dialog"
            className={`group relative w-full max-w-sm text-left
              lg:col-span-2
              ${i === 3 ? 'lg:col-start-2' : ''}
              ${i === 4 ? 'lg:col-start-4' : ''}
            `}
          >
            <Card
              className={`h-full bg-slate-50 rounded-2xl border-2 border-slate-200 shadow-sm ${d.hoverBorder} group-hover:shadow-xl transition-all`}
            >
              <CardContent className="pt-14 pb-6 px-8 text-center flex flex-col gap-3 h-full">
                <div className="absolute left-1/2 -top-10 -translate-x-1/2">
                  <div className={`w-20 h-20 rounded-full bg-white border-4 ${d.ringColor} shadow-md flex items-center justify-center group-hover:scale-105 transition-transform`}>
                    <img src={d.icon} alt="" className="w-12 h-12" />
                  </div>
                </div>

                <p className="text-sm font-semibold text-slate-500">Domain {d.number}</p>
                <h3 className="text-xl font-black text-comptia-charcoal leading-snug">
                  {d.title}
                </h3>
                <p className="text-sm text-slate-600 leading-relaxed flex-1">{d.topics}</p>

                <div className="flex flex-wrap items-center justify-center gap-2">
                  <span className={`text-xs font-bold ${d.badgeColor} border px-4 py-1.5 rounded-full`}>
                    {d.weight} of Exam
                  </span>
                </div>

                <span className="inline-flex items-center justify-center gap-1.5 text-xs font-bold text-slate-500 group-hover:text-red-600 transition-colors mt-1">
                  <BookOpen className="w-3.5 h-3.5" />
                  {hasObjectives(d.id) ? 'View exam objectives' : 'View domain details'}
                </span>
              </CardContent>
            </Card>
          </button>
        ))}
      </div>

      {openDomain && (
        <DomainDetailModal domain={openDomain} onClose={() => setOpenDomain(null)} />
      )}
    </>
  );
}
