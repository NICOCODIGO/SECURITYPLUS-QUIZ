import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import {
  ArrowRight,
  BookOpen,
  CalendarDays,
  ChevronRight,
  FileText,
  TrendingDown,
  Wrench,
} from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import { getQuizHistory, getModeStats, getDomainPerformance } from '../data/quizHistoryData';
import { getQuestionPools } from '../data/questionPools';
import { getDailyRecord } from '../data/dailyQuestion';
import { statusForAccuracy, MOCK_PASS_MARK } from '@/lib/performanceStatus';
import DailyQuestionStrip from './DailyQuestionStrip';

/**
 * Practice overview — the first thing the Practice page shows.
 *
 * It opens on one recommended next step rather than a wall of options, then
 * lays the rest out in three clear groups: today's question, the five
 * domains, and exam-style or targeted practice.
 *
 * Your own numbers sit on the thing they describe, so landing back here from
 * a quiz (TakeQuiz hard-navigates to this page) shows the result next to the
 * button for the next one. First-time visitors see what each mode involves
 * instead of rows of zeros.
 */
export default function Dashboard({ onSectionChange }) {
  // Storage only changes when a quiz finishes, and that reloads the page.
  const history = useMemo(() => getQuizHistory(), []);
  const modes = useMemo(() => getModeStats(history), [history]);
  const performance = useMemo(() => getDomainPerformance(history), [history]);
  const pools = useMemo(() => getQuestionPools(history), [history]);
  const answeredToday = useMemo(() => getDailyRecord() !== null, []);

  const hasHistory = history.length > 0;
  const byDomainId = new Map(
    performance.rows.filter((row) => row.domain).map((row) => [row.domain.id, row])
  );
  // What WeakestSubjectQuiz will actually drill — it uses ranked[0] too.
  const lowest = performance.ranked[0] || null;
  const mock = modes.mock;

  const next = pickNextStep({ hasHistory, answeredToday, mock, lowest });

  return (
    <div className="space-y-8">
      <NextStep step={next} onSectionChange={onSectionChange} />

      <DailyQuestionStrip />

      <section className="space-y-3">
        <SectionHeading
          title="Practice by domain"
          hint="Choose 10 to 50 questions. Every answer is explained as you go."
        />
        <div className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm divide-y divide-slate-100">
          {securityDomains.map((domain) => (
            <DomainRow
              key={domain.id}
              domain={domain}
              row={byDomainId.get(domain.id)}
              tag={
                performance.strongest?.domain?.id === domain.id
                  ? 'strongest'
                  : performance.weakest?.domain?.id === domain.id
                  ? 'weakest'
                  : null
              }
              onClick={() => onSectionChange(domain.id)}
            />
          ))}
        </div>
      </section>

      <section className="space-y-3">
        <SectionHeading
          title="Exam & targeted practice"
          hint="Test yourself under exam conditions, or aim at what you keep missing."
        />
        <div className="grid gap-4 md:grid-cols-3">
          <ModeCard
            featured
            icon={FileText}
            title="Mock Exam"
            description="90 questions against a 90-minute clock. No answers are shown until you submit."
            facts={
              mock.count
                ? `Best ${mock.bestScore}% · last ${mock.lastScore}% · ${mock.passes} of ${mock.count} passed`
                : `Pass mark ${MOCK_PASS_MARK}% (750/900) · not attempted yet`
            }
            cta={mock.count ? 'Take another' : 'Start mock exam'}
            onClick={() => onSectionChange('mock')}
          />
          <ModeCard
            icon={TrendingDown}
            title="Weakest Subject"
            description="20 questions from whichever domain you currently score lowest in."
            facts={
              lowest
                ? `Next up: ${lowest.title} (${lowest.accuracy}%)`
                : 'Unlocks after your first quiz'
            }
            cta="Drill it"
            onClick={() => onSectionChange('weakest')}
          />
          <ModeCard
            icon={Wrench}
            title="Build Your Own"
            description="Mix never-seen, missed and flagged questions, filtered by domain and difficulty."
            facts={
              modes.custom.count
                ? `${modes.custom.count} built · ${pools.flagged.length} flagged · ${pools.incorrect.length} to retry`
                : `${pools.new.length} questions you haven't seen yet`
            }
            cta="Build a quiz"
            onClick={() => onSectionChange('custom')}
          />
        </div>
      </section>
    </div>
  );
}

/**
 * One recommendation, chosen from where the user actually is: brand new,
 * carrying a weak domain, never sat a mock, or keeping sharp.
 */
function pickNextStep({ hasHistory, answeredToday, mock, lowest }) {
  if (!hasHistory) {
    return answeredToday
      ? {
          icon: BookOpen,
          eyebrow: 'Start here',
          title: 'Take your first quiz',
          body: 'A short quiz on 1.0 General Security Concepts, with an explanation after every answer.',
          cta: 'Start Domain 1.0',
          section: 'domain1',
          alt: { label: 'Or build your own quiz', section: 'custom' },
        }
      : {
          icon: CalendarDays,
          eyebrow: 'Start here',
          title: "Warm up with today's question",
          body: 'One question, about a minute. Then try a short quiz on any domain below.',
          cta: "Answer today's question",
          href: '/daily',
          alt: { label: 'Or jump into Domain 1.0', section: 'domain1' },
        };
  }

  if (lowest && lowest.accuracy < 80) {
    return {
      icon: TrendingDown,
      eyebrow: 'Recommended next',
      title: `Close your biggest gap: ${lowest.title}`,
      body: `You're at ${lowest.accuracy}% here. A focused 20-question drill is the quickest way to raise it.`,
      cta: 'Drill weakest subject',
      section: 'weakest',
    };
  }

  if (mock.count === 0) {
    return {
      icon: FileText,
      eyebrow: 'Recommended next',
      title: 'See how exam-ready you are',
      body: `A full mock exam: 90 questions in 90 minutes, scored against the ${MOCK_PASS_MARK}% pass mark.`,
      cta: 'Take a mock exam',
      section: 'mock',
    };
  }

  return {
    icon: FileText,
    eyebrow: 'Keep your edge',
    title:
      mock.lastScore >= MOCK_PASS_MARK
        ? 'You passed your last mock exam. Keep it up.'
        : `Last mock: ${mock.lastScore}%. Aim for ${MOCK_PASS_MARK}%.`,
    body: 'Another full mock exam shows whether your practice is paying off.',
    cta: 'Take another mock',
    section: 'mock',
    alt: { label: 'Or build a quiz from your mistakes', section: 'custom' },
  };
}

function NextStep({ step, onSectionChange }) {
  const Icon = step.icon;
  // A step points at a section of this page, or at a page of its own (the
  // daily question), so the button is a button or a link to match.
  const cta = step.href ? { as: Link, to: step.href } : { as: 'button', onClick: () => onSectionChange(step.section) };
  const Cta = cta.as;
  return (
    <div className="relative overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
      <span className="absolute inset-y-0 left-0 w-1 bg-red-600" aria-hidden="true" />
      <div className="flex flex-col sm:flex-row sm:items-center gap-4 p-5 pl-6">
        <span className="flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-xl bg-red-50 text-red-600">
          <Icon className="h-6 w-6" />
        </span>
        <div className="min-w-0 flex-1">
          <p className="text-[11px] font-bold uppercase tracking-wider text-red-600">{step.eyebrow}</p>
          <h2 className="text-lg font-black leading-snug text-comptia-charcoal">{step.title}</h2>
          <p className="text-sm text-slate-600 mt-0.5">{step.body}</p>
        </div>
        <div className="flex flex-col items-stretch sm:items-end gap-1.5 flex-shrink-0">
          <Cta
            {...(step.href ? { to: step.href } : { onClick: cta.onClick })}
            className="inline-flex items-center justify-center gap-2 rounded-lg bg-red-600 px-5 py-2.5 text-sm font-bold text-white hover:bg-red-700 transition-colors"
          >
            {step.cta}
            <ArrowRight className="h-4 w-4" />
          </Cta>
          {step.alt && (
            <button
              onClick={() => onSectionChange(step.alt.section)}
              className="text-xs font-bold text-slate-500 hover:text-comptia-charcoal transition-colors"
            >
              {step.alt.label}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

function SectionHeading({ title, hint }) {
  return (
    <div className="flex flex-col sm:flex-row sm:items-baseline sm:justify-between gap-x-4 gap-y-0.5">
      <h2 className="text-lg font-black text-comptia-charcoal">{title}</h2>
      <p className="text-xs text-slate-500">{hint}</p>
    </div>
  );
}

function DomainRow({ domain, row, tag, onClick }) {
  const status = row ? statusForAccuracy(row.accuracy) : null;

  return (
    <button onClick={onClick} className="group w-full flex items-center gap-4 px-4 py-3.5 text-left hover:bg-slate-50 transition-colors">
      <span className={`w-10 h-10 flex-shrink-0 rounded-full bg-white border-[3px] ${domain.ringColor} flex items-center justify-center`}>
        <img src={domain.icon} alt="" className="w-5 h-5" />
      </span>

      <span className="min-w-0 flex-1">
        <span className="block text-[11px] font-bold uppercase tracking-wider text-slate-500">
          Domain {domain.number} · {domain.weight} of exam
        </span>
        <span className="flex items-center gap-2 min-w-0">
          <span className="font-bold text-comptia-charcoal truncate">{domain.title}</span>
          {tag && (
            <span
              className={`flex-shrink-0 rounded px-1.5 py-0.5 text-[10px] font-black uppercase tracking-wider ${
                tag === 'strongest' ? 'bg-emerald-100 text-emerald-800' : 'bg-red-100 text-red-800'
              }`}
            >
              {tag}
            </span>
          )}
        </span>
      </span>

      <span className="hidden md:block w-24 flex-shrink-0 text-right text-xs text-slate-500 tabular-nums">
        {domain.questionCount} questions
      </span>

      <span className="w-24 sm:w-36 flex-shrink-0">
        {row ? (
          <>
            <span className="flex items-baseline justify-between gap-2 text-xs">
              <span className="hidden sm:inline font-bold text-slate-600">{status.label}</span>
              <span className={`font-black tabular-nums ${status.text}`}>{row.accuracy}%</span>
            </span>
            <span className="mt-1 block h-1.5 overflow-hidden rounded-full bg-slate-100">
              <span
                className="block h-full rounded-full"
                style={{ width: `${Math.max(row.accuracy, 2)}%`, backgroundColor: status.color }}
              />
            </span>
          </>
        ) : (
          <span className="block text-right sm:text-left text-xs text-slate-400">Not started</span>
        )}
      </span>

      <ChevronRight className="w-4 h-4 flex-shrink-0 text-slate-300 group-hover:text-red-600 transition-colors" />
    </button>
  );
}

function ModeCard({ icon, title, description, facts, cta, onClick, featured = false }) {
  const Icon = icon;
  return (
    <div
      className={`flex flex-col rounded-xl border bg-white p-5 shadow-sm ${
        featured ? 'border-red-200' : 'border-slate-200'
      }`}
    >
      <div className="flex items-center gap-3">
        <span
          className={`flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-lg ${
            featured ? 'bg-red-600 text-white' : 'bg-slate-100 text-comptia-charcoal'
          }`}
        >
          <Icon className="h-5 w-5" />
        </span>
        <h3 className="font-black leading-tight text-comptia-charcoal">{title}</h3>
      </div>
      <p className="mt-3 flex-1 text-sm text-slate-600">{description}</p>
      <p className="mt-3 text-xs font-bold text-slate-500">{facts}</p>
      <button
        onClick={onClick}
        className={`mt-4 inline-flex items-center justify-center gap-2 rounded-lg px-4 py-2.5 text-sm font-bold transition-colors ${
          featured
            ? 'bg-red-600 text-white hover:bg-red-700'
            : 'border-2 border-slate-200 text-comptia-charcoal hover:border-comptia-charcoal'
        }`}
      >
        {cta}
        <ArrowRight className="h-4 w-4" />
      </button>
    </div>
  );
}
