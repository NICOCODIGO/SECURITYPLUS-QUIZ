import React from 'react';
import hourglass from '../assets/home page/Hourglass.png';
import graphfork from '../assets/home page/graphfork.png';
import openbook from '../assets/home page/openbook.png';
import items from '../assets/home page/items.png';
import lock from '../assets/home page/lock.png';
import locked from '../assets/home page/locked.png';
import clipboard from '../assets/home page/clipboard.png';
import database from '../assets/home page/database.png';
import warning from '../assets/home page/warning.png';
import { Link } from 'react-router-dom';
import { createPageUrl } from "@/lib/utils";
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { BookOpen, Target, BarChart3, Shield, Lock, Globe, CheckCircle, CheckCircle2, Clock, Award, TrendingUp, ArrowRight } from 'lucide-react';
import { lessons } from '../components/data/lessonsData';
import { getCompletedLessonsCount } from '../components/data/progressData';

export default function Home() {
  const completedLessons = getCompletedLessonsCount();
  const completionRate = lessons.length > 0 ? Math.round((completedLessons / lessons.length) * 100) : 0;

  const features = [
    { icon: openbook, title: 'Practice Exams', description: 'Full-length simulated exams that mirror the real SY0-701 test environment with the same format, difficulty, and time constraints.' },
    { icon: items, title: 'Domain Breakdown', description: 'Targeted practice for each Security+ domain with weighted questions that match the official exam distribution.' },
    { icon: hourglass, title: 'Realistic Exam Mode', description: 'Timed practice sessions with the exact 90-minute format, instant scoring, and comprehensive explanations for every question.' },
    { icon: graphfork, title: 'Exam Analytics', description: 'Track your progress across all five domains with detailed insights into strengths, weaknesses, and improvement trends over time.' },
  ];

  return (
    <div className="relative space-y-16 -mt-8">

      {/* Hero Section */}
      <section className="relative text-center space-y-8 py-24 px-4 sm:px-6 lg:px-8 overflow-hidden rounded-xl">

        {/* Background */}
        <div className="absolute inset-0 bg-gradient-to-br from-slate-900 via-red-900 to-slate-800 opacity-95"></div>
        <div
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=1920&q=80)',
            backgroundSize: 'cover',
            backgroundPosition: 'center'
          }}
        ></div>

        {/* Content */}
        <div className="relative z-10 max-w-6xl mx-auto">

          <div className="inline-flex items-center gap-2 bg-red-600/20 backdrop-blur-sm px-5 py-2.5 rounded-full border-2 border-red-400/50">
            <Shield className="w-5 h-5 text-red-300" />
            <span className="text-sm font-bold text-red-200 uppercase">CompTIA Security+ Certification</span>
          </div>

          <h1 className="text-5xl md:text-7xl font-black text-white mt-8 leading-tight">
            Unlock Your Potential <br />
            <span className="text-red-400">In Tech</span>
          </h1>

          <p className="text-xl text-slate-200 max-w-3xl mx-auto mt-6">
            Together we will get you the tech career you deserve with industry-leading certifications, training, and expert knowledge.
          </p>

          {/* Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center pt-8">
            <Link to="/lessons">
              <Button size="lg" className="bg-red-600 hover:bg-red-700 text-white px-10 py-7 text-lg font-bold shadow-lg hover:shadow-xl rounded-lg uppercase tracking-wide">
                Start Learning
              </Button>
            </Link>

            <Link to="/resources">
              <Button size="lg" className="bg-red-600 hover:bg-red-700 text-white px-10 py-7 text-lg font-bold shadow-lg hover:shadow-xl rounded-lg uppercase tracking-wide">
                Resources
              </Button>
            </Link>
          </div>

          {/* Progress Card */}
          {completedLessons > 0 && (
            <div className="pt-8">
              <Card className="max-w-xl mx-auto bg-white/95 backdrop-blur-sm border-2 border-white/50 shadow-2xl">
                <CardContent className="p-8">
                  <div className="grid grid-cols-3 gap-6 text-center">
                    <div>
                      <p className="text-sm font-bold text-slate-600 uppercase mb-2">Progress</p>
                      <p className="text-4xl font-black text-red-600">{completionRate}%</p>
                    </div>
                    <div className="border-l-2 border-r-2 border-slate-200">
                      <p className="text-sm font-bold text-slate-600 uppercase mb-2">Completed</p>
                      <p className="text-4xl font-black text-slate-900">{completedLessons}</p>
                    </div>
                    <div>
                      <p className="text-sm font-bold text-slate-600 uppercase mb-2">Total</p>
                      <p className="text-4xl font-black text-slate-900">{lessons.length}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          )}

        </div>
      </section>

      {/* What You'll Learn Section */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        {/* Header - OUTSIDE the card */}
        <div className="text-center space-y-2">
          <h2 className="text-3xl md:text-4xl font-black text-slate-900">
            What You'll Learn
          </h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Master all five domains of the CompTIA Security+ SY0-701 exam with weighted practice questions
          </p>
        </div>

        {/* Card with ONLY domain cards inside */}
        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-12">

            {/* Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-6 gap-x-8 gap-y-16 justify-items-center">
              {[
                {
                  domain: 'Domain 1.0',
                  weight: '12%',
                  title: 'General Security Concepts',
                  topics: 'CIA Triad, Authentication, Cryptography Basics, Security Controls',
                  icon: lock,
                  ringColor: 'border-purple-600',
                  badgeColor: 'text-purple-700 bg-purple-100 border-purple-200',
                  hoverBorder: 'hover:border-purple-600',
                },
                {
                  domain: 'Domain 2.0',
                  weight: '22%',
                  title: 'Threats, Vulnerabilities, and Mitigations',
                  topics: 'Malware, Attacks, Vulnerability Management, Threat Intelligence',
                  icon: warning,
                  ringColor: 'border-red-600',
                  badgeColor: 'text-red-700 bg-red-100 border-red-200',
                  hoverBorder: 'hover:border-red-600',
                },
                {
                  domain: 'Domain 3.0',
                  weight: '18%',
                  title: 'Security Architecture',
                  topics: 'Network Security, Cloud Security, Infrastructure Security',
                  icon: locked,
                  ringColor: 'border-sky-400',
                  badgeColor: 'text-sky-600 bg-sky-100 border-sky-200',
                  hoverBorder: 'hover:border-sky-400',
                },
                {
                  domain: 'Domain 4.0',
                  weight: '28%',
                  title: 'Security Operations',
                  topics: 'Monitoring, Incident Response, Digital Forensics, SIEM',
                  icon: database,
                  ringColor: 'border-yellow-500',
                  badgeColor: 'text-yellow-800 bg-yellow-200 border-yellow-300',
                  hoverBorder: 'hover:border-yellow-500',
                },
                {
                  domain: 'Domain 5.0',
                  weight: '20%',
                  title: 'Security Program Management',
                  topics: 'Governance, Risk Management, Compliance, Privacy',
                  icon: clipboard,
                  ringColor: 'border-green-600',
                  badgeColor: 'text-green-700 bg-green-100 border-green-200',
                  hoverBorder: 'hover:border-green-600',
                },
              ].map((d, i) => (
                <Card
                  key={i}
                  className={`relative w-full max-w-sm bg-slate-50 rounded-2xl border-2 border-slate-200 shadow-sm ${d.hoverBorder} hover:shadow-xl transition-all
                    lg:col-span-2
                    ${i === 3 ? 'lg:col-start-2' : ''}
                    ${i === 4 ? 'lg:col-start-4' : ''}
                  `}
                >
                  <CardContent className="pt-14 pb-4 px-8 text-center space-y-3">
                    {/* Floating icon */}
                    <div className="absolute left-1/2 -top-10 -translate-x-1/2">
                      <div className={`w-20 h-20 rounded-full bg-white border-4 ${d.ringColor} shadow-md flex items-center justify-center`}>
                        <img src={d.icon} alt={d.title} className="w-12 h-12" />
                      </div>
                    </div>

                    <p className="text-sm font-semibold text-slate-500">{d.domain}</p>

                    <h3 className="text-xl font-black text-slate-900 leading-snug">
                      {d.title}
                    </h3>

                    <p className="text-sm text-slate-600 leading-relaxed">
                      {d.topics}
                    </p>

                    {/* Weight badge */}
                    <div className="pt-2">
                      <span className={`text-xs font-bold ${d.badgeColor} border px-4 py-1.5 rounded-full`}>
                        {d.weight} of Exam
                      </span>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>

          </CardContent>
        </Card>
      </section>

      {/* Features Section */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        {/* Header - OUTSIDE the card */}
        <div className="text-center">
          <h2 className="text-4xl font-black text-slate-900 uppercase">Everything You Need to Pass</h2>
          <p className="text-lg text-slate-600 mt-3">Comprehensive tools and resources designed to help you master every aspect of the Security+ exam</p>
        </div>

        {/* Card with ONLY feature cards inside */}
        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-12">

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {features.map((feature, i) => (
                <Card
                  key={i}
                  className="border-2 border-slate-200 hover:border-red-600 hover:shadow-xl transition-all bg-slate-50 rounded-2xl"
                >
                  <CardContent className="p-6 text-center space-y-3">
                    <div className="w-16 h-16 rounded-xl flex items-center justify-center mx-auto">
                      <img
                        src={feature.icon}
                        alt=""
                        className="w-12 h-12 object-contain"
                      />
                    </div>

                    <h3 className="font-bold text-slate-900 text-lg">
                      {feature.title}
                    </h3>

                    <p className="text-sm text-slate-600">
                      {feature.description}
                    </p>
                  </CardContent>
                </Card>
              ))}
            </div>

          </CardContent>
        </Card>
      </section>

      {/* Dashboard Preview Section */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-3">
          <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
            <TrendingUp className="w-5 h-5 text-red-600" />
            <span className="text-sm font-bold text-red-700 uppercase tracking-wide">Track Your Progress</span>
          </div>
          <h2 className="text-3xl md:text-4xl font-black text-slate-900">
            See Your Growth in Real-Time
          </h2>
          <p className="text-lg text-slate-600 max-w-2xl mx-auto">
            Our intelligent dashboard tracks every practice session, highlighting your strengths and pinpointing areas that need improvement.
          </p>
        </div>

        {/* Dashboard Mockup */}
        <Card className="border-2 border-slate-200 shadow-2xl rounded-2xl overflow-hidden bg-white">
          <CardContent className="p-8 space-y-6">
            
            {/* Mock Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              {/* Lessons Completed */}
              <div className="bg-gradient-to-br from-green-50 to-green-100 border-2 border-green-200 rounded-xl p-5 space-y-2">
                <div className="flex items-center justify-between">
                  <p className="text-xs font-bold text-green-700 uppercase">Lessons Completed</p>
                  <div className="w-10 h-10 bg-green-600 rounded-lg flex items-center justify-center">
                    <CheckCircle2 className="w-5 h-5 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-black text-slate-900">4/6</p>
                <p className="text-xs text-green-700">67% complete</p>
              </div>

              {/* Average Quiz Score */}
              <div className="bg-gradient-to-br from-blue-50 to-blue-100 border-2 border-blue-200 rounded-xl p-5 space-y-2">
                <div className="flex items-center justify-between">
                  <p className="text-xs font-bold text-blue-700 uppercase">Average Quiz Score</p>
                  <div className="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center">
                    <Target className="w-5 h-5 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-black text-slate-900">87%</p>
                <p className="text-xs text-blue-700">Keep up the good work!</p>
              </div>

              {/* Time Spent */}
              <div className="bg-gradient-to-br from-amber-50 to-amber-100 border-2 border-amber-200 rounded-xl p-5 space-y-2">
                <div className="flex items-center justify-between">
                  <p className="text-xs font-bold text-amber-700 uppercase">Time Spent</p>
                  <div className="w-10 h-10 bg-amber-600 rounded-lg flex items-center justify-center">
                    <Clock className="w-5 h-5 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-black text-slate-900">12h</p>
                <p className="text-xs text-amber-700">Total learning time</p>
              </div>

              {/* Completion Rate */}
              <div className="bg-gradient-to-br from-purple-50 to-purple-100 border-2 border-purple-200 rounded-xl p-5 space-y-2">
                <div className="flex items-center justify-between">
                  <p className="text-xs font-bold text-purple-700 uppercase">Completion Rate</p>
                  <div className="w-10 h-10 bg-purple-600 rounded-lg flex items-center justify-center">
                    <Award className="w-5 h-5 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-black text-slate-900">67%</p>
                <p className="text-xs text-purple-700">Keep up the great work!</p>
              </div>
            </div>

            {/* View Dashboard Button */}
            <div className="text-center pt-4">
              <Link to="/progress">
                <Button className="bg-red-600 hover:bg-red-700 text-white px-8 py-6 text-base font-bold rounded-lg shadow-lg hover:shadow-xl inline-flex items-center gap-2">
                  View Your Dashboard
                  <ArrowRight className="w-5 h-5" />
                </Button>
              </Link>
            </div>

          </CardContent>
        </Card>
      </section>

      {/* CTA Section */}
      <section className="text-center space-y-6 py-16 max-w-7xl mx-auto px-4">
        <Card className="bg-red-600 border-4 border-slate-300 shadow-2xl rounded-xl">
          <CardContent className="p-16 text-white space-y-6">
            <h2 className="text-4xl md:text-5xl font-black uppercase">Master Security+ Certification</h2>
            <p className="text-xl max-w-2xl mx-auto">
              Get the skills and knowledge you need to pass the CompTIA Security+ SY0-701 exam.
            </p>
            <Link to="/lessons">
              <Button size="lg" className="bg-white text-red-600 hover:bg-slate-100 px-10 py-7 text-lg font-bold rounded-lg shadow-xl uppercase tracking-wide">
                Start Studying
              </Button>
            </Link>
          </CardContent>
        </Card>
      </section>

    </div>
  );
}