import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';

/**
 * How the exam is made up, and a way into each domain.
 *
 * A single bar split into five weighted segments, rather than five separate
 * bars: the domains sum to the whole exam, and only a part-to-whole form
 * says so. Five independent bars invited you to compare each against an
 * invisible maximum instead.
 *
 * Segment fills come from `chartColor` on each domain — darker than the icon
 * ring colours, which are thin borders on white and can be light without
 * failing contrast as a solid fill would.
 *
 * Green (5.0) and amber (4.0) sit adjacent and are the closest pair under
 * red-blind vision, so identity never rests on the fill alone: every segment
 * carries its percentage, segments are separated by a surface gap, and the
 * tiles below name each domain next to its own colour.
 */
export default function ExamBlueprint() {
  const [hovered, setHovered] = useState(null);
  const weightOf = (domain) => parseInt(domain.weight, 10);

  return (
    <div className="space-y-6">
      {/* ── Composition bar ─────────────────────────────── */}
      <div>
        <div className="flex gap-0.5 h-12 rounded-xl overflow-hidden">
          {securityDomains.map((domain) => (
            <Link
              key={domain.id}
              to={`/lessons?section=${domain.id}`}
              onMouseEnter={() => setHovered(domain.id)}
              onMouseLeave={() => setHovered(null)}
              onFocus={() => setHovered(domain.id)}
              onBlur={() => setHovered(null)}
              title={`${domain.numberedTitle} — ${domain.weight} of the exam`}
              aria-label={`${domain.numberedTitle}, ${domain.weight} of the exam`}
              className="relative flex items-center justify-center transition-opacity"
              style={{
                width: `${weightOf(domain)}%`,
                backgroundColor: domain.chartColor,
                opacity: hovered && hovered !== domain.id ? 0.45 : 1,
              }}
            >
              <span className="text-xs font-black text-white tabular-nums drop-shadow-sm">
                {domain.weight}
              </span>
            </Link>
          ))}
        </div>

        <div className="flex justify-between gap-4 mt-2 px-0.5">
          <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">
            100% of the SY0-701 exam
          </span>
          <span className="text-[11px] text-slate-500">
            {securityDomains.reduce((sum, d) => sum + d.questionCount, 0)} practice questions
          </span>
        </div>
      </div>

      {/* ── Domain tiles ────────────────────────────────── */}
      <div className="grid grid-cols-2 lg:grid-cols-5 gap-3">
        {securityDomains.map((domain) => (
          <Link
            key={domain.id}
            to={`/lessons?section=${domain.id}`}
            onMouseEnter={() => setHovered(domain.id)}
            onMouseLeave={() => setHovered(null)}
            onFocus={() => setHovered(domain.id)}
            onBlur={() => setHovered(null)}
            className={`group relative overflow-hidden bg-slate-50 border-2 rounded-xl p-4 flex flex-col items-center text-center gap-2 transition-all ${
              hovered === domain.id
                ? 'border-slate-300 shadow-lg -translate-y-0.5'
                : 'border-slate-200'
            }`}
          >
            {/* Colour key tying the tile to its bar segment. */}
            <span
              className="absolute top-0 inset-x-0 h-1"
              style={{ backgroundColor: domain.chartColor }}
            />

            <span className={`w-12 h-12 rounded-full bg-white border-4 ${domain.ringColor} shadow-sm flex items-center justify-center mt-1`}>
              <img src={domain.icon} alt="" className="w-7 h-7" />
            </span>

            <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">
              Domain {domain.number}
            </span>

            <span className="text-sm font-black text-comptia-charcoal leading-tight flex-1">
              {domain.title}
            </span>

            <span className="inline-flex items-center gap-1.5 text-xs font-bold text-slate-500 group-hover:text-red-600 transition-colors">
              {domain.questionCount} questions
              <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-0.5 transition-transform" />
            </span>
          </Link>
        ))}
      </div>
    </div>
  );
}
