import React, { useMemo, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import QuizSidebar from '../components/quiz/QuizSidebar';
import Dashboard from '../components/quiz/Dashboard';
import DomainQuiz from '../components/quiz/DomainQuiz';
import MockExam from '../components/quiz/MockExam';
import WeakestSubjectQuiz from '../components/quiz/WeakestSubjectQuiz';
import CustomQuizBuilder from '../components/quiz/CustomQuizBuilder';
import { quizQuestions, getAllQuestions } from '../components/data/quizData';
import { getDomainById } from '../components/data/securityDomains';
import { getQuizHistory, getDomainPerformance } from '../components/data/quizHistoryData';

/**
 * The Practice page (routed at /lessons for existing links).
 *
 * A floating header card, then section navigation beside the content. `?section=` picks the starting section and is kept in sync as
 * you switch, so a reload or shared link lands in the same place.
 *
 * The header card scrolls away with the page: it was sticky for a while, but
 * a frozen 126px card under the nav took too much of the screen for a title.
 * Your numbers live on the Progress page rather than in it.
 *
 * Question of the Day is not a section here — it has its own full screen at
 * /daily, reached from the dashboard's strip.
 */
export default function Lessons() {
  const navigate = useNavigate();
  const [selectedSection, setSelectedSection] = useState(() => {
    const section = new URLSearchParams(window.location.search).get('section');
    // ?section=daily is an old link from when the daily question was a
    // section here; the Overview carries the strip that opens /daily.
    return !section || section === 'daily' ? 'dashboard' : section;
  });
  const contentRef = useRef(null);

  const history = useMemo(() => getQuizHistory(), []);
  const performance = useMemo(() => getDomainPerformance(history), [history]);
  const accuracyByDomain = useMemo(
    () => new Map(performance.rows.filter((row) => row.domain).map((row) => [row.domain.id, row.accuracy])),
    [performance]
  );

  const changeSection = (id) => {
    setSelectedSection(id);
    // Search-only navigation keeps this page mounted, and ScrollToTop only
    // reacts to path and hash changes.
    navigate({ search: `?section=${id}` }, { replace: true });

    // Switching from far down the page would otherwise leave you looking at
    // the middle of the new section. 96px clears the sticky nav.
    const top = contentRef.current?.getBoundingClientRect().top;
    if (top !== undefined && top < 96) {
      window.scrollTo({ top: window.scrollY + top - 96, behavior: 'smooth' });
    }
  };

  const renderContent = () => {
    if (selectedSection === 'dashboard') {
      return <Dashboard onSectionChange={changeSection} />;
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

    return <Dashboard onSectionChange={changeSection} />;
  };

  return (
    <div className="space-y-6">
      {/* A floating card the width of the content below it, not a full-bleed
          band. Just the page's name: the numbers that used to sit on the right
          belong to Progress, which the Overview links to. */}
      <section className="rounded-2xl border border-slate-200 bg-white shadow-md px-5 sm:px-6 py-5">
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Quiz center</p>
        <h1 className="text-2xl md:text-3xl font-black text-comptia-charcoal mt-1">Practice</h1>
        <p className="text-slate-600 mt-1">
          Short domain quizzes, a full mock exam, and practice built around your mistakes.
        </p>
      </section>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-[15rem_minmax(0,1fr)] lg:items-start">
        <QuizSidebar
          selectedSection={selectedSection}
          onSectionChange={changeSection}
          accuracyByDomain={accuracyByDomain}
        />
        <div ref={contentRef} className="min-w-0">
          {renderContent()}
        </div>
      </div>
    </div>
  );
}
