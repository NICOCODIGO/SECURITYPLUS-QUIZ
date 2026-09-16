import React, { useState } from 'react';
import QuizSidebar from '../components/quiz/QuizSidebar';
import Dashboard from '../components/quiz/Dashboard';
import DomainQuiz from '../components/quiz/DomainQuiz';
import MockExam from '../components/quiz/MockExam';
import WeakestSubjectQuiz from '../components/quiz/WeakestSubjectQuiz';
import QuestionOfTheDay from '../components/quiz/QuestionOfTheDay';
import CustomQuizBuilder from '../components/quiz/CustomQuizBuilder';
import { quizQuestions, getAllQuestions } from '../components/data/quizData';
import { getDomainById } from '../components/data/securityDomains';

export default function Lessons() {
  const urlParams = new URLSearchParams(window.location.search);
  const sectionParam = urlParams.get('section');
  const [selectedSection, setSelectedSection] = useState(sectionParam || 'dashboard');

  const renderContent = () => {
    if (selectedSection === 'dashboard') {
      return <Dashboard onSectionChange={setSelectedSection} />;
    }

    if (selectedSection === 'daily') {
      return (
        <div className="space-y-6">
          <div>
            <h1 className="text-3xl font-black text-comptia-charcoal">Question of the Day</h1>
            <p className="text-slate-600 mt-2">
              One question, the same for everyone, refreshed every midnight. Keep the streak alive.
            </p>
          </div>
          <QuestionOfTheDay />
        </div>
      );
    }

    if (selectedSection === 'custom') {
      return <CustomQuizBuilder />;
    }

    if (selectedSection === 'mock') {
      return <MockExam allQuestions={getAllQuestions()} />;
    }

    if (selectedSection === 'weakest') {
      return <WeakestSubjectQuiz allQuestions={getAllQuestions()} />;
    }

    const domain = getDomainById(selectedSection);
    if (domain) {
      return (
        <DomainQuiz
          domain={{
            id: domain.id,
            title: domain.numberedTitle,
            description: domain.description,
            percentage: domain.weight,
          }}
          questions={quizQuestions[domain.id]}
        />
      );
    }

    return <Dashboard onSectionChange={setSelectedSection} />;
  };

  return (
    <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
      <div className="lg:col-span-1">
        <QuizSidebar selectedSection={selectedSection} onSectionChange={setSelectedSection} />
      </div>
      <div className="lg:col-span-3">
        {renderContent()}
      </div>
    </div>
  );
}