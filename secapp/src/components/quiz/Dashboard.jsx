import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Target, FileText, BookOpen, CheckCircle2 } from 'lucide-react';

export default function Dashboard({ onSectionChange }) {
  const domains = [
    { id: 'domain1', name: '1.0 General Security Concepts', questions: 6, percentage: '12%', icon: Target },
    { id: 'domain2', name: '2.0 Threats, Vulnerabilities, and Mitigations', questions: 5, percentage: '22%', icon: Target },
    { id: 'domain3', name: '3.0 Security Architecture', questions: 4, percentage: '18%', icon: Target },
    { id: 'domain4', name: '4.0 Security Operations', questions: 4, percentage: '28%', icon: Target },
    { id: 'domain5', name: '5.0 Security Program Management and Oversight', questions: 4, percentage: '20%', icon: Target },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-slate-900">Practice Quizzes</h1>
        <p className="text-slate-600 mt-2">Test your knowledge by domain or take the full mock exam</p>
      </div>

      {/* Mock Exam Card - Full Width */}
      <Card className="border-2 border-red-600 bg-gradient-to-br from-red-50 to-white">
        <CardContent className="p-6">
          <div className="flex items-start gap-4">
            <div className="w-14 h-14 bg-red-600 rounded-lg flex items-center justify-center flex-shrink-0">
              <FileText className="w-7 h-7 text-white" />
            </div>
            <div className="flex-1">
              <h3 className="text-xl font-bold text-slate-900 mb-2">Mock Exam Simulator</h3>
              <p className="text-slate-600 text-sm mb-4">
                Take a full-length practice test with 90 questions, 90-minute timer, and comprehensive scoring.
              </p>
              <button
                onClick={() => onSectionChange('mock')}
                className="bg-red-600 hover:bg-red-700 text-white font-semibold px-5 py-2.5 rounded-lg transition-all text-sm"
              >
                Start Mock Exam
              </button>
            </div>
          </div>
        </CardContent>
      </Card>

      <div>
        <h2 className="text-xl font-bold text-slate-900 mb-4">Practice by Domain</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {domains.map((domain) => {
            const Icon = domain.icon;
            return (
              <Card key={domain.id} className="border-2 border-slate-200 hover:border-red-600 transition-all cursor-pointer" onClick={() => onSectionChange(domain.id)}>
                <CardContent className="p-6">
                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 bg-slate-100 rounded-lg flex items-center justify-center flex-shrink-0">
                      <Icon className="w-6 h-6 text-slate-700" />
                    </div>
                    <div className="flex-1">
                      <h3 className="font-bold text-slate-900 mb-1">{domain.name}</h3>
                      <p className="text-sm text-slate-600 mb-3">
                        {domain.questions} practice questions • {domain.percentage} of exam
                      </p>
                      <div className="flex items-center gap-2">
                        <span className="text-xs font-semibold text-slate-700 bg-slate-100 px-3 py-1 rounded-full">
                          Beginner
                        </span>
                        <span className="text-xs font-semibold text-slate-700 bg-slate-100 px-3 py-1 rounded-full">
                          Intermediate
                        </span>
                        <span className="text-xs font-semibold text-slate-700 bg-slate-100 px-3 py-1 rounded-full">
                          Advanced
                        </span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>

      <Card className="border-2 border-slate-200">
        <CardContent className="p-8 text-center space-y-4">
          <BookOpen className="w-12 h-12 text-slate-400 mx-auto" />
          <h3 className="text-xl font-bold text-slate-900">How It Works</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-left max-w-3xl mx-auto">
            <div className="flex items-start gap-3">
              <CheckCircle2 className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
              <div>
                <p className="text-sm font-semibold text-slate-900">Choose Your Focus</p>
                <p className="text-xs text-slate-600">Select a domain or take the full exam</p>
              </div>
            </div>
            <div className="flex items-start gap-3">
              <CheckCircle2 className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
              <div>
                <p className="text-sm font-semibold text-slate-900">Select Difficulty</p>
                <p className="text-xs text-slate-600">Pick Beginner, Intermediate, or Advanced</p>
              </div>
            </div>
            <div className="flex items-start gap-3">
              <CheckCircle2 className="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
              <div>
                <p className="text-sm font-semibold text-slate-900">Review Results</p>
                <p className="text-xs text-slate-600">See your score and detailed explanations</p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}