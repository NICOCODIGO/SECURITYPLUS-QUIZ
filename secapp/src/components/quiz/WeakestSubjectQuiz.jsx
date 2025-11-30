import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { TrendingDown, AlertCircle } from 'lucide-react';
import { createPageUrl } from "@/lib/utils";

export default function WeakestSubjectQuiz({ allQuestions }) {
  // Get quiz history from localStorage
  const getQuizHistory = () => {
    const history = localStorage.getItem('quiz_history');
    return history ? JSON.parse(history) : [];
  };

  // Calculate domain performance
  const calculateDomainScores = () => {
    const history = getQuizHistory();
    const domainStats = {};

    history.forEach(quiz => {
      if (quiz.domainBreakdown) {
        quiz.domainBreakdown.forEach(domain => {
          if (!domainStats[domain.domain]) {
            domainStats[domain.domain] = { total: 0, correct: 0, count: 0 };
          }
          domainStats[domain.domain].total += domain.total;
          domainStats[domain.domain].correct += domain.correct;
          domainStats[domain.domain].count += 1;
        });
      }
    });

    // Calculate average percentage for each domain
    const domainScores = Object.entries(domainStats).map(([domain, stats]) => ({
      domain,
      percentage: Math.round((stats.correct / stats.total) * 100),
      questionsAttempted: stats.total,
    }));

    return domainScores.sort((a, b) => a.percentage - b.percentage);
  };

  const domainScores = calculateDomainScores();
  const weakestDomain = domainScores[0];
  const hasHistory = domainScores.length > 0;

  const handleStartQuiz = () => {
    if (!hasHistory) {
      alert('Take some quizzes first to identify your weakest subject!');
      return;
    }

    // Filter questions from the weakest domain
    const weakestQuestions = allQuestions.filter(q => q.domain === weakestDomain.domain);
    
    // Shuffle and select up to 20 questions
    const shuffled = [...weakestQuestions].sort(() => Math.random() - 0.5);
    const selectedQuestions = shuffled.slice(0, Math.min(20, shuffled.length));

    const quizId = `weakest_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(selectedQuestions));

    window.location.href = createPageUrl('TakeQuiz') + 
      `?type=weakest&domain=${encodeURIComponent(weakestDomain.domain)}&timer=false&quizId=${quizId}&returnTo=dashboard`;
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Weakest Subject Quiz</h1>
        <p className="text-slate-600 mt-2">Focus on improving your lowest performing subject</p>
      </div>

      {!hasHistory ? (
        <Card className="border-2 border-slate-200 bg-slate-50">
          <CardContent className="p-8 text-center space-y-4">
            <AlertCircle className="w-16 h-16 text-slate-400 mx-auto" />
            <div>
              <h3 className="text-xl font-bold text-slate-900 mb-2">No Quiz History Found</h3>
              <p className="text-slate-600">
                Take some quizzes first so we can identify which subjects need more practice.
              </p>
            </div>
          </CardContent>
        </Card>
      ) : (
        <>
          <Card className="border-2 border-orange-600 bg-gradient-to-br from-orange-50 to-white">
            <CardHeader>
              <CardTitle className="text-2xl font-bold text-slate-900">Your Weakest Subject</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-start gap-4">
                <div className="w-16 h-16 bg-orange-600 rounded-lg flex items-center justify-center flex-shrink-0">
                  <TrendingDown className="w-8 h-8 text-white" />
                </div>
                <div className="flex-1">
                  <h3 className="text-xl font-bold text-slate-900 mb-1">{weakestDomain.domain}</h3>
                  <p className="text-slate-600 mb-2">
                    Current Score: <span className="font-bold text-orange-600">{weakestDomain.percentage}%</span>
                  </p>
                  <p className="text-sm text-slate-600">
                    Based on {weakestDomain.questionsAttempted} questions attempted
                  </p>
                </div>
              </div>
              <Button 
                onClick={handleStartQuiz}
                className="w-full bg-orange-600 hover:bg-orange-700 text-white font-semibold py-6 text-lg"
              >
                Start Focused Practice (20 Questions)
              </Button>
            </CardContent>
          </Card>

          <Card className="border-2 border-slate-200">
            <CardHeader>
              <CardTitle className="text-lg font-bold text-slate-900">Your Subject Performance</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {domainScores.map((domain, index) => (
                  <div key={index} className="flex items-center justify-between p-3 bg-slate-50 rounded-lg border-2 border-slate-200">
                    <span className="text-sm font-medium text-slate-700">{domain.domain}</span>
                    <div className="flex items-center gap-3">
                      <span className="text-xs text-slate-600">{domain.questionsAttempted} questions</span>
                      <span className={`text-sm font-bold px-3 py-1 rounded-full ${
                        domain.percentage >= 80 ? 'bg-green-100 text-green-700' :
                        domain.percentage >= 60 ? 'bg-yellow-100 text-yellow-700' :
                        'bg-red-100 text-red-700'
                      }`}>
                        {domain.percentage}%
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </>
      )}
    </div>
  );
}