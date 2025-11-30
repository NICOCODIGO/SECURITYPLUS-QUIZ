import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { FileText, ArrowRight, AlertCircle } from 'lucide-react';
import { createPageUrl } from "@/lib/utils";

export default function MockExam({ allQuestions }) {

  const handleStartExam = () => {
    const shuffled = [...allQuestions].sort(() => Math.random() - 0.5).slice(0, 90);
    
    // Store questions in sessionStorage to avoid URL length limits
    const quizId = `quiz_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(shuffled));
    
    const params = new URLSearchParams({
      type: 'mock',
      timer: 'true',
      quizId: quizId,
      returnTo: 'mock'
    });
    window.location.href = createPageUrl('TakeQuiz') + '?' + params.toString();
  };

  return (
      <div className="space-y-6">
        <Card className="border-2 border-slate-200 shadow-lg">
          <CardHeader className="space-y-4">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-red-600 rounded-lg flex items-center justify-center">
                <FileText className="w-6 h-6 text-white" />
              </div>
              <div>
                <CardTitle className="text-2xl font-bold text-slate-900">Mock Exam Simulator</CardTitle>
                <p className="text-slate-600 mt-1">Full Security+ SY0-701 Practice Test</p>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="bg-blue-50 border-2 border-blue-200 rounded-lg p-4">
              <div className="flex items-start gap-3">
                <AlertCircle className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
                <div className="text-sm text-blue-900">
                  <p className="font-semibold mb-1">Exam Conditions</p>
                  <p>This mock exam simulates the actual Security+ certification test. You will have 90 minutes to complete 90 questions covering all five domains.</p>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4">
              <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
                <p className="text-2xl font-bold text-slate-900">90</p>
                <p className="text-sm text-slate-600">Questions</p>
              </div>
              <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
                <p className="text-2xl font-bold text-slate-900">90</p>
                <p className="text-sm text-slate-600">Minutes</p>
              </div>
              <div className="text-center p-4 bg-slate-50 rounded-lg border-2 border-slate-200">
                <p className="text-2xl font-bold text-slate-900">750</p>
                <p className="text-sm text-slate-600">Passing Score</p>
              </div>
            </div>

            <Button 
              onClick={handleStartExam} 
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