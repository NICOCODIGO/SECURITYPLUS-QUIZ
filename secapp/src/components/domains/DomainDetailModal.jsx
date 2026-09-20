import React, { useEffect, useRef } from 'react';
import { createPortal } from 'react-dom';
import { Link } from 'react-router-dom';
import { X, ArrowRight, ListChecks, FileQuestion } from 'lucide-react';
import { getObjectives, countTerms } from '../data/examObjectives';

/**
 * Floating detail card for one exam domain, over a blurred backdrop.
 *
 * Holds the official SY0-701 objectives for the domain — the full outline,
 * three levels deep. The list is long, so the card scrolls internally and
 * keeps its header pinned.
 *
 * Rendered into <body> through a portal, not where it's used. Inline, it sat
 * in a `space-y-8` list whose margin-top pushed the fixed overlay 32px down,
 * leaving a strip of the nav showing above it, and it shared the page's
 * stacking context with the sticky nav. From <body>, z-[60] clears the nav's
 * z-50 outright.
 */
export default function DomainDetailModal({ domain, onClose }) {
  const closeRef = useRef(null);

  const objectives = getObjectives(domain.id);
  const termCount = countTerms(domain.id);

  // Escape to close, lock the page behind so only the card scrolls, and hand
  // focus back to whatever opened the card once it closes.
  useEffect(() => {
    const onKey = (e) => e.key === 'Escape' && onClose();
    document.addEventListener('keydown', onKey);

    const previous = document.body.style.overflow;
    const opener = document.activeElement;
    document.body.style.overflow = 'hidden';
    closeRef.current?.focus();

    return () => {
      document.removeEventListener('keydown', onKey);
      document.body.style.overflow = previous;
      opener?.focus?.();
    };
  }, [onClose]);

  return createPortal(
    <div
      className="fixed inset-0 z-[60] flex items-center justify-center p-4 sm:p-6 bg-comptia-charcoal/50 backdrop-blur-md"
      onClick={onClose}
      role="dialog"
      aria-modal="true"
      aria-label={`${domain.numberedTitle} exam objectives`}
    >
      <div
        // Stop clicks inside the card from reaching the backdrop's close.
        onClick={(e) => e.stopPropagation()}
        className="relative w-full max-w-5xl max-h-[88vh] bg-white rounded-2xl shadow-2xl flex flex-col overflow-hidden"
      >
        {/* Header */}
        <div className="flex-shrink-0 px-6 py-5 border-b-2 border-slate-100">
          <div className="flex items-start gap-4">
            <div className={`w-14 h-14 flex-shrink-0 rounded-full bg-white border-4 ${domain.ringColor} shadow-sm flex items-center justify-center`}>
              <img src={domain.icon} alt="" className="w-8 h-8" />
            </div>

            <div className="flex-1 min-w-0">
              <p className="text-[11px] font-bold text-slate-500 uppercase tracking-widest">
                Domain {domain.number} · Exam Objectives
              </p>
              <h2 className="text-xl sm:text-2xl font-black text-comptia-charcoal leading-tight mt-0.5">
                {domain.title}
              </h2>
              <div className="flex flex-wrap items-center gap-2 mt-2.5">
                <span
                  className="text-xs font-bold text-white px-3 py-1 rounded-full"
                  style={{ backgroundColor: domain.chartColor }}
                >
                  {domain.weight} of exam
                </span>
                {objectives.length > 0 && (
                  <span className="inline-flex items-center gap-1.5 text-xs font-bold text-slate-600 bg-slate-100 border border-slate-200 px-3 py-1 rounded-full">
                    <ListChecks className="w-3.5 h-3.5" />
                    {objectives.length} objectives · {termCount} terms
                  </span>
                )}
                <span className="inline-flex items-center gap-1.5 text-xs font-bold text-slate-600 bg-slate-100 border border-slate-200 px-3 py-1 rounded-full">
                  <FileQuestion className="w-3.5 h-3.5" />
                  {domain.questionCount} practice questions
                </span>
              </div>
            </div>

            <button
              ref={closeRef}
              onClick={onClose}
              aria-label="Close"
              className="flex-shrink-0 w-9 h-9 rounded-lg border-2 border-slate-200 text-slate-500 hover:text-comptia-charcoal hover:border-slate-400 flex items-center justify-center transition-colors"
            >
              <X className="w-4 h-4" />
            </button>
          </div>

        </div>

        {/* Objectives */}
        <div className="flex-1 overflow-y-auto px-6 py-5">
          {objectives.length === 0 ? (
            <div className="py-16 text-center">
              <p className="text-sm font-bold text-comptia-charcoal">
                Objectives for this domain are not in yet.
              </p>
              <p className="text-sm text-slate-600 mt-1">
                Domain {domain.number} is being added — {domain.questionCount} practice
                questions are already available.
              </p>
            </div>
          ) : (
            <div className="space-y-8">
              {objectives.map((objective) => (
                <section key={objective.id}>
                  <div className="flex items-start gap-3 mb-4">
                    <span
                      className="flex-shrink-0 px-2 py-1 rounded text-xs font-black text-white tabular-nums"
                      style={{ backgroundColor: domain.chartColor }}
                    >
                      {objective.id}
                    </span>
                    <h3 className="text-base sm:text-lg font-bold text-comptia-charcoal leading-snug">
                      {objective.title}
                    </h3>
                  </div>

                  {/* CSS columns mirror the official two/three-column layout
                      and keep each top-level group whole. */}
                  <div className="sm:columns-2 lg:columns-3 gap-8 [column-fill:_balance]">
                    {objective.topics.map((topic, i) => (
                      <div key={i} className="break-inside-avoid mb-3">
                        <TopicNode topic={topic} depth={0} accent={domain.chartColor} />
                      </div>
                    ))}
                  </div>
                </section>
              ))}
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex-shrink-0 px-6 py-4 border-t-2 border-slate-100 bg-slate-50 flex items-center justify-between gap-4 flex-wrap">
          <p className="text-xs text-slate-500">
            CompTIA Security+ SY0-701 exam objectives v5.0 · © 2023 CompTIA, Inc.
          </p>
          <Link
            to={`/lessons?section=${domain.id}`}
            className="inline-flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white text-sm font-bold px-5 py-2.5 rounded-lg transition-colors"
          >
            Practice Domain {domain.number}
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    </div>,
    document.body
  );
}

/**
 * One outline node, recursing into its children.
 *
 * Depth drives the marker and weight — a filled dot for top-level groups, a
 * dash below that, a hollow square at the deepest level — matching how the
 * official objectives document reads.
 */
function TopicNode({ topic, depth, accent }) {
  const isLeaf = typeof topic === 'string';
  const label = isLeaf ? topic : topic.label;
  const children = isLeaf ? [] : topic.children || [];

  return (
    <div className={depth > 0 ? 'mt-1' : ''}>
      <div className="flex items-start gap-2">
        <Marker depth={depth} accent={accent} />
        <span
          className={
            depth === 0
              ? 'text-sm font-bold text-comptia-charcoal leading-snug'
              : depth === 1
              ? 'text-sm text-slate-700 leading-snug'
              : depth === 2
              ? 'text-[13px] text-slate-500 leading-snug'
              : 'text-[13px] text-slate-400 leading-snug italic'
          }
        >
          {label}
        </span>
      </div>

      {children.length > 0 && (
        <div className="ml-3 pl-2 border-l border-slate-200 mt-1 space-y-0.5">
          {children.map((child, i) => (
            <TopicNode key={i} topic={child} depth={depth + 1} accent={accent} />
          ))}
        </div>
      )}
    </div>
  );
}

function Marker({ depth, accent }) {
  if (depth === 0) {
    return (
      <span
        className="flex-shrink-0 w-1.5 h-1.5 rounded-full mt-[7px]"
        style={{ backgroundColor: accent }}
      />
    );
  }
  if (depth === 1) {
    return <span className="flex-shrink-0 w-2 h-px bg-slate-400 mt-[10px]" />;
  }
  if (depth === 2) {
    return <span className="flex-shrink-0 w-1.5 h-1.5 border border-slate-400 mt-[7px]" />;
  }
  // Level four exists only once in the outline (3.1 Cloud > Network
  // infrastructure > Physical isolation > Air-gapped), but it needs a marker
  // of its own or it reads as a sibling of the level above.
  return (
    <span className="flex-shrink-0 w-1.5 h-1.5 rounded-full border border-slate-300 mt-[7px]" />
  );
}
