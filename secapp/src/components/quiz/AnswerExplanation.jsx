import React from 'react';
import { CheckCircle2, ChevronDown, XCircle } from 'lucide-react';
import { getChoiceRationale } from '../data/choiceRationales';

/**
 * Why the right answer is right and, when you picked something else, why
 * your pick isn't. Seeing the two together is what turns "wrong" into
 * "oh, close, but it's this one".
 *
 * The remaining wrong choices sit behind a disclosure, so the default stays
 * short enough for the quiz screen to fit on one page. Choices without a
 * written rationale are simply left out.
 *
 * Used by the quiz itself, the results review and Question of the Day.
 * `bare` drops the box for places that already wrap it in one.
 */
export default function AnswerExplanation({ question, answer, bare = false, className = '' }) {
  const correctIndex = question.correctAnswer;
  const pickedWrong = answer !== undefined && answer !== null && answer !== correctIndex;
  const pickedReason = pickedWrong ? getChoiceRationale(question, answer) : null;

  const others = question.choices
    .map((choice, index) => ({ choice, index, reason: getChoiceRationale(question, index) }))
    .filter(({ index, reason }) => reason && index !== correctIndex && index !== answer);

  return (
    <div
      className={`space-y-2.5 text-sm leading-relaxed ${
        bare ? '' : 'rounded-lg border border-blue-200 bg-blue-50 px-4 py-3'
      } ${className}`}
    >
      <Reason icon={CheckCircle2} iconClass="text-emerald-600" label={`Why “${question.choices[correctIndex]}” is right`}>
        {question.explanation}
      </Reason>

      {pickedReason && (
        <Reason icon={XCircle} iconClass="text-red-600" label={`Why not “${question.choices[answer]}”`}>
          {pickedReason}
        </Reason>
      )}

      {others.length > 0 && (
        <details className="group">
          <summary className="inline-flex cursor-pointer list-none items-center gap-1 rounded text-xs font-bold text-slate-600 hover:text-comptia-charcoal [&::-webkit-details-marker]:hidden">
            <ChevronDown className="h-3.5 w-3.5 transition-transform group-open:rotate-180" />
            Why not the other {others.length === 1 ? 'answer' : 'answers'}?
          </summary>
          <ul className="mt-2 space-y-1.5 pl-5">
            {others.map(({ choice, index, reason }) => (
              <li key={index} className="text-slate-700">
                <span className="font-semibold text-slate-900">{choice}:</span> {reason}
              </li>
            ))}
          </ul>
        </details>
      )}
    </div>
  );
}

function Reason({ icon, iconClass, label, children }) {
  const Icon = icon;
  return (
    <p className="flex gap-2">
      <Icon className={`mt-0.5 h-4 w-4 flex-shrink-0 ${iconClass}`} />
      <span>
        <span className="font-semibold text-slate-900">{label}: </span>
        <span className="text-slate-700">{children}</span>
      </span>
    </p>
  );
}
