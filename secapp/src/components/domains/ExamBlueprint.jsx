import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';

const weightOf = (domain) => parseInt(domain.weight, 10);

// Columns sized by exam weight, so each label sits directly under its segment.
const columns = securityDomains.map((d) => `${weightOf(d)}fr`).join(' ');
const lastIndex = securityDomains.length - 1;

/**
 * How the exam is made up — one bar split into five weighted segments.
 *
 * A single part-to-whole bar rather than five separate bars: the domains sum
 * to the whole exam, and five independent bars invited comparing each against
 * an invisible maximum instead.
 *
 * Used on both pages, with a different job on each:
 *  - Home (`getHref`): each segment links to that domain's explanation on the
 *    About page. `showLabels` names the domains under the bar — beside each
 *    segment from lg up, as a compact legend below that, where segments get
 *    too narrow.
 *  - About (`onSelect`): segments are buttons that open the matching row of
 *    the domain list beneath, and `activeId` keeps the open one highlighted.
 *    The list names the domains, so labels are turned off there.
 *
 * `action` completes each segment's accessible name ("1.0 General Security
 * Concepts, 12% of the exam — see what it covers").
 *
 * Segment fills come from `chartColor`. Green (5.0) and amber (4.0) sit
 * adjacent and are the closest pair under red-blind vision, so identity never
 * rests on the fill alone: every segment carries its percentage, segments are
 * separated by a surface gap, and a label names each one.
 */
export default function ExamBlueprint({
  onSelect,
  activeId = null,
  showLabels = true,
  getHref = (domain) => `/lessons?section=${domain.id}`,
  action = 'practice this domain',
}) {
  const [hovered, setHovered] = useState(null);
  const focused = hovered ?? activeId;
  const label = onSelect ? 'show details' : action;

  const hoverProps = (domain) => ({
    onMouseEnter: () => setHovered(domain.id),
    onMouseLeave: () => setHovered(null),
    onFocus: () => setHovered(domain.id),
    onBlur: () => setHovered(null),
  });

  return (
    <div>
      {/* ── Composition bar ─────────────────────────────── */}
      <div className="grid gap-x-0.5" style={{ gridTemplateColumns: columns }}>
        {securityDomains.map((domain, i) => (
          <DomainTarget
            key={domain.id}
            domain={domain}
            onSelect={onSelect}
            getHref={getHref}
            {...hoverProps(domain)}
            title={showLabels ? undefined : `${domain.numberedTitle} — ${domain.weight} of the exam`}
            aria-label={`${domain.numberedTitle}, ${domain.weight} of the exam — ${label}`}
            aria-pressed={onSelect ? activeId === domain.id : undefined}
            className="group min-w-0 text-left rounded-xl focus:outline-none focus-visible:ring-2 focus-visible:ring-comptia-charcoal focus-visible:ring-offset-2"
          >
            <span
              className={`flex items-center justify-center h-12 transition-opacity ${
                i === 0 ? 'rounded-l-xl' : ''
              } ${i === lastIndex ? 'rounded-r-xl' : ''}`}
              style={{
                backgroundColor: domain.chartColor,
                opacity: focused && focused !== domain.id ? 0.45 : 1,
              }}
            >
              <span className="text-xs font-black text-white tabular-nums drop-shadow-sm">
                {domain.weight}
              </span>
            </span>

            {showLabels && (
              <span className="hidden lg:flex flex-col gap-1 pt-3 pr-4">
                <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider tabular-nums">
                  Domain {domain.number}
                </span>
                <span className="text-sm font-black text-comptia-charcoal leading-snug">
                  {domain.title}
                </span>
                <span className="inline-flex items-center gap-1 text-xs font-bold text-slate-500 group-hover:text-red-600 transition-colors mt-0.5">
                  {domain.questionCount} questions
                  <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-0.5 transition-transform" />
                </span>
              </span>
            )}
          </DomainTarget>
        ))}
      </div>

      <div className={`flex justify-between gap-4 px-0.5 ${showLabels ? 'mt-2 lg:mt-5' : 'mt-2'}`}>
        <span className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">
          100% of the SY0-701 exam
        </span>
        <span className="text-[11px] text-slate-500">
          {securityDomains.reduce((sum, d) => sum + d.questionCount, 0)} practice questions
        </span>
      </div>

      {/* ── Legend (below lg) ───────────────────────────── */}
      {showLabels && (
        <ul className="lg:hidden mt-5 divide-y divide-slate-200 border-y border-slate-200">
          {securityDomains.map((domain) => (
            <li key={domain.id}>
              <DomainTarget
                domain={domain}
                onSelect={onSelect}
                getHref={getHref}
                className="group w-full flex items-center gap-3 py-3 text-left"
              >
                <span
                  className="w-3 h-3 rounded-sm flex-shrink-0"
                  style={{ backgroundColor: domain.chartColor }}
                />
                <span className="w-7 flex-shrink-0 text-xs font-bold text-slate-500 tabular-nums">
                  {domain.number}
                </span>
                <span className="flex-1 min-w-0 text-sm font-bold text-comptia-charcoal leading-snug">
                  {domain.title}
                </span>
                <span className="text-sm font-black text-slate-700 tabular-nums">{domain.weight}</span>
                <ArrowRight className="w-4 h-4 flex-shrink-0 text-slate-400 group-hover:text-red-600 transition-colors" />
              </DomainTarget>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

/** A link to wherever the page sends a domain, or a button when the page
    handles the pick itself. */
function DomainTarget({ domain, onSelect, getHref, children, ...rest }) {
  if (onSelect) {
    return (
      <button type="button" onClick={() => onSelect(domain.id)} {...rest}>
        {children}
      </button>
    );
  }
  return (
    <Link to={getHref(domain)} {...rest}>
      {children}
    </Link>
  );
}
