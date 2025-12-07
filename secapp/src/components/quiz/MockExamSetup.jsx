// MockExamSetup.jsx
import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Switch } from '@/components/ui/switch';
import { Target, ArrowRight, Clock } from 'lucide-react';
import { createPageUrl } from '@/lib/utils';
import { getAllQuestions } from '@/components/data/quizData'; // <-- adjust path if needed

// simple shuffle helper (local to this component)
function shuffleQuestions(questions) {
  const arr = [...questions];
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

export default function MockExamSetup() {
  const [difficulty, setDifficulty] = useState('All'); // All | Beginner | Intermediate | Advanced
  const [questionCount, setQuestionCount] = useState(90);
  const [timerEnabled, setTimerEnabled] = useState(false);

  const handleStartMock = () => {
    let questions = getAllQuestions(); // this is domains 1–5 combined

    if (difficulty !== 'All') {
      questions = questions.filter(q => q.difficulty === difficulty);
    }

    const shuffled = shuffleQuestions(questions);
    const selected = shuffled.slice(0, questionCount);

    const quizId = `mock_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(selected));

    const params = new URLSearchParams({
      type: 'mock',
      difficulty,
      totalQuestions: String(selected.length),
      timer: timerEnabled.toString(),
      quizId,
    });

    window.location.href = createPageUrl('TakeQuiz') + '?' + params.toString();
  };

  return (
    <div className="space-y-6">
      <Card className="border-2 border-slate-200 shadow-lg">
        <CardHeader className="space-y-4">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-red-600 rounded-lg flex items-center justify-center">
              <Target className="w-6 h-6 text-white" />
            </div>
            <div>
              <CardTitle className="text-2xl font-bold text-slate-900">
                Mock Exam Simulator
              </CardTitle>
              <p className="text-slate-600 mt-1">
                Take a full exam-style test using questions from all Security+ domains.
              </p>
            </div>
          </div>
        </CardHeader>

        <CardContent className="space-y-6">
          {/* Difficulty selector */}
          <div>
            <h3 className="text-sm font-semibold text-slate-700 mb-3">
              Difficulty Mix
            </h3>
            <Tabs value={difficulty} onValueChange={setDifficulty}>
              <TabsList className="grid grid-cols-4 w-full">
                <TabsTrigger value="All">All</TabsTrigger>
                <TabsTrigger value="Beginner">Beginner</TabsTrigger>
                <TabsTrigger value="Intermediate">Intermediate</TabsTrigger>
                <TabsTrigger value="Advanced">Advanced</TabsTrigger>
              </TabsList>
            </Tabs>
          </div>

          {/* Question count slider */}
          <div>
            <h3 className="text-sm font-semibold text-slate-700 mb-3">
              Number of Questions
            </h3>
            <input
              type="range"
              min="10"
              max="90"
              step="5"
              value={questionCount}
              onChange={(e) => setQuestionCount(parseInt(e.target.value))}
              className="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer accent-red-600"
            />
            <div className="flex justify-between items-center mt-2">
              <span className="text-xs text-slate-500">10</span>
              <span className="text-lg font-bold text-red-600">{questionCount}</span>
              <span className="text-xs text-slate-500">90</span>
            </div>
          </div>

          {/* Timer toggle */}
          <div className="flex items-center justify-between p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
            <div className="flex items-center gap-3">
              <Clock className="w-5 h-5 text-slate-700" />
              <div>
                <p className="text-sm font-semibold text-slate-700">Time Limit</p>
                <p className="text-xs text-slate-600">
                  {timerEnabled
                    ? `${questionCount} minutes (1 min per question)`
                    : 'No time limit'}
                </p>
              </div>
            </div>
            <Switch checked={timerEnabled} onCheckedChange={setTimerEnabled} />
          </div>

          <Button
            onClick={handleStartMock}
            className="w-full bg-red-600 hover:bg-red-700 h-12 font-semibold"
          >
            Start Mock Exam
            <ArrowRight className="w-4 h-4 ml-2" />
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
