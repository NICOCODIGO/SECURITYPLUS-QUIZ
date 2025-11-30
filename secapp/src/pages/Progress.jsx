import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { CheckCircle2, Target, Clock, TrendingUp, Award, ThumbsUp, ThumbsDown } from 'lucide-react';
import { Progress as ProgressBar } from '@/components/ui/progress';
import StatsCard from '../components/progress/StatsCard';
import { format } from 'date-fns';
import { lessons } from '../components/data/lessonsData';
import { getProgress, getCompletedLessonsCount, getAverageQuizScore, getTotalTimeSpent } from '../components/data/progressData';

export default function Progress() {
  const progress = getProgress();
  const completedLessons = getCompletedLessonsCount();
  const totalLessons = lessons.length;
  const completionRate = totalLessons > 0 ? Math.round((completedLessons / totalLessons) * 100) : 0;
  const averageScore = getAverageQuizScore();
  const totalTimeSpent = getTotalTimeSpent();

  const completedProgress = progress.filter(p => p.completed);

  const getLessonById = (lessonId) => {
    return lessons.find(l => l.id === lessonId);
  };

  // Calculate domain performance
  const getDomainPerformance = () => {
    const quizScores = JSON.parse(localStorage.getItem('quizScores') || '[]');
    
    if (quizScores.length === 0) return null;

    const domainStats = {};
    
    quizScores.forEach(quiz => {
      if (quiz.domain) {
        if (!domainStats[quiz.domain]) {
          domainStats[quiz.domain] = { scores: [], total: 0, count: 0 };
        }
        domainStats[quiz.domain].scores.push(quiz.score);
        domainStats[quiz.domain].total += quiz.score;
        domainStats[quiz.domain].count += 1;
      }
    });

    const domainAverages = Object.keys(domainStats).map(domain => ({
      domain: domain,
      average: Math.round(domainStats[domain].total / domainStats[domain].count),
      quizzesTaken: domainStats[domain].count
    }));

    if (domainAverages.length === 0) return null;

    domainAverages.sort((a, b) => b.average - a.average);

    return {
      strongest: domainAverages[0],
      weakest: domainAverages[domainAverages.length - 1],
      all: domainAverages
    };
  };

  const domainPerformance = getDomainPerformance();

  return (
    <div className="max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 space-y-8">
      {/* Header */}
      <div className="text-center space-y-4">
        <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
          <TrendingUp className="w-5 h-5 text-red-600" />
          <span className="text-sm font-bold text-red-700 uppercase tracking-wide">Your Learning Journey</span>
        </div>
        <h1 className="text-5xl font-black text-slate-900 uppercase tracking-tight">Progress Dashboard</h1>
        <p className="text-lg text-slate-700 max-w-2xl mx-auto font-medium">
          Track your learning progress and quiz performance
        </p>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <StatsCard
          icon={CheckCircle2}
          title="Lessons Completed"
          value={`${completedLessons}/${totalLessons}`}
          subtitle={`${completionRate}% complete`}
          color="green"
        />
        <StatsCard
          icon={Target}
          title="Average Quiz Score"
          value={`${averageScore}%`}
          subtitle={averageScore > 0 ? 'Keep up the good work!' : 'No quizzes taken yet'}
          color="blue"
        />
        <StatsCard
          icon={Clock}
          title="Time Spent"
          value={`${totalTimeSpent}h`}
          subtitle="Total learning time"
          color="amber"
        />
        <StatsCard
          icon={Award}
          title="Completion Rate"
          value={`${completionRate}%`}
          subtitle="Keep up the great work!"
          color="purple"
        />
      </div>

      {/* Progress Bar */}
      <Card className="border-slate-200 shadow-lg">
        <CardHeader>
          <CardTitle className="text-xl font-bold text-slate-900">Overall Progress</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-slate-600">Course Completion</span>
              <span className="font-semibold text-slate-900">{completionRate}%</span>
            </div>
            <ProgressBar value={completionRate} className="h-3" />
          </div>
          <p className="text-sm text-slate-600">
            {completedLessons === totalLessons ? (
              <span className="text-green-600 font-medium">🎉 Congratulations! You've completed all lessons!</span>
            ) : (
              `${totalLessons - completedLessons} lessons remaining to complete the course`
            )}
          </p>
        </CardContent>
      </Card>

      {/* Domain Performance */}
      {domainPerformance && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="border-2 border-green-200 bg-green-50 shadow-lg">
            <CardHeader>
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 bg-green-600 rounded-full flex items-center justify-center">
                  <ThumbsUp className="w-6 h-6 text-white" />
                </div>
                <div>
                  <CardTitle className="text-lg font-bold text-slate-900">Strongest Domain</CardTitle>
                  <p className="text-sm text-slate-600">You excel here!</p>
                </div>
              </div>
            </CardHeader>
            <CardContent className="space-y-3">
              <h3 className="font-bold text-slate-900 text-lg">{domainPerformance.strongest.domain}</h3>
              <div className="flex items-baseline gap-2">
                <span className="text-4xl font-black text-green-600">{domainPerformance.strongest.average}%</span>
                <span className="text-sm text-slate-600">Average Score</span>
              </div>
              <p className="text-sm text-slate-600">
                {domainPerformance.strongest.quizzesTaken} quiz{domainPerformance.strongest.quizzesTaken !== 1 ? 'zes' : ''} taken
              </p>
            </CardContent>
          </Card>

          <Card className="border-2 border-red-200 bg-red-50 shadow-lg">
            <CardHeader>
              <div className="flex items-center gap-3">
                <div className="w-12 h-12 bg-red-600 rounded-full flex items-center justify-center">
                  <ThumbsDown className="w-6 h-6 text-white" />
                </div>
                <div>
                  <CardTitle className="text-lg font-bold text-slate-900">Weakest Domain</CardTitle>
                  <p className="text-sm text-slate-600">Focus your studies here</p>
                </div>
              </div>
            </CardHeader>
            <CardContent className="space-y-3">
              <h3 className="font-bold text-slate-900 text-lg">{domainPerformance.weakest.domain}</h3>
              <div className="flex items-baseline gap-2">
                <span className="text-4xl font-black text-red-600">{domainPerformance.weakest.average}%</span>
                <span className="text-sm text-slate-600">Average Score</span>
              </div>
              <p className="text-sm text-slate-600">
                {domainPerformance.weakest.quizzesTaken} quiz{domainPerformance.weakest.quizzesTaken !== 1 ? 'zes' : ''} taken
              </p>
            </CardContent>
          </Card>
        </div>
      )}

      {/* Completed Lessons */}
      {completedProgress.length > 0 && (
        <Card className="border-slate-200 shadow-lg">
          <CardHeader>
            <CardTitle className="text-xl font-bold text-slate-900">Completed Lessons</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {completedProgress
                .sort((a, b) => new Date(b.completion_date) - new Date(a.completion_date))
                .map((prog, index) => {
                  const lesson = getLessonById(prog.lesson_id);
                  if (!lesson) return null;

                  return (
                    <div
                      key={index}
                      className="flex items-center justify-between p-4 rounded-lg border border-slate-200 hover:bg-slate-50 transition-all"
                    >
                      <div className="flex items-center gap-4 flex-1">
                        <div className="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center flex-shrink-0">
                          <CheckCircle2 className="w-5 h-5 text-green-600" />
                        </div>
                        <div className="flex-1">
                          <h3 className="font-semibold text-slate-900">{lesson.title}</h3>
                          <p className="text-sm text-slate-600">
                            Completed on {format(new Date(prog.completion_date), 'MMM d, yyyy')}
                          </p>
                        </div>
                      </div>
                      {prog.quiz_score !== undefined && prog.quiz_score !== null && (
                        <div className="text-right">
                          <p className="text-2xl font-bold text-blue-600">{prog.quiz_score}%</p>
                          <p className="text-xs text-slate-600">Quiz Score</p>
                        </div>
                      )}
                    </div>
                  );
                })}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Empty State */}
      {completedProgress.length === 0 && (
        <Card className="border-slate-200">
          <CardContent className="p-12 text-center">
            <TrendingUp className="w-12 h-12 text-slate-300 mx-auto mb-4" />
            <h3 className="text-lg font-semibold text-slate-900 mb-2">Start Your Learning Journey</h3>
            <p className="text-slate-600">Complete lessons to track your progress</p>
          </CardContent>
        </Card>
      )}
    </div>
  );
}