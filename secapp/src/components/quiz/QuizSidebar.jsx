// Section navigation for the Practice page (/lessons). Kept in its own file
// so the page itself stays about layout and content.
import React from 'react';
import { FileText, LayoutDashboard, Lock, TrendingDown, Wrench } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import { statusForAccuracy } from '@/lib/performanceStatus';
import { useAuth } from '@/auth/AuthContext';
import { isSectionLocked } from './accountOnly';

// Question of the Day isn't here: it has its own screen at /daily, opened
// from the strip on the Overview, so a tab for it would be a second door to
// the same one question.
const START = [{ id: 'dashboard', label: 'Overview', icon: LayoutDashboard }];

const TARGETED = [
  { id: 'mock', label: 'Mock Exam', icon: FileText },
  { id: 'weakest', label: 'Weakest Subject', icon: TrendingDown },
  { id: 'custom', label: 'Build Your Own', icon: Wrench },
];

/**
 * Grouped into what you'd do first, the five domains, and exam-style or
 * targeted practice — the old flat list mixed all three.
 *
 * Below lg it collapses to one scrollable row of pills, so a phone opens on
 * the content instead of a ten-item menu. `accuracyByDomain` (domain id →
 * percent) adds your score beside each domain once you have one.
 *
 * Account-only modes stay listed while signed out, with a lock: hiding them
 * would hide that they exist, and their section says what they need.
 */
export default function QuizSidebar({ selectedSection, onSectionChange, accuracyByDomain = new Map() }) {
  const { status } = useAuth();
  const locked = (id) => isSectionLocked(id, status);

  const pills = [
    ...START,
    ...securityDomains.map((d) => ({ id: d.id, label: `Domain ${d.number}` })),
    ...TARGETED,
  ];

  return (
    <>
      <nav aria-label="Practice sections" className="lg:hidden -mx-4 px-4 overflow-x-auto">
        <div className="flex w-max gap-2 pb-1">
          {pills.map((item) => {
            const active = selectedSection === item.id;
            return (
              <button
                key={item.id}
                onClick={() => onSectionChange(item.id)}
                aria-current={active ? 'page' : undefined}
                // `relative` contains LockMark's sr-only label, which is
                // absolutely positioned and otherwise escapes this scroller
                // and widens the whole page on a phone.
                className={`relative inline-flex items-center gap-1.5 whitespace-nowrap rounded-full border px-3.5 py-1.5 text-sm font-bold transition-colors ${
                  active
                    ? 'border-comptia-charcoal bg-comptia-charcoal text-white'
                    : locked(item.id)
                    ? 'border-slate-200 bg-slate-50 text-slate-400 hover:border-slate-400'
                    : 'border-slate-200 bg-white text-slate-600 hover:border-slate-400'
                }`}
              >
                {locked(item.id) && <LockMark />}
                {item.label}
              </button>
            );
          })}
        </div>
      </nav>

      {/* Sticks below the nav. Capped to the space under it, and scrolls
          itself, so on a short laptop screen the last items can't end up out
          of reach below the fold. */}
      <nav
        aria-label="Practice sections"
        className="hidden lg:block sticky top-24 max-h-[calc(100vh-7rem)] overflow-y-auto rounded-xl border border-slate-200 bg-white p-2 shadow-sm"
      >
        <Group label="Start">
          {START.map((item) => (
            <Item key={item.id} item={item} active={selectedSection === item.id} onSelect={onSectionChange} />
          ))}
        </Group>

        <Group label="Domains">
          {securityDomains.map((domain) => (
            <DomainItem
              key={domain.id}
              domain={domain}
              accuracy={accuracyByDomain.get(domain.id)}
              active={selectedSection === domain.id}
              onSelect={onSectionChange}
            />
          ))}
        </Group>

        <Group label="Exam & targeted">
          {TARGETED.map((item) => (
            <Item
              key={item.id}
              item={item}
              active={selectedSection === item.id}
              locked={locked(item.id)}
              onSelect={onSectionChange}
            />
          ))}
        </Group>
      </nav>
    </>
  );
}

function Group({ label, children }) {
  return (
    <div className="border-t border-slate-100 pt-1 mt-1 first:border-0 first:mt-0 first:pt-0">
      <p className="px-3 pt-2 pb-1 text-[11px] font-bold uppercase tracking-wider text-slate-400">{label}</p>
      <div className="space-y-0.5">{children}</div>
    </div>
  );
}

// Active rows get a tint and a red rule on the left rather than a solid red
// fill, which shouted louder than anything in the content beside it.
const rowClass = (active) =>
  `relative w-full flex items-center gap-3 rounded-lg px-3 py-2 text-left transition-colors ${
    active
      ? "bg-red-50 text-comptia-charcoal before:absolute before:left-0 before:inset-y-1.5 before:w-1 before:rounded-full before:bg-red-600 before:content-['']"
      : 'text-slate-600 hover:bg-slate-50 hover:text-comptia-charcoal'
  }`;

function Item({ item, active, locked = false, onSelect }) {
  const Icon = item.icon;
  return (
    <button onClick={() => onSelect(item.id)} aria-current={active ? 'page' : undefined} className={rowClass(active)}>
      <Icon className={`w-4 h-4 flex-shrink-0 ${active ? 'text-red-600' : locked ? 'text-slate-300' : ''}`} />
      <span className={`flex-1 text-sm ${active ? 'font-bold' : 'font-medium'} ${locked && !active ? 'text-slate-400' : ''}`}>
        {item.label}
      </span>
      {locked && <LockMark />}
    </button>
  );
}

function LockMark() {
  return (
    <>
      <Lock className="w-3.5 h-3.5 flex-shrink-0 text-slate-400" aria-hidden="true" />
      <span className="sr-only">(needs an account)</span>
    </>
  );
}

function DomainItem({ domain, accuracy, active, onSelect }) {
  const status = accuracy !== undefined ? statusForAccuracy(accuracy) : null;
  return (
    <button
      onClick={() => onSelect(domain.id)}
      aria-current={active ? 'page' : undefined}
      title={domain.numberedTitle}
      className={rowClass(active)}
    >
      <span className={`w-7 h-7 flex-shrink-0 rounded-full bg-white border-2 ${domain.ringColor} flex items-center justify-center`}>
        <img src={domain.icon} alt="" className="w-4 h-4" />
      </span>
      <span className="min-w-0 flex-1">
        <span className={`block text-sm truncate ${active ? 'font-bold' : 'font-medium'}`}>{domain.title}</span>
        <span className="block text-[11px] text-slate-500">
          {domain.number} · {domain.questionCount} questions
        </span>
      </span>
      {status && (
        <span className="text-xs font-black tabular-nums flex-shrink-0" style={{ color: status.color }}>
          {accuracy}%
        </span>
      )}
    </button>
  );
}
