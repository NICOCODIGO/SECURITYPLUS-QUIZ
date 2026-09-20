import React, { useCallback, useRef, useState } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { ArrowRight, ChevronDown, ListChecks } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import { getObjectives } from '../data/examObjectives';
import ExamBlueprint from './ExamBlueprint';
import DomainDetailModal from './DomainDetailModal';

/**
 * The full five-domain reference, used on the About page.
 *
 * The same weight bar as Home sits on top so the two pages read as connected,
 * but here it opens rows instead of starting quizzes. Below it, one row per
 * domain: collapsed, it shows the title, topics and weight; expanded, the
 * official objective headings, with the full three-level outline one click
 * further in the detail modal.
 *
 * Home deliberately shows only the bar, so the two pages don't repeat the
 * same section at the same depth. Its bar links here with `?domain=<id>`,
 * which opens that row on arrival — `ScrollToTop` handles the `#exam-domains`
 * part of the same link.
 */
export default function DomainBreakdown() {
  const [searchParams] = useSearchParams();
  const [openId, setOpenId] = useState(() => searchParams.get('domain'));
  const [outlineDomain, setOutlineDomain] = useState(null);
  const rowRefs = useRef({});

  const toggle = (id) => setOpenId((current) => (current === id ? null : id));

  // A bar segment only ever opens its row — closing on a second click would
  // make the bar feel like it did nothing.
  const select = (id) => {
    setOpenId(id);
    rowRefs.current[id]?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  };

  // Stable, because the modal's effect depends on it.
  const closeOutline = useCallback(() => setOutlineDomain(null), []);

  return (
    <div className="space-y-8">
      <ExamBlueprint onSelect={select} activeId={openId} showLabels={false} />

      <ul className="border-2 border-slate-200 rounded-2xl overflow-hidden divide-y-2 divide-slate-100">
        {securityDomains.map((domain) => {
          const open = openId === domain.id;
          const objectives = getObjectives(domain.id);
          const buttonId = `domain-row-${domain.id}`;
          const panelId = `domain-panel-${domain.id}`;

          return (
            <li
              key={domain.id}
              ref={(el) => {
                rowRefs.current[domain.id] = el;
              }}
              className={`relative scroll-mt-24 transition-colors ${open ? 'bg-slate-50' : 'bg-white'}`}
            >
              {/* Colour key tying the row to its bar segment. */}
              <span
                aria-hidden="true"
                className="absolute left-0 inset-y-0 w-1"
                style={{ backgroundColor: domain.chartColor }}
              />

              <h3>
                <button
                  id={buttonId}
                  type="button"
                  aria-expanded={open}
                  aria-controls={panelId}
                  onClick={() => toggle(domain.id)}
                  className="group w-full flex items-center gap-4 sm:gap-5 text-left pl-5 pr-4 sm:pl-7 sm:pr-6 py-5 hover:bg-slate-50 transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-comptia-charcoal"
                >
                  <span className={`hidden sm:flex w-12 h-12 flex-shrink-0 rounded-full bg-white border-4 ${domain.ringColor} shadow-sm items-center justify-center`}>
                    <img src={domain.icon} alt="" className="w-7 h-7" />
                  </span>

                  <span className="flex-1 min-w-0">
                    <span className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                      Domain {domain.number}
                    </span>
                    <span className="block text-base sm:text-lg font-black text-comptia-charcoal leading-snug mt-0.5">
                      {domain.title}
                    </span>
                    <span className="block text-sm text-slate-600 leading-relaxed mt-1">
                      {domain.topics}
                    </span>
                  </span>

                  <span className="flex-shrink-0 text-right">
                    <span
                      className="block text-2xl font-black tabular-nums leading-none"
                      style={{ color: domain.chartColor }}
                    >
                      {domain.weight}
                    </span>
                    <span className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mt-1">
                      of exam
                    </span>
                  </span>

                  <ChevronDown
                    className={`w-5 h-5 flex-shrink-0 text-slate-400 group-hover:text-comptia-charcoal transition-transform ${
                      open ? 'rotate-180' : ''
                    }`}
                  />
                </button>
              </h3>

              {/* grid-rows 0fr→1fr animates to the content's natural height;
                  inert keeps the collapsed links out of the tab order. */}
              <div
                id={panelId}
                role="region"
                aria-labelledby={buttonId}
                inert={!open}
                className={`grid transition-[grid-template-rows] duration-300 ease-out motion-reduce:transition-none ${
                  open ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'
                }`}
              >
                <div className="overflow-hidden">
                  {/* Left padding lines the panel up with the title column. */}
                  <div className="pl-5 pr-4 sm:pl-24 sm:pr-6 pb-6 space-y-4">
                    <p className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                      {objectives.length} exam objectives · {domain.questionCount} practice questions
                    </p>

                    <ol className="space-y-2.5">
                      {objectives.map((objective) => (
                        <li key={objective.id} className="flex items-start gap-3">
                          <span
                            className="flex-shrink-0 w-10 py-0.5 rounded text-center text-xs font-black text-white tabular-nums"
                            style={{ backgroundColor: domain.chartColor }}
                          >
                            {objective.id}
                          </span>
                          <span className="text-sm text-slate-700 leading-snug pt-0.5">
                            {objective.title}
                          </span>
                        </li>
                      ))}
                    </ol>

                    <div className="flex flex-wrap gap-3 pt-2">
                      {objectives.length > 0 && (
                        <button
                          type="button"
                          onClick={() => setOutlineDomain(domain)}
                          aria-haspopup="dialog"
                          className="inline-flex items-center gap-2 bg-white border-2 border-slate-300 hover:border-comptia-charcoal text-comptia-charcoal text-sm font-bold px-4 py-2 rounded-lg transition-colors"
                        >
                          <ListChecks className="w-4 h-4" />
                          Full objective outline
                        </button>
                      )}
                      <Link
                        to={`/lessons?section=${domain.id}`}
                        className="inline-flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white text-sm font-bold px-4 py-2 rounded-lg transition-colors"
                      >
                        Practice Domain {domain.number}
                        <ArrowRight className="w-4 h-4" />
                      </Link>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          );
        })}
      </ul>

      {outlineDomain && <DomainDetailModal domain={outlineDomain} onClose={closeOutline} />}
    </div>
  );
}
