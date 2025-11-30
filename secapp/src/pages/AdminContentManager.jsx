import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { BookOpen, Video, FileText, BookMarked, ExternalLink, Youtube, Globe } from 'lucide-react';

export default function StudyResources() {
  const resources = [
    {
      title: 'Professor Messer',
      description: 'Free comprehensive Security+ video course covering all exam objectives with detailed explanations.',
      url: 'https://www.professormesser.com/security-plus/sy0-701/sy0-701-video/sy0-701-comptia-security-plus-course/',
      icon: Youtube,
      category: 'Video Course',
      color: 'bg-red-600'
    },
    {
      title: 'CompTIA Official Study Guide',
      description: 'The official study guide from CompTIA with practice questions and comprehensive coverage.',
      url: 'https://www.comptia.org/certifications/security',
      icon: BookMarked,
      category: 'Official Material',
      color: 'bg-blue-600'
    },
    {
      title: 'Jason Dion Practice Exams',
      description: 'Highly-rated practice exams on Udemy with detailed explanations for each question.',
      url: 'https://www.udemy.com/course/securityplus/',
      icon: FileText,
      category: 'Practice Tests',
      color: 'bg-purple-600'
    },
    {
      title: 'CompTIA Security+ Get Certified Get Ahead: SY0-701',
      description: 'Comprehensive study guide by Darril Gibson and Joe Shelley with clear explanations and practice questions.',
      url: 'https://www.amazon.com/CompTIA-Security-Get-Certified-Ahead/dp/B0CM13W88J',
      icon: BookOpen,
      category: 'Study Guide',
      color: 'bg-green-600'
    }
  ];

  const studyTips = [
    {
      title: 'Create a Study Schedule',
      description: 'Dedicate 1-2 hours daily for consistent progress over 6-8 weeks.'
    },
    {
      title: 'Use Multiple Resources',
      description: 'Combine video courses, practice tests, and hands-on labs for comprehensive learning.'
    },
    {
      title: 'Practice, Practice, Practice',
      description: 'Take multiple practice exams to identify weak areas and build confidence.'
    },
    {
      title: 'Join Study Groups',
      description: 'Connect with other learners on Reddit, Discord, or CompTIA forums for support.'
    }
  ];

  return (
    <div className="max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 space-y-8">
      <div className="text-center space-y-4">
        <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
          <BookOpen className="w-5 h-5 text-red-600" />
          <span className="text-sm font-bold text-red-700 uppercase tracking-wide">Study Resources</span>
        </div>
        <h1 className="text-5xl font-black text-slate-900 uppercase tracking-tight">Where to Study</h1>
        <p className="text-lg text-slate-700 font-medium max-w-2xl mx-auto">
          Curated list of the best resources to help you prepare for the CompTIA Security+ SY0-701 certification
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {resources.map((resource, index) => {
          const Icon = resource.icon;
          return (
            <Card key={index} className="border-2 border-slate-200 hover:border-red-600 transition-all hover:shadow-xl group">
              <CardHeader>
                <div className="flex items-start gap-4">
                  <div className={`${resource.color} w-14 h-14 rounded-xl flex items-center justify-center flex-shrink-0 shadow-lg group-hover:scale-110 transition-transform`}>
                    <Icon className="w-7 h-7 text-white" />
                  </div>
                  <div className="flex-1">
                    <div className="flex items-start justify-between">
                      <CardTitle className="text-xl font-bold text-slate-900">{resource.title}</CardTitle>
                      <ExternalLink className="w-5 h-5 text-slate-400 group-hover:text-red-600 transition-colors" />
                    </div>
                    <span className="inline-block mt-1 text-xs font-semibold px-3 py-1 bg-slate-100 text-slate-700 rounded-full">
                      {resource.category}
                    </span>
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <p className="text-slate-600 mb-4">{resource.description}</p>
                <a
                  href={resource.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 text-red-600 font-semibold hover:underline"
                >
                  Visit Resource
                  <ExternalLink className="w-4 h-4" />
                </a>
              </CardContent>
            </Card>
          );
        })}
      </div>

      <Card className="border-2 border-slate-200 bg-gradient-to-br from-slate-50 to-white">
        <CardHeader>
          <CardTitle className="text-2xl font-bold text-slate-900">Study Tips for Success</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {studyTips.map((tip, index) => (
              <div key={index} className="flex gap-4">
                <div className="w-10 h-10 bg-red-600 rounded-lg flex items-center justify-center flex-shrink-0">
                  <span className="text-white font-bold text-lg">{index + 1}</span>
                </div>
                <div>
                  <h3 className="font-bold text-slate-900 mb-1">{tip.title}</h3>
                  <p className="text-sm text-slate-600">{tip.description}</p>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      <Card className="border-2 border-blue-200 bg-blue-50">
        <CardContent className="p-6">
          <div className="flex items-start gap-4">
            <BookOpen className="w-8 h-8 text-blue-600 flex-shrink-0 mt-1" />
            <div>
              <h3 className="text-lg font-bold text-slate-900 mb-2">Recommended Study Path</h3>
              <ol className="space-y-2 text-sm text-slate-700">
                <li className="flex items-start gap-2">
                  <span className="font-bold text-blue-600 flex-shrink-0">1.</span>
                  <span>Watch Professor Messer's free video course (approx. 20 hours)</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="font-bold text-blue-600 flex-shrink-0">2.</span>
                  <span>Read through the CompTIA official study guide</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="font-bold text-blue-600 flex-shrink-0">3.</span>
                  <span>Take practice tests to identify weak areas</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="font-bold text-blue-600 flex-shrink-0">4.</span>
                  <span>Review weak areas with additional resources</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="font-bold text-blue-600 flex-shrink-0">5.</span>
                  <span>Take full-length mock exams until scoring 85%+</span>
                </li>
              </ol>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}