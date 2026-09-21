// src/App.jsx
import React, { useEffect } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { hydrate as hydrateQuestionBank } from './components/data/questionBank';
import Layout from './Layout';
import Home from './pages/Home';
import AboutCertification from './pages/AboutCertification';
import Lessons from './pages/Lessons';
import LessonDetail from './pages/LessonDetail';
import Progress from './pages/Progress';
import AdminContentManager from './pages/AdminContentManager';
import TakeQuiz from './pages/TakeQuiz';
import DailyQuestion from './pages/DailyQuestion';

export default function App() {
  // Swap the bundled question bank for the API's copy once, on boot. Resolves
  // immediately and changes nothing when VITE_API_URL is unset, which is the
  // supported default — the app must work with no back end at all.
  useEffect(() => {
    hydrateQuestionBank();
  }, []);

  return (
    <BrowserRouter>
      <Routes>

        {/* Home */}
        <Route 
          path="/" 
          element={
            <Layout currentPageName="Home">
              <Home />
            </Layout>
          } 
        />

        {/* About */}
        <Route 
          path="/about" 
          element={
            <Layout currentPageName="AboutCertification">
              <AboutCertification />
            </Layout>
          } 
        />

        {/* Lessons */}
        <Route 
          path="/lessons" 
          element={
            <Layout currentPageName="Lessons">
              <Lessons />
            </Layout>
          } 
        />

        {/* Single Lesson */}
        <Route 
          path="/lesson/:id" 
          element={
            <Layout currentPageName="LessonDetail">
              <LessonDetail />
            </Layout>
          } 
        />

        {/* Progress */}
        <Route 
          path="/progress" 
          element={
            <Layout currentPageName="Progress">
              <Progress />
            </Layout>
          } 
        />

        {/* Resources */}
        <Route 
          path="/resources" 
          element={
            <Layout currentPageName="AdminContentManager">
              <AdminContentManager />
            </Layout>
          } 
        />

        {/* Question of the Day, full screen like a quiz */}
        <Route
          path="/daily"
          element={
            <Layout currentPageName="DailyQuestion">
              <DailyQuestion />
            </Layout>
          }
        />

        {/* Quiz route (existing /quiz path) */}
        <Route 
          path="/quiz" 
          element={
            <Layout currentPageName="TakeQuiz">
              <TakeQuiz />
            </Layout>
          } 
        />

        {/* Quiz route used by Start Quiz buttons: /TakeQuiz?… */}
        <Route 
          path="/TakeQuiz" 
          element={
            <Layout currentPageName="TakeQuiz">
              <TakeQuiz />
            </Layout>
          } 
        />

      </Routes>
    </BrowserRouter>
  );
}
