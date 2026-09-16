import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertTriangle, CheckCircle2, MinusCircle, ArrowRight } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import { statusForAccuracy, NEUTRAL_STATUS } from '@/lib/performanceStatus';

/**
 * Accuracy per domain — the "which domain do I keep getting wrong" answer.
 *
 * Shows all five domains, including ones never attempted, so an avoided
 * domain is visible as a gap rather than silently missing from the list.
 * Bars carry a status colour, but every row also states the percentage and a
 * word ("Needs work"), so nothing is encoded by colour alone.
 */

const STATUS_ICON = {
  good: CheckCircle2,
  warning: AlertTriangle,
  critical: AlertTriangle,
  none: MinusCircle,
};

export default function DomainPerformancePanel({ performance }) {
  // Index the attempted rows so every domain can be rendered in exam order,
  // attempted or not.
  const byId = new Map(
    performance.rows
      .filter((row) => row.domain)
      .map((row) => [row.domain.id, row])
  );

  return (
    <Card className="border-2 border-slate-200 shadow-lg">
      <CardHeader>
        <CardTitle className="text-xl font-bold text-comptia-charcoal">
          Accuracy by Domain
        </CardTitle>
        <p className="text-sm text-slate-600">
          Share of questions answered correctly in each domain, across every attempt.
        </p>
      </CardHeader>
      <CardContent>
        <div className="space-y-5">
          {securityDomains.map((domain) => {
            const row = byId.get(domain.id);
            const attempted = Boolean(row);
            const accuracy = attempted ? row.accuracy : 0;
            const status = attempted ? statusForAccuracy(accuracy) : NEUTRAL_STATUS;
            const StatusIcon = STATUS_ICON[status.key];

            return (
              <div key={domain.id} className="space-y-2">
                <div className="flex items-center justify-between gap-4 flex-wrap">
                  <div className="flex items-center gap-3 min-w-0">
                    <div className={`w-9 h-9 flex-shrink-0 rounded-full bg-white border-2 ${domain.ringColor} flex items-center justify-center`}>
                      <img src={domain.icon} alt="" className="w-5 h-5" />
                    </div>
                    <div className="min-w-0">
                      <p className="text-sm font-bold text-comptia-charcoal truncate">
                        {domain.numberedTitle}
                      </p>
                      <p className="text-xs text-slate-500">
                        {attempted
                          ? `${row.correct} of ${row.total} correct · ${row.attempts} ${row.attempts === 1 ? 'quiz' : 'quizzes'}`
                          : 'No questions attempted yet'}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-center gap-3 flex-shrink-0">
                    <span
                      className={`inline-flex items-center gap-1.5 text-xs font-bold px-2.5 py-1 rounded-full border ${status.bg} ${status.text} ${status.border}`}
                    >
                      <StatusIcon className="w-3.5 h-3.5" />
                      {status.label}
                    </span>
                    <span className="text-lg font-black text-comptia-charcoal tabular-nums w-14 text-right">
                      {attempted ? `${accuracy}%` : '—'}
                    </span>
                  </div>
                </div>

                {/* Track is a hairline step off the surface; the fill carries
                    the status colour and is capped well under 24px. */}
                <div className="h-2.5 bg-slate-100 rounded-full overflow-hidden">
                  {attempted && (
                    <div
                      className="h-full rounded-r-[4px]"
                      style={{ width: `${Math.max(accuracy, 1)}%`, backgroundColor: status.color }}
                    />
                  )}
                </div>
              </div>
            );
          })}
        </div>

        {performance.weakest && (
          <div className="mt-6 pt-5 border-t-2 border-slate-100">
            <Link
              to={`/lessons?section=${performance.weakest.domain ? performance.weakest.domain.id : 'weakest'}`}
              className="inline-flex items-center gap-2 text-sm font-bold text-red-600 hover:underline"
            >
              Practise {performance.weakest.title}, your weakest domain
              <ArrowRight className="w-4 h-4" />
            </Link>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
