import React, { useState } from 'react';
import { ChevronDown, ChevronUp, Flag, LayoutGrid } from 'lucide-react';

/**
 * Compact progress bar with an expandable jump-to grid.
 *
 * A 90-question mock previously rendered 90 large buttons permanently, which
 * filled the bottom half of the screen and pushed the question itself out of
 * view. The bar carries what you need while answering — how far along you
 * are, how many are flagged — and the grid is one click away.
 *
 * Short quizzes open expanded, because at 10-20 questions the grid is small
 * enough to be worth showing outright.
 */

const EXPANDED_BY_DEFAULT_UP_TO = 20;

export default function QuestionNavigator({
  questions,
  currentIndex,
  selectedAnswers,
  isQuestionFlagged,
  onJump,
  // False during a mock exam, where nothing may hint at correctness until the
  // whole paper is submitted.
  showCorrectness = true,
}) {
  const [open, setOpen] = useState(questions.length <= EXPANDED_BY_DEFAULT_UP_TO);

  const answered = Object.keys(selectedAnswers).length;
  const flaggedCount = questions.filter((q) => isQuestionFlagged(q)).length;
  const percent = questions.length > 0 ? Math.round((answered / questions.length) * 100) : 0;

  // A practice quiz already reveals correctness the moment an answer is
  // picked, so the running tally tells the user nothing they cannot see.
  const correctCount = showCorrectness
    ? questions.filter(
        (q, i) => selectedAnswers[i] !== undefined && selectedAnswers[i] === q.correctAnswer
      ).length
    : 0;
  const wrongCount = showCorrectness ? answered - correctCount : 0;

  return (
    <div className="bg-white rounded-xl border-2 border-slate-200 shadow-sm">
      <div className="px-5 py-4 space-y-3">
        <div className="flex items-center justify-between gap-4 flex-wrap">
          <div className="flex items-center gap-x-3 gap-y-1 flex-wrap text-sm">
            <span className="font-bold text-comptia-charcoal tabular-nums">
              {answered} of {questions.length} answered
            </span>
            {(correctCount > 0 || wrongCount > 0) && (
              <span className="text-slate-300" aria-hidden="true">·</span>
            )}
            {correctCount > 0 && (
              <span className="font-bold text-emerald-700 tabular-nums">{correctCount} correct</span>
            )}
            {wrongCount > 0 && (
              <span className="font-bold text-red-700 tabular-nums">{wrongCount} wrong</span>
            )}
            {flaggedCount > 0 && (
              <span className="inline-flex items-center gap-1.5 text-amber-700 font-bold">
                <Flag className="w-3.5 h-3.5 fill-amber-500" />
                {flaggedCount} flagged
              </span>
            )}
          </div>

          <button
            onClick={() => setOpen(!open)}
            aria-expanded={open}
            className="inline-flex items-center gap-2 text-sm font-bold text-slate-600 hover:text-comptia-charcoal transition-colors rounded"
          >
            <LayoutGrid className="w-4 h-4" />
            Jump to question
            {open ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
          </button>
        </div>

        <div className="h-1.5 bg-slate-100 rounded-full overflow-hidden">
          {/* Charcoal, not brand red — red means "answered incorrectly" in the
              grid below, and a red progress bar reads as failure. */}
          <div
            className="h-full bg-comptia-charcoal rounded-full transition-all duration-300"
            style={{ width: `${percent}%` }}
          />
        </div>
      </div>

      {open && (
        <div className="border-t-2 border-slate-100">
          {/* Fixed-size cells that wrap and pack from the left. An auto-fill
              grid stretched 10 buttons across 20 tracks and left the row
              looking half empty. The padding also gives the current-question
              ring room, so the scroll container never clips it. */}
          <div className="flex flex-wrap gap-2 p-4 max-h-48 overflow-y-auto">
            {questions.map((question, index) => {
              const isActive = index === currentIndex;
              const isAnswered = selectedAnswers[index] !== undefined;
              const isCorrect = isAnswered && selectedAnswers[index] === question.correctAnswer;
              const flagged = isQuestionFlagged(question);

              // The fill always carries answer state. The current question is
              // a ring layered on top, so it never masks that state.
              let tone = 'bg-white text-slate-500 border-slate-200 hover:border-slate-400 hover:text-slate-800';
              if (isAnswered && !showCorrectness) {
                tone = 'bg-slate-700 text-white border-slate-700'; // mock: answered is all we may say
              } else if (isAnswered && isCorrect) {
                tone = 'bg-emerald-600 text-white border-emerald-600';
              } else if (isAnswered) {
                tone = 'bg-red-600 text-white border-red-600';
              } else if (flagged) {
                tone = 'bg-amber-400 text-amber-950 border-amber-400';
              }

              const state = !isAnswered
                ? 'unanswered'
                : !showCorrectness
                ? 'answered'
                : isCorrect
                ? 'correct'
                : 'incorrect';

              return (
                <button
                  key={index}
                  onClick={() => onJump(index)}
                  aria-current={isActive ? 'true' : undefined}
                  aria-label={`Question ${index + 1}, ${state}${flagged ? ', flagged' : ''}`}
                  className={`relative w-9 h-9 flex items-center justify-center rounded-lg text-xs font-bold border-2 transition-all tabular-nums ${tone} ${
                    isActive ? 'ring-2 ring-offset-2 ring-comptia-charcoal' : ''
                  }`}
                >
                  {index + 1}
                  {flagged && isAnswered && (
                    <span className="absolute -top-1 -right-1 w-3 h-3 rounded-full bg-amber-400 border-2 border-white" />
                  )}
                </button>
              );
            })}
          </div>

          <div className="flex items-center gap-x-4 gap-y-2 flex-wrap px-5 py-3 border-t border-slate-100 text-xs font-medium text-slate-500">
            {showCorrectness ? (
              <>
                <Legend className="bg-emerald-600 border-emerald-600" label="Correct" />
                <Legend className="bg-red-600 border-red-600" label="Incorrect" />
              </>
            ) : (
              <Legend className="bg-slate-700 border-slate-700" label="Answered" />
            )}
            <Legend className="bg-amber-400 border-amber-400" label="Flagged" />
            <Legend className="bg-white border-slate-200" label="Unanswered" />
            <span className="inline-flex items-center gap-2">
              <span className="w-3 h-3 rounded-sm border-2 bg-white border-slate-200 ring-2 ring-offset-1 ring-comptia-charcoal" />
              Current
            </span>
          </div>
        </div>
      )}
    </div>
  );
}

function Legend({ className, label }) {
  return (
    <span className="inline-flex items-center gap-2">
      <span className={`w-3 h-3 rounded-sm border-2 ${className}`} />
      {label}
    </span>
  );
}
