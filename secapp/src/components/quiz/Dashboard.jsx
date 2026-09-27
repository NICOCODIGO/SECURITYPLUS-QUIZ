import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import {
  ArrowRight,
  ChevronRight,
  FileText,
  Lock,
  TrendingDown,
  Wrench,
} from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import { getQuizHistory, getModeStats, getDomainPerformance } from '../data/quizHistoryData';
import { getQuestionPools } from '../data/questionPools';
import { getDailyRecord } from '../data/dailyQuestion';
import { statusForAccuracy, MOCK_PASS_MARK } from '@/lib/performanceStatus';
import { useAuth, isSignedIn } from '@/auth/AuthContext';
import { ACCOUNT_ONLY_MODES, authLinks, isSectionLocked, showsDailyQuestion } from './accountOnly';
import DailyQuestionCard from './DailyQuestionCard';

/**
 * Practice overview — the first thing the Practice page shows.
 *
 * Once there is history it opens on one recommended next step rather than a
 * wall of options, then lays the rest out in three clear groups: today's
 * question, the five domains, and exam-style or targeted practice. With no
 * history there is no recommendation, and the domain list leads.
 *
 * Your own numbers sit on the thing they describe, so landing back here from
 * a quiz (TakeQuiz hard-navigates to this page) shows the result next to the
 * button for the next one. First-time visitors see what each mode involves
 * instead of rows of zeros. Signed out, the account-only modes (accountOnly.js)
 * show a locked card that says so, rather than a button that leads nowhere,
 * and Question of the Day isn't offered at all.
 */
export default function Dashboard({ onSectionChange }) {
  const { status } = useAuth();
  const signedIn = isSignedIn(status);
  const dailyShown = showsDailyQuestion(status);

  // Storage only changes when a quiz finishes, and that reloads the page —
  // but auth resolves a moment after mount, so key the reads on `signedIn`.
  // A read taken before it lands is empty and would never be retried.
  const history = useMemo(() => (signedIn ? getQuizHistory() : []), [signedIn]);
  const modes = useMemo(() => getModeStats(history), [history]);
  const performance = useMemo(() => getDomainPerformance(history), [history]);
  const pools = useMemo(() => getQuestionPools(history), [history]);
  const answeredToday = useMemo(() => signedIn && getDailyRecord() !== null, [signedIn]);

  const hasHistory = history.length > 0;
  const byDomainId = new Map(
    performance.rows.filter((row) => row.domain).map((row) => [row.domain.id, row])
  );
  // What WeakestSubjectQuiz will actually drill — it uses ranked[0] too.
  const lowest = performance.ranked[0] || null;
  const mock = modes.mock;

  const next = pickNextStep({ hasHistory, mock, lowest });

  return (
    <div className="space-y-8">
      {next && <NextStep step={next} onSectionChange={onSectionChange} />}

      {/* With no other recommendation and nothing answered yet today,
          today's question is the next step. */}
      {dailyShown && <DailyQuestionCard lead={!next && !answeredToday} />}

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
        <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
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
          {isSectionLocked('weakest', status) ? (
            <LockedModeCard icon={TrendingDown} section="weakest" status={status} />
          ) : (
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
          )}
          {isSectionLocked('custom', status) ? (
            <LockedModeCard icon={Wrench} section="custom" status={status} />
          ) : (
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
          )}
        </div>
      </section>
    </div>
  );
}

/**
 * One recommendation, chosen from where the user actually is: carrying a weak
 * domain, never sat a mock, or keeping sharp.
 *
 * Null with no quiz history. A "take your first quiz" card used to sit here
 * and was removed: the domain list right below already is that choice, and
 * signed out it was the only thing the card could ever say. Signed in,
 * today's question takes the lead slot instead (see DailyQuestionCard).
 */
function pickNextStep({ hasHistory, mock, lowest }) {
  if (!hasHistory) return null;

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
          <button
            onClick={() => onSectionChange(step.section)}
            className="inline-flex items-center justify-center gap-2 rounded-lg bg-red-600 px-5 py-2.5 text-sm font-bold text-white hover:bg-red-700 transition-colors"
          >
            {step.cta}
            <ArrowRight className="h-4 w-4" />
          </button>
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

/**
 * An account-only mode, signed out: greyed, with a lock, and the reason in
 * place of the pitch. Same shape as ModeCard so the row stays aligned.
 */
function LockedModeCard({ icon, section, status }) {
  const Icon = icon;
  const mode = ACCOUNT_ONLY_MODES[section];
  // No API, so there is no account to create — say that instead.
  const unavailable = status === 'unavailable';
  const links = authLinks(section);

  return (
    <div className="flex flex-col rounded-xl border border-slate-200 bg-slate-50 p-5">
      <div className="flex items-center gap-3">
        <span className="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-lg bg-slate-200 text-slate-400">
          <Icon className="h-5 w-5" />
        </span>
        <h3 className="flex-1 font-black leading-tight text-slate-500">{mode.title}</h3>
        <Lock className="h-4 w-4 flex-shrink-0 text-slate-400" aria-hidden="true" />
      </div>
      <p className="mt-3 text-sm font-bold text-comptia-charcoal">
        {unavailable ? 'Needs an account.' : 'To access this, create an account.'}
      </p>
      <p className="mt-1 flex-1 text-sm text-slate-500">{mode.reason}</p>
      {unavailable ? (
        <p className="mt-3 text-xs font-bold text-slate-400">This build has no server, so no accounts.</p>
      ) : (
        <>
          <p className="mt-3 text-xs font-bold text-slate-500">
            Have an account?{' '}
            <Link to={links.signIn} className="text-red-600 hover:text-red-700 hover:underline">
              Sign in
            </Link>
          </p>
          <Link
            to={links.signUp}
            className="mt-4 inline-flex items-center justify-center gap-2 rounded-lg border-2 border-slate-200 bg-white px-4 py-2.5 text-sm font-bold text-comptia-charcoal transition-colors hover:border-comptia-charcoal"
          >
            Create free account
            <ArrowRight className="h-4 w-4" />
          </Link>
        </>
      )}
    </div>
  );
}
