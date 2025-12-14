import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Target, RotateCcw, Clock, ArrowLeft, FileText, ChevronDown, ChevronUp, CheckCircle2, XCircle } from 'lucide-react';
import QuizQuestion from '../components/quiz/QuizQuestion';
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
  const [expandedQuestions, setExpandedQuestions] = useState({});
  const [timeRemaining, setTimeRemaining] = useState(0);
  const [showExitDialog, setShowExitDialog] = useState(false);
  const [quizStartTime, setQuizStartTime] = useState(null);
  const [quizCompletionTime, setQuizCompletionTime] = useState(null);

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

  const handleAnswerSelect = (answerIndex) => {
    if (!showResults) {
      setSelectedAnswers({
        ...selectedAnswers,
        [currentQuestionIndex]: answerIndex,
      });
      setShowFeedback({
        ...showFeedback,
        [currentQuestionIndex]: true,
      });
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

    // Save quiz history for weakest subject tracking
    const domainBreakdown = calculateDomainBreakdown();
    const quizHistory = JSON.parse(localStorage.getItem('quiz_history') || '[]');
    quizHistory.push({
      date: new Date().toISOString(),
      type: quizType || 'domain',
      score: calculateScore(),
      questionsCount: questions.length,
      domainBreakdown: domainBreakdown,
    });
    localStorage.setItem('quiz_history', JSON.stringify(quizHistory));
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
    const score = calculateScore();
    const correctCount = questions.filter((q, index) => 
      selectedAnswers[index] === q.correctAnswer
    ).length;

    return (
      <div className="max-w-4xl mx-auto space-y-6">
        <Button variant="outline" onClick={handleExit} className="border-2">
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to Quizzes
        </Button>

        <Card className="border-2 border-slate-200 shadow-lg">
          <CardHeader className="text-center space-y-4">
            <div className={`w-16 h-16 ${quizType === 'mock' ? 'bg-red-600' : 'bg-red-600'} rounded-full flex items-center justify-center mx-auto`}>
              {quizType === 'mock' ? <FileText className="w-8 h-8 text-white" /> : <Target className="w-8 h-8 text-white" />}
            </div>
            <CardTitle className="text-3xl font-bold text-slate-900">
              {quizType === 'mock' ? 'Exam Complete' : 'Quiz Complete'}
            </CardTitle>
            <div>
              <div className="text-5xl font-bold text-red-600">{score}%</div>
              <p className="text-slate-600 mt-2">
                {correctCount} out of {questions.length} correct
              </p>
              {quizCompletionTime && (
                <p className="text-sm text-slate-500 mt-2 flex items-center justify-center gap-2">
                  <Clock className="w-4 h-4" />
                  Completed in {formatTime(quizCompletionTime)}
                </p>
              )}
              {quizType === 'mock' && (
                <p className="text-sm text-slate-500 mt-1">
                  {score >= 83 ? '✓ PASS' : '✗ FAIL'} (Passing score: 750/900 ≈ 83%)
                </p>
              )}
            </div>
          </CardHeader>
        </Card>

        {quizType === 'mock' && (
          <Card className="border-2 border-slate-200">
            <CardHeader>
              <CardTitle className="text-xl font-bold text-slate-900">Domain Breakdown</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {calculateDomainBreakdown().map((item, index) => (
                  <div key={index} className="flex items-center justify-between p-3 bg-slate-50 rounded-lg border-2 border-slate-200">
                    <span className="text-sm font-medium text-slate-700">{item.domain}</span>
                    <div className="flex items-center gap-3">
                      <span className="text-sm text-slate-600">{item.correct}/{item.total}</span>
                      <span className={`text-sm font-bold ${item.percentage >= 70 ? 'text-green-600' : 'text-red-600'}`}>
                        {item.percentage}%
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        )}

        <Button onClick={handleRetake} variant="outline" className="w-full border-2">
          <RotateCcw className="w-4 h-4 mr-2" />
          Retake {quizType === 'mock' ? 'Exam' : 'Quiz'}
        </Button>

        <Card className="border-2 border-slate-200">
          <CardHeader>
            <CardTitle className="text-xl font-bold text-slate-900">Review Answers</CardTitle>
            <p className="text-sm text-slate-600">Click on any question to see details</p>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {questions.map((question, index) => {
                const isCorrect = selectedAnswers[index] === question.correctAnswer;
                const isExpanded = expandedQuestions[index];
                
                return (
                  <div key={index}>
                    <button
                      onClick={() => setExpandedQuestions({
                        ...expandedQuestions,
                        [index]: !isExpanded
                      })}
                      className={`w-full flex items-center justify-between p-4 rounded-lg border-2 transition-all ${
                        isCorrect 
                          ? 'bg-green-50 border-green-300 hover:bg-green-100' 
                          : 'bg-red-50 border-red-300 hover:bg-red-100'
                      }`}
                    >
                      <div className="flex items-center gap-3">
                        {isCorrect ? (
                          <CheckCircle2 className="w-5 h-5 text-green-600" />
                        ) : (
                          <XCircle className="w-5 h-5 text-red-600" />
                        )}
                        <span className="font-medium text-slate-900">Question {index + 1}</span>
                        <span className={`text-sm font-semibold ${isCorrect ? 'text-green-700' : 'text-red-700'}`}>
                          {isCorrect ? 'Correct' : 'Incorrect'}
                        </span>
                      </div>
                      {isExpanded ? (
                        <ChevronUp className="w-5 h-5 text-slate-600" />
                      ) : (
                        <ChevronDown className="w-5 h-5 text-slate-600" />
                      )}
                    </button>
                    
                    {isExpanded && (
                      <div className="mt-2">
                        <QuizQuestion
                          question={question}
                          questionNumber={index + 1}
                          totalQuestions={questions.length}
                          selectedAnswer={selectedAnswers[index]}
                          onAnswerSelect={() => {}}
                          showResults={true}
                          correctAnswer={question.correctAnswer}
                        />
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex items-center justify-between">
        <Button variant="outline" onClick={handleExit} className="border-2">
          <ArrowLeft className="w-4 h-4 mr-2" />
          Exit {quizType === 'mock' ? 'Exam' : 'Quiz'}
        </Button>
        {domainTitle && (
          <div className="text-right">
            <h2 className="text-lg font-bold text-slate-900">{domainTitle}</h2>
            {difficulty && <p className="text-sm text-slate-600">{difficulty} Level</p>}
          </div>
        )}
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

      <div className="flex gap-2 flex-wrap p-4 bg-white rounded-xl border-2 border-slate-200 justify-center shadow-sm">
  {questions.map((_, index) => {
    const isActive = index === currentQuestionIndex;
    const isAnswered = selectedAnswers[index] !== undefined;

    return (
      <button
        key={index}
        onClick={() => setCurrentQuestionIndex(index)}
        className={`
          w-10 h-10 flex items-center justify-center rounded-lg font-medium border transition-all
          ${
            isActive
              ? "bg-red-600 text-white border-red-600"
              : isAnswered
              ? "bg-green-50 text-green-700 border-green-300"
              : "bg-white text-slate-700 border-slate-300 hover:bg-slate-50"
          }
        `}
      >
        {index + 1}
      </button>
    );
  })}
</div>


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