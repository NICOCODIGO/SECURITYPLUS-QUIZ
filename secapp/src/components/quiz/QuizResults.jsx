import React, { useMemo, useState } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  ArrowLeft,
  RotateCcw,
  Clock,
  CheckCircle2,
  XCircle,
  Flag,
  Target,
  FileText,
  Wrench,
  TrendingDown,
} from 'lucide-react';
import { getDomainById, getDomainByQuizLabel } from '../data/securityDomains';
import { statusForAccuracy } from '@/lib/performanceStatus';

/**
 * Results screen for a finished quiz.
 *
 * Every question is laid out in full — text, all four choices marked up, and
 * the explanation — rather than hidden behind an accordion. Reviewing what
 * you got wrong is the whole point of finishing a quiz, so it should not cost
 * a click per question. Filters narrow the list instead, defaulting to the
 * questions you missed when there are any.
 */

const PASS_MARK = 83; // 750/900 on the real exam

const TYPE_META = {
  mock: { icon: FileText, label: 'Exam Complete', noun: 'Exam' },
  custom: { icon: Wrench, label: 'Quiz Complete', noun: 'Quiz' },
  weakest: { icon: TrendingDown, label: 'Practice Complete', noun: 'Practice' },
  domain: { icon: Target, label: 'Quiz Complete', noun: 'Quiz' },
};

export default function QuizResults({
  questions,
  selectedAnswers,
  quizType,
  domainId,
  domainTitle,
  score,
  completionTime,
  formatTime,
  isQuestionFlagged,
  onToggleFlag,
  onRetake,
  onExit,
}) {
  const meta = TYPE_META[quizType] || TYPE_META.domain;
  const TypeIcon = meta.icon;
  const domain = domainId ? getDomainById(domainId) : null;

  const rows = useMemo(
    () =>
      questions.map((question, index) => ({
        question,
        index,
        answer: selectedAnswers[index],
        correct: selectedAnswers[index] === question.correctAnswer,
        flagged: isQuestionFlagged(question),
      })),
    [questions, selectedAnswers, isQuestionFlagged]
  );

  const correctCount = rows.filter((r) => r.correct).length;
  const wrongCount = rows.length - correctCount;
  const flaggedCount = rows.filter((r) => r.flagged).length;

  // Land on the questions that need attention; fall back to everything on a
  // clean sweep so the screen is never empty.
  const [filter, setFilter] = useState(wrongCount > 0 ? 'incorrect' : 'all');

  const filters = [
    { id: 'all', label: 'All', count: rows.length },
    { id: 'incorrect', label: 'Incorrect', count: wrongCount },
    { id: 'correct', label: 'Correct', count: correctCount },
    { id: 'flagged', label: 'Flagged', count: flaggedCount },
  ].filter((f) => f.id === 'all' || f.count > 0);

  const visible = rows.filter((row) => {
    if (filter === 'incorrect') return !row.correct;
    if (filter === 'correct') return row.correct;
    if (filter === 'flagged') return row.flagged;
    return true;
  });

  const status = statusForAccuracy(score);
  const passed = quizType === 'mock' ? score >= PASS_MARK : null;

  // Only a mock spans domains, so only a mock needs the per-domain split.
  const breakdown = useMemo(() => {
    if (quizType !== 'mock') return [];
    const totals = {};
    rows.forEach(({ question, correct }) => {
      const label = question.domain;
      if (!totals[label]) totals[label] = { correct: 0, total: 0 };
      totals[label].total += 1;
      if (correct) totals[label].correct += 1;
    });
    return Object.entries(totals)
      .map(([label, t]) => ({
        label,
        domain: getDomainByQuizLabel(label),
        ...t,
        accuracy: Math.round((t.correct / t.total) * 100),
      }))
      .sort((a, b) => a.accuracy - b.accuracy);
  }, [rows, quizType]);

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <Button variant="outline" onClick={onExit} className="border-2 px-4 py-2">
        <ArrowLeft className="w-4 h-4 mr-2" />
        Back to Quizzes
      </Button>

      {/* ── Score ─────────────────────────────────────────── */}
      <Card className="border-2 border-slate-200 shadow-lg overflow-hidden">
        <div className="bg-comptia-charcoal px-6 py-6">
          <div className="flex items-center gap-4">
            {domain ? (
              <div className={`w-16 h-16 flex-shrink-0 rounded-full bg-white border-4 ${domain.ringColor} shadow-lg flex items-center justify-center`}>
                <img src={domain.icon} alt="" className="w-9 h-9" />
              </div>
            ) : (
              <div className="w-16 h-16 flex-shrink-0 rounded-full bg-red-600 flex items-center justify-center shadow-lg">
                <TypeIcon className="w-8 h-8 text-white" />
              </div>
            )}
            <div className="min-w-0">
              <p className="text-xs font-bold text-slate-400 uppercase tracking-widest">
                {meta.label}
              </p>
              <h1 className="text-2xl font-black text-white leading-tight mt-0.5">
                {domain ? domain.numberedTitle : domainTitle || 'Practice Quiz'}
              </h1>
            </div>
          </div>
        </div>

        <CardContent className="p-6 space-y-5">
          <div className="flex items-end justify-between gap-6 flex-wrap">
            <div>
              <p className="text-6xl font-black leading-none" style={{ color: status.color }}>
                {score}%
              </p>
              <p className="text-sm text-slate-600 mt-2">
                {correctCount} of {questions.length} correct
              </p>
            </div>

            {passed !== null && (
              <div
                className={`px-5 py-3 rounded-xl border-2 ${
                  passed
                    ? 'bg-emerald-50 border-emerald-300'
                    : 'bg-red-50 border-red-300'
                }`}
              >
                <p className={`text-lg font-black ${passed ? 'text-emerald-800' : 'text-red-800'}`}>
                  {passed ? 'PASS' : 'BELOW PASS MARK'}
                </p>
                <p className="text-xs text-slate-600">Real exam needs {PASS_MARK}% (750/900)</p>
              </div>
            )}
          </div>

          {/* Correct vs incorrect at a glance, with a 2px surface gap between
              the two fills rather than a border around them. */}
          <div className="flex h-3 rounded-full overflow-hidden bg-slate-100 gap-0.5">
            {correctCount > 0 && (
              <div
                className="bg-emerald-600 h-full"
                style={{ width: `${(correctCount / questions.length) * 100}%` }}
              />
            )}
            {wrongCount > 0 && (
              <div
                className="bg-red-600 h-full"
                style={{ width: `${(wrongCount / questions.length) * 100}%` }}
              />
            )}
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
            <Stat icon={CheckCircle2} label="Correct" value={correctCount} tone="text-emerald-700" />
            <Stat icon={XCircle} label="Incorrect" value={wrongCount} tone="text-red-700" />
            <Stat
              icon={Clock}
              label="Time"
              value={completionTime ? formatTime(completionTime) : '—'}
              tone="text-comptia-charcoal"
            />
            <Stat icon={Flag} label="Flagged" value={flaggedCount} tone="text-amber-700" />
          </div>

          <div className="flex gap-3 flex-wrap">
            <Button
              onClick={onRetake}
              className="flex-1 min-w-[12rem] bg-red-600 hover:bg-red-700 text-white h-12 font-bold rounded-xl"
            >
              <RotateCcw className="w-4 h-4 mr-2" />
              Retake {meta.noun}
            </Button>
            <Button
              variant="outline"
              onClick={onExit}
              className="flex-1 min-w-[12rem] border-2 h-12 font-bold rounded-xl"
            >
              Back to Quizzes
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* ── Domain breakdown (mock only) ──────────────────── */}
      {breakdown.length > 0 && (
        <Card className="border-2 border-slate-200 shadow-lg">
          <CardContent className="p-6 space-y-4">
            <div>
              <h2 className="text-xl font-black text-comptia-charcoal">Domain Breakdown</h2>
              <p className="text-sm text-slate-600">Weakest first — where to spend your next session.</p>
            </div>
            <div className="space-y-3">
              {breakdown.map((row) => {
                const rowStatus = statusForAccuracy(row.accuracy);
                return (
                  <div key={row.label} className="space-y-1.5">
                    <div className="flex items-center justify-between gap-3">
                      <div className="flex items-center gap-2.5 min-w-0">
                        {row.domain && (
                          <span className={`w-7 h-7 flex-shrink-0 rounded-full bg-white border-2 ${row.domain.ringColor} flex items-center justify-center`}>
                            <img src={row.domain.icon} alt="" className="w-4 h-4" />
                          </span>
                        )}
                        <span className="text-sm font-bold text-comptia-charcoal truncate">
                          {row.domain ? row.domain.numberedTitle : row.label}
                        </span>
                      </div>
                      <span className="text-sm font-black tabular-nums flex-shrink-0" style={{ color: rowStatus.color }}>
                        {row.correct}/{row.total} · {row.accuracy}%
                      </span>
                    </div>
                    <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                      <div
                        className="h-full rounded-full"
                        style={{ width: `${Math.max(row.accuracy, 1)}%`, backgroundColor: rowStatus.color }}
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>
      )}

      {/* ── Review ────────────────────────────────────────── */}
      <Card className="border-2 border-slate-200 shadow-lg">
        <CardContent className="p-6 space-y-5">
          <div className="flex items-start justify-between gap-4 flex-wrap">
            <div>
              <h2 className="text-xl font-black text-comptia-charcoal">Review Answers</h2>
              <p className="text-sm text-slate-600">
                Every question with the correct answer and why.
              </p>
            </div>
          </div>

          <div className="flex flex-wrap gap-2">
            {filters.map((f) => (
              <button
                key={f.id}
                onClick={() => setFilter(f.id)}
                aria-pressed={filter === f.id}
                className={`px-4 py-2 rounded-xl border-2 text-sm font-bold transition-all ${
                  filter === f.id
                    ? 'border-red-600 bg-red-600 text-white'
                    : 'border-slate-200 bg-white text-slate-700 hover:border-slate-400'
                }`}
              >
                {f.label}
                <span className={`ml-2 text-xs ${filter === f.id ? 'text-white/70' : 'text-slate-400'}`}>
                  {f.count}
                </span>
              </button>
            ))}
          </div>

          <div className="space-y-4">
            {visible.map((row) => (
              <ReviewCard key={row.index} row={row} total={questions.length} onToggleFlag={onToggleFlag} />
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

function Stat({ icon, label, value, tone }) {
  const Icon = icon;
  return (
    <div className="p-3 bg-slate-50 rounded-xl border border-slate-200">
      <div className="flex items-center gap-1.5">
        <Icon className={`w-3.5 h-3.5 ${tone}`} />
        <p className="text-[11px] font-bold text-slate-500 uppercase tracking-wide">{label}</p>
      </div>
      <p className={`text-xl font-black mt-0.5 ${tone}`}>{value}</p>
    </div>
  );
}

function ReviewCard({ row, total, onToggleFlag }) {
  const { question, index, answer, correct, flagged } = row;
  const unanswered = answer === undefined;

  return (
    <div
      className={`rounded-xl border-2 overflow-hidden ${
        correct ? 'border-emerald-200' : 'border-red-200'
      }`}
    >
      <div
        className={`flex items-center justify-between gap-3 px-4 py-3 ${
          correct ? 'bg-emerald-50' : 'bg-red-50'
        }`}
      >
        <div className="flex items-center gap-2.5 min-w-0">
          {correct ? (
            <CheckCircle2 className="w-5 h-5 text-emerald-700 flex-shrink-0" />
          ) : (
            <XCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
          )}
          <span className="text-sm font-bold text-comptia-charcoal">
            Question {index + 1}
            <span className="font-medium text-slate-500"> of {total}</span>
          </span>
          <span className={`text-xs font-black uppercase tracking-wide ${correct ? 'text-emerald-700' : 'text-red-700'}`}>
            {correct ? 'Correct' : unanswered ? 'Skipped' : 'Incorrect'}
          </span>
        </div>

        <button
          onClick={() => onToggleFlag(question)}
          aria-pressed={flagged}
          title={flagged ? 'Remove flag' : 'Flag for review'}
          className={`flex-shrink-0 w-9 h-9 rounded-lg border-2 flex items-center justify-center transition-all ${
            flagged
              ? 'border-amber-500 bg-amber-100 text-amber-700'
              : 'border-slate-300 bg-white text-slate-400 hover:text-slate-700 hover:border-slate-400'
          }`}
        >
          <Flag className={`w-4 h-4 ${flagged ? 'fill-amber-500' : ''}`} />
        </button>
      </div>

      <div className="p-4 space-y-3 bg-white">
        <p className="font-bold text-comptia-charcoal leading-snug">{question.question}</p>

        <div className="space-y-2">
          {question.choices.map((choice, i) => {
            const isRight = i === question.correctAnswer;
            const isYours = i === answer;

            let tone = 'border-slate-200 bg-white text-slate-600';
            if (isRight) tone = 'border-emerald-300 bg-emerald-50 text-slate-800';
            else if (isYours) tone = 'border-red-300 bg-red-50 text-slate-800';

            return (
              <div
                key={i}
                className={`flex items-center gap-3 p-3 rounded-lg border-2 ${tone}`}
              >
                <span className="w-6 h-6 flex-shrink-0 rounded-full border-2 border-current opacity-40 flex items-center justify-center text-[11px] font-bold">
                  {String.fromCharCode(65 + i)}
                </span>
                <span className="flex-1 text-sm">{choice}</span>
                {isRight && (
                  <span className="text-xs font-bold text-emerald-800 flex-shrink-0">
                    Correct answer
                  </span>
                )}
                {isYours && !isRight && (
                  <span className="text-xs font-bold text-red-800 flex-shrink-0">Your answer</span>
                )}
              </div>
            );
          })}
        </div>

        <div className="p-3 bg-slate-50 border-2 border-slate-100 rounded-lg">
          <p className="text-[11px] font-bold text-slate-500 uppercase tracking-wide mb-1">
            Explanation
          </p>
          <p className="text-sm text-slate-700 leading-relaxed">{question.explanation}</p>
        </div>
      </div>
    </div>
  );
}
