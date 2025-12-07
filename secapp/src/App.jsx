// src/App.jsx
import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './Layout';
import Home from './pages/Home';
import AboutCertification from './pages/AboutCertification';
import Lessons from './pages/Lessons';
import LessonDetail from './pages/LessonDetail';
import Progress from './pages/Progress';
import AdminContentManager from './pages/AdminContentManager';
import TakeQuiz from './pages/TakeQuiz';

export default function App() {
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
