import React from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { CheckCircle2, XCircle } from "lucide-react";
import AnswerExplanation from "./AnswerExplanation";

/**
 * One question with its choices, and the explanation once it is revealed.
 *
 * Spacing is kept tight so a question, its explanation and the navigation
 * all fit on one laptop screen. `footer` renders along the bottom edge —
 * TakeQuiz puts Previous/Next there so they stay attached to the question.
 */
export default function QuizQuestion({
  question,
  questionNumber,
  totalQuestions,
  selectedAnswer,
  onAnswerSelect,
  showResults,
  correctAnswer,
  footer,
}) {
  const isCorrect = showResults && selectedAnswer === correctAnswer;

  return (
    <Card className="border-2 border-slate-200 shadow-sm rounded-xl">
      <CardHeader className="p-5 pb-3 space-y-0">
        <div className="flex items-center justify-between">
          <span className="text-sm font-medium text-slate-600">
            Question {questionNumber} of {totalQuestions}
          </span>

          {showResults && (
            <div className="flex items-center gap-2">
              {isCorrect ? (
                <div className="flex items-center gap-1.5 text-green-600">
                  <CheckCircle2 className="w-5 h-5" />
                  <span className="text-sm font-semibold">Correct</span>
                </div>
              ) : (
                <div className="flex items-center gap-1.5 text-red-600">
                  <XCircle className="w-5 h-5" />
                  <span className="text-sm font-semibold">Incorrect</span>
                </div>
              )}
            </div>
          )}
        </div>

        <CardTitle className="text-lg font-semibold text-slate-900 leading-snug pt-1.5">
          {question.question}
        </CardTitle>
      </CardHeader>

      <CardContent className="px-5 pb-5">
        <RadioGroup
          key={`question-${questionNumber}`}
          value={
            selectedAnswer !== undefined ? selectedAnswer.toString() : undefined
          }
          onValueChange={(value) => onAnswerSelect(parseInt(value))}
          disabled={showResults}
        >
          <div className="space-y-2">
            {question.choices.map((choice, index) => {
              const isThisCorrect = showResults && index === correctAnswer;
              const isThisSelected = index === selectedAnswer;
              const isThisIncorrect =
                showResults && isThisSelected && !isThisCorrect;

              // Before the answer is revealed — every question in a mock
              // exam — a picked choice still needs to look picked, or the
              // only cue is the small radio dot.
              const isThisPending = !showResults && isThisSelected;

              return (
                <Label
                  key={index}
                  htmlFor={`q${questionNumber}-choice${index}`}
                  className={`
                  flex items-center gap-3 px-4 py-3 rounded-lg border transition-all leading-snug
                  ${
                    isThisCorrect
                    ? "bg-green-50 border-green-300"
                    : isThisIncorrect
                    ? "bg-red-50 border-red-300"
                    : isThisPending
                    ? "bg-slate-100 border-slate-500 ring-1 ring-slate-400"
                    : "border-slate-300 hover:bg-slate-50"
                  }
                  ${showResults ? "cursor-default" : "cursor-pointer"}
                  `}
                >
                  <RadioGroupItem
                    value={index.toString()}
                    id={`q${questionNumber}-choice${index}`}
                    disabled={showResults}
                    className="
                      relative h-5 w-5 flex-shrink-0 rounded-full
                      border border-slate-400
                      data-[state=checked]:border-slate-500
                      data-[state=checked]:bg-slate-200

                      [&_span]:h-2.5
                      [&_span]:w-2.5
                      [&_span]:rounded-full
                      [&_span]:bg-slate-600
                    "
                  />

                  {/* Answer Text */}
                  <span className="flex-1 text-slate-700">{choice}</span>

                  {isThisCorrect && (
                    <span className="text-sm font-semibold text-green-700 whitespace-nowrap">
                      ✓ Correct
                    </span>
                  )}

                  {isThisIncorrect && (
                    <span className="text-sm font-semibold text-red-700 whitespace-nowrap">
                      ✗ Your answer
                    </span>
                  )}
                </Label>
              );
            })}
          </div>
        </RadioGroup>

        {showResults && question.explanation && (
          <AnswerExplanation question={question} answer={selectedAnswer} className="mt-3" />
        )}
      </CardContent>

      {footer && (
        <div className="flex items-center justify-between gap-3 border-t-2 border-slate-100 px-5 py-3">
          {footer}
        </div>
      )}
    </Card>
  );
}
