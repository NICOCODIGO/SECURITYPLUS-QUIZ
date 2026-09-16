import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { XCircle, ChevronDown, ChevronUp, PartyPopper } from 'lucide-react';

/**
 * The questions you get wrong most often, with the right answer.
 *
 * Only attempts recorded with per-question detail contribute — anything taken
 * before TakeQuiz started storing `answers` has no question-level record, so
 * an older history can legitimately produce an empty panel.
 */
export default function MostMissedPanel({ missed, hasHistory }) {
  const [expanded, setExpanded] = useState(null);

  return (
    <Card className="border-2 border-slate-200 shadow-lg">
      <CardHeader>
        <CardTitle className="text-xl font-bold text-comptia-charcoal">
          Topics You Keep Missing
        </CardTitle>
        <p className="text-sm text-slate-600">
          Ranked by how often you have answered them incorrectly.
        </p>
      </CardHeader>
      <CardContent>
        {missed.length === 0 ? (
          <div className="flex flex-col items-center justify-center gap-3 py-10 text-center">
            {hasHistory ? (
              <>
                <PartyPopper className="w-10 h-10 text-emerald-600" />
                <p className="text-sm text-slate-600">
                  Nothing repeatedly wrong yet — keep going.
                </p>
              </>
            ) : (
              <>
                <XCircle className="w-10 h-10 text-slate-300" />
                <p className="text-sm text-slate-600">
                  Take a quiz and the questions you miss will collect here.
                </p>
              </>
            )}
          </div>
        ) : (
          <div className="space-y-3">
            {missed.map((item) => {
              const isOpen = expanded === item.id;

              return (
                <div
                  key={item.id}
                  className="border-2 border-slate-200 rounded-xl overflow-hidden"
                >
                  <button
                    onClick={() => setExpanded(isOpen ? null : item.id)}
                    className="w-full flex items-start gap-4 p-4 text-left hover:bg-slate-50 transition-colors"
                  >
                    <span className="flex-shrink-0 w-11 h-11 rounded-lg bg-red-50 border-2 border-red-200 flex flex-col items-center justify-center">
                      <span className="text-sm font-black text-red-700 leading-none tabular-nums">
                        {item.missed}
                      </span>
                      <span className="text-[9px] font-bold text-red-700 uppercase leading-none mt-0.5">
                        {item.missed === 1 ? 'miss' : 'misses'}
                      </span>
                    </span>

                    <span className="flex-1 min-w-0">
                      <span className="block text-sm font-bold text-comptia-charcoal">
                        {item.question}
                      </span>
                      <span className="block text-xs text-slate-500 mt-1">
                        {item.domain ? item.domain.numberedTitle : item.domainLabel}
                        {' · '}
                        missed {item.missed} of {item.seen} {item.seen === 1 ? 'time' : 'times'}
                      </span>
                    </span>

                    {isOpen ? (
                      <ChevronUp className="w-5 h-5 text-slate-400 flex-shrink-0" />
                    ) : (
                      <ChevronDown className="w-5 h-5 text-slate-400 flex-shrink-0" />
                    )}
                  </button>

                  {isOpen && (
                    <div className="px-4 pb-4 pt-1 space-y-3 bg-slate-50 border-t-2 border-slate-100">
                      <div>
                        <p className="text-xs font-bold text-emerald-800 uppercase tracking-wide mb-1">
                          Correct answer
                        </p>
                        <p className="text-sm text-slate-800 font-medium">
                          {item.correctChoice}
                        </p>
                      </div>
                      <div>
                        <p className="text-xs font-bold text-slate-600 uppercase tracking-wide mb-1">
                          Why
                        </p>
                        <p className="text-sm text-slate-700 leading-relaxed">
                          {item.explanation}
                        </p>
                      </div>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
