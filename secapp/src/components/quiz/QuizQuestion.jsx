import React from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { CheckCircle2, XCircle } from "lucide-react";

export default function QuizQuestion({
  question,
  questionNumber,
  totalQuestions,
  selectedAnswer,
  onAnswerSelect,
  showResults,
  correctAnswer,
}) {
  const isCorrect = showResults && selectedAnswer === correctAnswer;
  const isIncorrect =
    showResults && selectedAnswer !== correctAnswer && selectedAnswer !== null;

  return (
    <Card className="border-2 border-slate-200 shadow-sm rounded-xl">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <span className="text-sm font-medium text-slate-600">
            Question {questionNumber} of {totalQuestions}
          </span>

          {showResults && (
            <div className="flex items-center gap-2">
              {isCorrect ? (
                <div className="flex items-center gap-2 text-green-600">
                  <CheckCircle2 className="w-5 h-5" />
                  <span className="text-sm font-semibold">Correct</span>
                </div>
              ) : (
                <div className="flex items-center gap-2 text-red-600">
                  <XCircle className="w-5 h-5" />
                  <span className="text-sm font-semibold">Incorrect</span>
                </div>
              )}
            </div>
          )}
        </div>

        <CardTitle className="text-lg font-semibold text-slate-900 leading-relaxed mt-2">
          {question.question}
        </CardTitle>
      </CardHeader>

      <CardContent>
        <RadioGroup
          key={`question-${questionNumber}`}
          value={
            selectedAnswer !== undefined ? selectedAnswer.toString() : undefined
          }
          onValueChange={(value) => onAnswerSelect(parseInt(value))}
          disabled={showResults}
        >
          <div className="space-y-4">
            {question.choices.map((choice, index) => {
              const isThisCorrect = showResults && index === correctAnswer;
              const isThisSelected = index === selectedAnswer;
              const isThisIncorrect =
                showResults && isThisSelected && !isThisCorrect;

                return (
                <Label
                  key={index}
                  htmlFor={`q${questionNumber}-choice${index}`}
                  className={`
                  flex items-center gap-4 p-4 rounded-lg border transition-all
                  ${
                    isThisCorrect
                    ? "bg-green-50 border-green-300"
                    : isThisIncorrect
                    ? "bg-red-50 border-red-300"
                    : "border-slate-300 hover:bg-slate-50"
                  }
                  ${showResults ? "cursor-default" : "cursor-pointer"}
                  `}
                >
                  {/* Final perfect circle radio button */}
                  <RadioGroupItem
  value={index.toString()}
  id={`q${questionNumber}-choice${index}`}
  disabled={showResults}
  className="
    relative h-5 w-5 rounded-full
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
                  <span className="text-sm font-semibold text-green-700">
                    ✓ Correct
                  </span>
                  )}

                  {isThisIncorrect && (
                  <span className="text-sm font-semibold text-red-700">
                    ✗ Your answer
                  </span>
                  )}
                </Label>
                );
            })}
          </div>
        </RadioGroup>

        {showResults && question.explanation && (
          <div className="mt-5 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <p className="font-semibold text-blue-900 mb-1">Explanation</p>
            <p className="text-sm text-blue-800 leading-relaxed">
              {question.explanation}
            </p>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
