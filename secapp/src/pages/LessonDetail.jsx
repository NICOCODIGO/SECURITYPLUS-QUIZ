import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { createPageUrl } from "@/lib/utils";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ArrowLeft, CheckCircle2, Clock } from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import { getLessonById } from '../components/data/lessonsData';
import { getProgressByLessonId, markLessonComplete } from '../components/data/progressData';

export default function LessonDetail() {
  const urlParams = new URLSearchParams(window.location.search);
  const lessonId = urlParams.get('id');
  
  const [lesson, setLesson] = useState(null);
  const [progress, setProgress] = useState(null);

  useEffect(() => {
    const lessonData = getLessonById(lessonId);
    const progressData = getProgressByLessonId(lessonId);
    setLesson(lessonData);
    setProgress(progressData);
  }, [lessonId]);

  const handleMarkComplete = () => {
    markLessonComplete(lessonId);
    setProgress(getProgressByLessonId(lessonId));
  };

  const isCompleted = progress?.completed || false;

  const difficultyColors = {
    Beginner: 'bg-green-100 text-green-700 border-green-200',
    Intermediate: 'bg-amber-100 text-amber-700 border-amber-200',
    Advanced: 'bg-red-100 text-red-700 border-red-200',
  };

  if (!lesson) {
    return (
      <Card className="border-slate-200">
        <CardContent className="p-12 text-center">
          <p className="text-slate-600">Lesson not found</p>
          <Link to={createPageUrl('Lessons')}>
            <Button className="mt-4" variant="outline">
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Lessons
            </Button>
          </Link>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-6">
      {/* Back Button */}
      <Link to={createPageUrl('Lessons')}>
        <Button variant="ghost" className="hover:bg-slate-100">
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to Lessons
        </Button>
      </Link>

      {/* Lesson Header */}
      <Card className="border-slate-200 shadow-lg">
        <CardHeader className="space-y-4">
          <div className="flex items-start justify-between gap-4">
            <CardTitle className="text-3xl font-bold text-slate-900">
              {lesson.title}
            </CardTitle>
            {isCompleted && (
              <div className="flex items-center gap-2 bg-green-600 px-4 py-2 rounded-lg shadow-lg">
                <CheckCircle2 className="w-5 h-5 text-white" />
                <span className="text-sm font-bold text-white uppercase tracking-wide">Completed</span>
              </div>
            )}
          </div>

          <div className="flex flex-wrap gap-2">
            <Badge variant="outline" className={`${difficultyColors[lesson.difficulty]} border`}>
              {lesson.difficulty}
            </Badge>
            {lesson.duration && (
              <Badge variant="outline" className="bg-slate-100 text-slate-700 border-slate-200">
                <Clock className="w-3 h-3 mr-1" />
                {lesson.duration}
              </Badge>
            )}
            {lesson.category && (
              <Badge variant="outline" className="bg-blue-50 text-blue-700 border-blue-200">
                {lesson.category}
              </Badge>
            )}
          </div>

          {lesson.description && (
            <p className="text-lg text-slate-600 leading-relaxed">{lesson.description}</p>
          )}
        </CardHeader>
      </Card>

      {/* Lesson Content */}
      <Card className="border-slate-200 shadow-lg">
        <CardContent className="p-8 md:p-12">
          <div className="prose prose-slate max-w-none">
            <ReactMarkdown
              components={{
                h1: ({ children }) => <h1 className="text-3xl font-bold text-slate-900 mb-4 mt-8">{children}</h1>,
                h2: ({ children }) => <h2 className="text-2xl font-bold text-slate-900 mb-3 mt-6">{children}</h2>,
                h3: ({ children }) => <h3 className="text-xl font-semibold text-slate-900 mb-2 mt-4">{children}</h3>,
                p: ({ children }) => <p className="text-slate-700 leading-relaxed mb-4">{children}</p>,
                ul: ({ children }) => <ul className="list-disc list-inside space-y-2 mb-4 text-slate-700">{children}</ul>,
                ol: ({ children }) => <ol className="list-decimal list-inside space-y-2 mb-4 text-slate-700">{children}</ol>,
                code: ({ inline, children }) => 
                  inline ? (
                    <code className="px-2 py-1 bg-slate-100 rounded text-sm text-blue-600">{children}</code>
                  ) : (
                    <code className="block p-4 bg-slate-900 text-slate-100 rounded-lg overflow-x-auto">{children}</code>
                  ),
              }}
            >
              {lesson.content}
            </ReactMarkdown>
          </div>
        </CardContent>
      </Card>

      {/* Actions */}
      <Card className="border-slate-200 shadow-lg">
        <CardContent className="p-6">
          <div className="flex flex-col sm:flex-row gap-4">
            <Button
              onClick={handleMarkComplete}
              disabled={isCompleted}
              className="flex-1 bg-green-600 hover:bg-green-700 text-white h-12"
            >
              <CheckCircle2 className="w-5 h-5 mr-2" />
              {isCompleted ? 'Completed' : 'Mark as Complete'}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}