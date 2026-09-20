import React, { useMemo } from 'react';
import QuizQuestion from '../quiz/QuizQuestion';
import QuestionNavigator from '../quiz/QuestionNavigator';
import { getAllQuestions, quizQuestions } from '../data/quizData';

/**
 * Artwork for Home's "ike It's Exam Day" band: the two things its
 * copy talks about, shown with the components the app actually renders.
 *
 * The question is a real one from the bank, answered wrongly, so the picture
 * includes the explanation the app gives for the wrong pick. Below it, the
 * real navigator part-way through a 90-question mock. Change either component
 * and this picture changes with it.
 *
 * The stage is inert, aria-hidden and pointer-events-none: these are live
 * radio inputs and buttons, and inside a decoration they must not be tabbable
 * or announced. The copy beside it says everything they show.
 */

// Thirteen answered, two flagged — the same state the mock screen described.
const ANSWERED = 13;
const FLAGGED = [4, 9];

export default function PracticePreview({ className = '' }) {
  const question =
    quizQuestions.domain1.find((q) => q.question.includes('fingerprint')) || quizQuestions.domain1[0];
  // A wrong pick, so the explanation shows both halves: why the right answer
  // is right, and why this one isn't.
  const wrongAnswer = question.correctAnswer === 0 ? 1 : 0;

  const mock = useMemo(() => {
    const questions = getAllQuestions().slice(0, 90);
    const selectedAnswers = {};
    for (let i = 0; i < ANSWERED; i++) selectedAnswers[i] = 0;
    const flagged = new Set(FLAGGED.map((i) => questions[i]));
    return { questions, selectedAnswers, isFlagged: (q) => flagged.has(q) };
  }, []);

  return (
    <div
      aria-hidden="true"
      inert={true}
      className={`pointer-events-none select-none ${className}`}
    >
      {/* Soft neutral glow so the white cards sit in light rather than on
          flat charcoal. Neutral, not red, so the band keeps its one tone. */}
      <div className="relative">
        <div className="absolute inset-0 rounded-full bg-white/10 blur-3xl" />

        <div className="relative space-y-4">
          <div className="lg:-rotate-1 shadow-2xl shadow-black/50 rounded-xl">
            <QuizQuestion
              question={question}
              questionNumber={4}
              totalQuestions={10}
              selectedAnswer={wrongAnswer}
              onAnswerSelect={() => {}}
              showResults
              correctAnswer={question.correctAnswer}
            />
          </div>

          <div className="lg:rotate-[0.8deg] ml-auto w-[94%] shadow-2xl shadow-black/50 rounded-xl">
            <QuestionNavigator
              questions={mock.questions}
              currentIndex={ANSWERED}
              selectedAnswers={mock.selectedAnswers}
              isQuestionFlagged={mock.isFlagged}
              onJump={() => {}}
              showCorrectness={false}
              defaultOpen={false}
            />
          </div>
        </div>
      </div>
    </div>
  );
}
