import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Progress as ProgressBar } from '@/components/ui/progress';

export default function OverallProgressCard({ completionRate, completedLessons, totalLessons }) {
  return (
    <Card className="border-slate-200 shadow-lg">
      <CardHeader>
        <CardTitle className="text-xl font-bold text-slate-900">
          Overall Progress
        </CardTitle>
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
          {completedLessons === totalLessons
            ? "🎉 Congratulations! You've completed all lessons!"
            : `${totalLessons - completedLessons} lessons remaining`}
        </p>
      </CardContent>
    </Card>
  );
}
