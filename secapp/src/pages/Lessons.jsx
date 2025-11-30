import React, { useState } from 'react';
import QuizSidebar from '../components/quiz/QuizSidebar';
import Dashboard from '../components/quiz/Dashboard';
import DomainQuiz from '../components/quiz/DomainQuiz';
import MockExam from '../components/quiz/MockExam';
import WeakestSubjectQuiz from '../components/quiz/WeakestSubjectQuiz';
import { quizQuestions, getAllQuestions } from '../components/data/quizData';

export default function Lessons() {
  const urlParams = new URLSearchParams(window.location.search);
  const sectionParam = urlParams.get('section');
  const [selectedSection, setSelectedSection] = useState(sectionParam || 'dashboard');

  const domains = [
    {
      id: 'domain1',
      title: '1.0 General Security Concepts',
      description: 'Understanding security controls, principles, and foundational concepts',
      percentage: '12%'
    },
    {
      id: 'domain2',
      title: '2.0 Threats, Vulnerabilities, and Mitigations',
      description: 'Identifying threat actors, attack vectors, and security measures',
      percentage: '22%'
    },
    {
      id: 'domain3',
      title: '3.0 Security Architecture',
      description: 'Designing secure network architectures and implementing controls',
      percentage: '18%'
    },
    {
      id: 'domain4',
      title: '4.0 Security Operations',
      description: 'Managing security tools, monitoring, and identity management',
      percentage: '28%'
    },
    {
      id: 'domain5',
      title: '5.0 Security Program Management and Oversight',
      description: 'Incident response, digital forensics, and security governance',
      percentage: '20%'
    }
  ];

  const renderContent = () => {
    if (selectedSection === 'dashboard') {
      return <Dashboard onSectionChange={setSelectedSection} />;
    }

    if (selectedSection === 'mock') {
      return <MockExam allQuestions={getAllQuestions()} />;
    }

    if (selectedSection === 'weakest') {
      return <WeakestSubjectQuiz allQuestions={getAllQuestions()} />;
    }

    const domainMap = {
      domain1: { domain: domains[0], questions: quizQuestions.domain1 },
      domain2: { domain: domains[1], questions: quizQuestions.domain2 },
      domain3: { domain: domains[2], questions: quizQuestions.domain3 },
      domain4: { domain: domains[3], questions: quizQuestions.domain4 },
      domain5: { domain: domains[4], questions: quizQuestions.domain5 },
    };

    const selectedDomain = domainMap[selectedSection];
    if (selectedDomain) {
      return <DomainQuiz domain={selectedDomain.domain} questions={selectedDomain.questions} />;
    }

    return <Dashboard />;
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