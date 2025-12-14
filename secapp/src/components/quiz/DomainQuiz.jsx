import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Target, ArrowRight, Clock } from 'lucide-react';
import { Switch } from '@/components/ui/switch';
import { createPageUrl } from "@/lib/utils";

export default function DomainQuiz({ domain, questions }) {
  const navigate = useNavigate();
  const [difficulty, setDifficulty] = useState('Beginner');
  const [questionCount, setQuestionCount] = useState(10);
  const [timerEnabled, setTimerEnabled] = useState(false);

  const handleStartQuiz = () => {
    // First try to get questions from selected difficulty
    let selected = questions.filter(q => q.difficulty === difficulty);
    
    // If not enough questions at this difficulty, add from other difficulties
    if (selected.length < questionCount) {
      const remaining = questions.filter(q => q.difficulty !== difficulty);
      selected = [...selected, ...remaining].slice(0, questionCount);
    } else {
      selected = selected.slice(0, questionCount);
    }
    
    // Store questions in sessionStorage to avoid URL length limits
    const quizId = `quiz_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(selected));
    
    const params = new URLSearchParams({
      type: 'domain',
      domain: domain.title,
      domainId: domain.id,
      percentage: domain.percentage,
      difficulty: difficulty,
      timer: timerEnabled.toString(),
      quizId: quizId
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
              <CardTitle className="text-2xl font-bold text-slate-900">{domain.title}</CardTitle>
              <p className="text-slate-600 mt-1">{domain.description}</p>
            </div>
          </div>
        </CardHeader>
        <CardContent className="space-y-6">
          <div>
            <h3 className="text-sm font-semibold text-slate-700 mb-3">Select Difficulty</h3>

            <Tabs value={difficulty} onValueChange={setDifficulty}>
              <TabsList className="w-full bg-slate-100 rounded-xl p-1 flex">
                {['Beginner', 'Intermediate', 'Advanced'].map((level) => (
                  <TabsTrigger
                    key={level}
                    value={level}
                    className="
                      flex-1 rounded-lg py-2 text-sm
                      text-slate-500
                      data-[state=active]:bg-red-600
                      data-[state=active]:text-white
                    "
                  >
                    {level}
                  </TabsTrigger>
                ))}
              </TabsList>
            </Tabs>
          </div>

          <div>
            <h3 className="text-sm font-semibold text-slate-700 mb-3">Number of Questions</h3>
            <input
              type="range"
              min="1"
              max="90"
              value={questionCount}
              onChange={(e) => setQuestionCount(parseInt(e.target.value))}
              className="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer accent-red-600"
            />
            <div className="flex justify-between items-center mt-2">
              <span className="text-xs text-slate-500">1</span>
              <span className="text-lg font-bold text-red-600">{questionCount}</span>
              <span className="text-xs text-slate-500">90</span>
            </div>
          </div>

          <div className="flex items-center justify-between p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
            <div className="flex items-center gap-3">
              <Clock className="w-5 h-5 text-slate-700" />
              <div>
                <p className="text-sm font-semibold text-slate-700">Time Limit</p>
                <p className="text-xs text-slate-600">
                  {timerEnabled ? `${questionCount} minutes (1 min per question)` : 'No time limit'}
                </p>
              </div>
            </div>
            <Switch checked={timerEnabled} onCheckedChange={setTimerEnabled} />
          </div>

          <div className="max-w-xs mx-auto pt-4">
            <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
              <p className="text-2xl font-bold text-slate-900">{domain.percentage}</p>
              <p className="text-sm text-slate-600">of Exam</p>
            </div>
          </div>

          <Button 
            onClick={handleStartQuiz} 
            className="w-full bg-red-600 hover:bg-red-700 h-12 font-semibold"
            disabled={questions.length === 0}
          >
            Start Quiz
            <ArrowRight className="w-4 h-4 ml-2" />
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}