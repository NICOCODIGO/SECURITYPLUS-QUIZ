import React, { useState, useEffect } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Clock, ArrowLeft, Flag } from 'lucide-react';
import QuizQuestion from '../components/quiz/QuizQuestion';
import QuestionNavigator from '../components/quiz/QuestionNavigator';
import QuizResults from '../components/quiz/QuizResults';
import { saveQuizAttempt } from '../components/data/quizHistoryData';
import { hashQuestion } from '../components/data/quizData';
import { getFlaggedIds, toggleFlag } from '../components/data/questionPools';
import { createPageUrl } from "@/lib/utils";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";

export default function TakeQuiz() {
  const urlParams = new URLSearchParams(window.location.search);
  
  const quizType = urlParams.get('type');
  const domainTitle = urlParams.get('domain');
  const domainId = urlParams.get('domainId');
  const returnTo = urlParams.get('returnTo');
  const domainPercentage = urlParams.get('percentage');
  const difficulty = urlParams.get('difficulty');
  const timerEnabled = urlParams.get('timer') === 'true';
  const quizId = urlParams.get('quizId');
  
  const [questions, setQuestions] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState({});
  const [showFeedback, setShowFeedback] = useState({});
  const [showResults, setShowResults] = useState(false);
  const [timeRemaining, setTimeRemaining] = useState(0);
  const [showExitDialog, setShowExitDialog] = useState(false);
  const [quizStartTime, setQuizStartTime] = useState(null);
  const [quizCompletionTime, setQuizCompletionTime] = useState(null);
  const [allowUnload, setAllowUnload] = useState(false);
  // Mirrors the persisted flag set so the icons re-render on toggle.
  const [flagged, setFlagged] = useState(() => getFlaggedIds());

  const handleToggleFlag = (question) => {
    toggleFlag(hashQuestion(question.question));
    setFlagged(getFlaggedIds());
  };

  const isQuestionFlagged = (question) =>
    question ? flagged.has(hashQuestion(question.question)) : false;

  useEffect(() => {
    if (quizId) {
      const storedQuestions = sessionStorage.getItem(quizId);
      if (storedQuestions) {
        const parsed = JSON.parse(storedQuestions);
        setQuestions(parsed);
        setQuizStartTime(Date.now());
        if (timerEnabled) {
          setTimeRemaining(parsed.length * 60);
        }
      }
    }
  }, [quizId, timerEnabled]);

  useEffect(() => {
    let timer;
    if (!showResults && timerEnabled && timeRemaining > 0) {
      timer = setInterval(() => {
        setTimeRemaining(prev => {
          if (prev <= 1) {
            handleSubmit();
            return 0;
          }
          return prev - 1;
        });
      }, 1000);
    }
    return () => clearInterval(timer);
  }, [showResults, timerEnabled, timeRemaining]);

  useEffect(() => {
  // Only warn if quiz is in progress
  const quizInProgress =
    questions.length > 0 && !showResults;

  const handleBeforeUnload = (e) => {
    if (!quizInProgress) return;

    e.preventDefault();
    e.returnValue = ""; // Required for Chrome
    return "";
  };


  return () => {
    window.removeEventListener("beforeunload", handleBeforeUnload);
  };
}, [questions.length, showResults, allowUnload]);



  const formatTime = (seconds) => {
    if (quizType === 'mock') {
      const hours = Math.floor(seconds / 3600);
      const minutes = Math.floor((seconds % 3600) / 60);
      const secs = seconds % 60;
      return `${hours}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs.toString().padStart(2, '0')}`;
  };

  // A mock exam behaves like the real thing: picking an answer only records
  // it, the way a form does. Nothing is marked right or wrong, and answers
  // stay changeable, until the whole exam is submitted. Practice quizzes keep
  // their instant per-question feedback, which is the point of practising.
  const revealsAnswersImmediately = quizType !== 'mock';

  const handleAnswerSelect = (answerIndex) => {
    if (!showResults) {
      setSelectedAnswers({
        ...selectedAnswers,
        [currentQuestionIndex]: answerIndex,
      });
      if (revealsAnswersImmediately) {
        setShowFeedback({
          ...showFeedback,
          [currentQuestionIndex]: true,
        });
      }
    }
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    }
  };

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
    }
  };

  const handleSubmit = () => {
    const completionTime = Math.floor((Date.now() - quizStartTime) / 1000);
    setQuizCompletionTime(completionTime);
    setShowResults(true);

    // Save the attempt. Feeds the weakest-subject picker and the whole
    // Progress dashboard, so it records per-question results (by hash, to
    // keep the record small) and how long the attempt took, not just the
    // headline score.
    saveQuizAttempt({
      date: new Date().toISOString(),
      type: quizType || 'domain',
      score: calculateScore(),
      questionsCount: questions.length,
      durationSeconds: completionTime,
      domainTitle: domainTitle || null,
      domainBreakdown: calculateDomainBreakdown(),
      answers: questions.map((q, index) => ({
        id: hashQuestion(q.question),
        ok: selectedAnswers[index] === q.correctAnswer,
      })),
    });
  };

  const handleRetake = () => {
    setCurrentQuestionIndex(0);
    setSelectedAnswers({});
    setShowFeedback({});
    setShowResults(false);
    setQuizStartTime(Date.now());
    setQuizCompletionTime(null);
    if (timerEnabled) {
      setTimeRemaining(questions.length * 60);
    }
  };

  const handleExit = () => {
    if (!showResults) {
      setShowExitDialog(true);
    } else {
      const section = returnTo || domainId || 'dashboard';
      window.location.href = createPageUrl('Lessons') + `?section=${section}`;
    }
  };

  const confirmExit = () => {
    setAllowUnload(true); //allow intentional exit

    const section = returnTo || domainId || 'dashboard';
    window.location.href = createPageUrl('Lessons') + `?section=${section}`;
    
  };

  const calculateScore = () => {
    let correct = 0;
    questions.forEach((q, index) => {
      if (selectedAnswers[index] === q.correctAnswer) {
        correct++;
      }
    });
    return Math.round((correct / questions.length) * 100);
  };

  const calculateDomainBreakdown = () => {
    const domains = {};
    questions.forEach((q, index) => {
      if (!domains[q.domain]) {
        domains[q.domain] = { total: 0, correct: 0 };
      }
      domains[q.domain].total++;
      if (selectedAnswers[index] === q.correctAnswer) {
        domains[q.domain].correct++;
      }
    });
    return Object.entries(domains).map(([domain, stats]) => ({
      domain,
      percentage: Math.round((stats.correct / stats.total) * 100),
      correct: stats.correct,
      total: stats.total,
    }));
  };

  const allQuestionsAnswered = questions.every((_, index) => selectedAnswers[index] !== undefined);
  const isLastQuestion = currentQuestionIndex === questions.length - 1;
  const currentQuestion = questions[currentQuestionIndex];

  if (questions.length === 0) {
    return <div className="text-center py-20">Loading quiz...</div>;
  }

  if (showResults) {
    return (
      <QuizResults
        questions={questions}
        selectedAnswers={selectedAnswers}
        quizType={quizType || 'domain'}
        domainId={domainId}
        domainTitle={domainTitle}
        score={calculateScore()}
        completionTime={quizCompletionTime}
        formatTime={formatTime}
        isQuestionFlagged={isQuestionFlagged}
        onToggleFlag={handleToggleFlag}
        onRetake={handleRetake}
        onExit={handleExit}
      />
    );
  }

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="outline" onClick={handleExit} className="border-2">
          <ArrowLeft className="w-4 h-4 mr-2" />
          Exit {quizType === 'mock' ? 'Exam' : 'Quiz'}
        </Button>

        <div className="flex items-center gap-4">
          {domainTitle && (
            <div className="text-right">
              <h2 className="text-lg font-bold text-slate-900">{domainTitle}</h2>
              {difficulty && <p className="text-sm text-slate-600">{difficulty} Level</p>}
            </div>
          )}

          {/* Flag for later review. Collected by the custom quiz builder's
              "Flagged for review" pool. */}
          <Button
            variant="outline"
            onClick={() => handleToggleFlag(currentQuestion)}
            aria-pressed={isQuestionFlagged(currentQuestion)}
            title={isQuestionFlagged(currentQuestion) ? 'Remove flag' : 'Flag for review'}
            className={`border-2 ${
              isQuestionFlagged(currentQuestion)
                ? 'border-amber-500 bg-amber-50 text-amber-800 hover:bg-amber-100'
                : 'border-slate-300 text-slate-600'
            }`}
          >
            <Flag
              className={`w-4 h-4 mr-2 ${isQuestionFlagged(currentQuestion) ? 'fill-amber-500' : ''}`}
            />
            {isQuestionFlagged(currentQuestion) ? 'Flagged' : 'Flag'}
          </Button>
        </div>
      </div>

      {timerEnabled && (
        <Card className="border-2 border-slate-200 bg-slate-50">
          <CardContent className="p-4 flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Clock className="w-5 h-5 text-red-600" />
              <div>
                <p className="text-sm text-slate-600">Time Remaining</p>
                <p className={`text-lg font-bold ${timeRemaining < (quizType === 'mock' ? 600 : 120) ? 'text-red-600' : 'text-slate-900'}`}>
                  {formatTime(timeRemaining)}
                </p>
              </div>
            </div>
            <div className="text-right">
              <p className="text-sm text-slate-600">Progress</p>
              <p className="text-lg font-bold text-slate-900">
                {Object.keys(selectedAnswers).length}/{questions.length}
              </p>
            </div>
          </CardContent>
        </Card>
      )}

      <QuizQuestion
        question={currentQuestion}
        questionNumber={currentQuestionIndex + 1}
        totalQuestions={questions.length}
        selectedAnswer={selectedAnswers[currentQuestionIndex]}
        onAnswerSelect={handleAnswerSelect}
        showResults={showFeedback[currentQuestionIndex] || false}
        correctAnswer={currentQuestion.correctAnswer}
      />

      <div className="flex justify-between">
        <Button
          variant="outline"
          onClick={handlePrevious}
          disabled={currentQuestionIndex === 0}
          className="border-2"
        >
          Previous
        </Button>
        {!isLastQuestion ? (
          <Button onClick={handleNext} className="bg-slate-700 hover:bg-slate-800">
            Next
          </Button>
        ) : (
          <Button
            onClick={handleSubmit}
            disabled={!allQuestionsAnswered}
            className="bg-red-600 hover:bg-red-700 font-semibold"
          >
            Submit {quizType === 'mock' ? 'Exam' : 'Quiz'}
          </Button>
        )}
      </div>

      <QuestionNavigator
        questions={questions}
        currentIndex={currentQuestionIndex}
        selectedAnswers={selectedAnswers}
        isQuestionFlagged={isQuestionFlagged}
        onJump={setCurrentQuestionIndex}
        showCorrectness={revealsAnswersImmediately}
      />


      <AlertDialog open={showExitDialog} onOpenChange={setShowExitDialog}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Are you sure you want to exit?</AlertDialogTitle>
            <AlertDialogDescription>
              Your progress will be lost. You have answered {Object.keys(selectedAnswers).length} out of {questions.length} questions.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Continue Quiz</AlertDialogCancel>
            <AlertDialogAction onClick={confirmExit} className="bg-red-600 hover:bg-red-700">
              Exit Quiz
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}