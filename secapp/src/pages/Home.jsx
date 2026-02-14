import React from 'react';
import hourglass from '../assets/home page/Hourglass.png';
import graphfork from '../assets/home page/graphfork.png';
import openbook from '../assets/home page/openbook.png';
import items from '../assets/home page/items.png';
import { Link } from 'react-router-dom';
import { createPageUrl } from "@/lib/utils";
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { BookOpen, Target, BarChart3, Shield, Lock, Globe, CheckCircle } from 'lucide-react';
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

  const topics = [
    '1.0 General Security Concepts',
    '2.0 Threats, Vulnerabilities, and Mitigations',
    '3.0 Security Architecture',
    '4.0 Security Operations',
    '5.0 Security Program Management and Oversight',
  ];

  return (
    <div className="space-y-16 -mt-8">

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

      {/* Features Section */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <Card className="border-2 border-red-600 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-12 space-y-8">
            
            <div className="text-center">
              <h2 className="text-4xl font-black text-slate-900 uppercase">Everything You Need to Pass</h2>
              <p className="text-lg text-slate-600 mt-3">Comprehensive tools and resources designed to help you master every aspect of the Security+ exam</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {features.map((feature, i) => (
                <Card
                  key={i}
                  className="border-2 border-slate-200 hover:border-red-600 hover:shadow-xl transition-all bg-slate-50 rounded-2xl"
                >
                  <CardContent className="p-6 text-center space-y-3">
                    <div className="w-16 h-16 bg-red-600 rounded-xl flex items-center justify-center mx-auto shadow-lg">
                      <img
                        src={feature.icon}
                        alt=""
                        className="w-9 h-9 object-contain"
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

      {/* Topics Section */}
      <section className="bg-slate-100 rounded-2xl p-12 space-y-8 max-w-7xl mx-auto px-4">
        <div>
          <h2 className="text-3xl font-bold text-slate-900">What You'll Learn</h2>
          <p className="text-slate-600 mt-2">Comprehensive coverage of all Security+ domains</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-4xl">
          {topics.map((topic, i) => (
            <div key={i} className="flex items-center gap-3">
              <div className="w-6 h-6 bg-red-600 rounded-full flex items-center justify-center">
                <CheckCircle className="w-4 h-4 text-white" />
              </div>
              <span className="text-slate-900">{topic}</span>
            </div>
          ))}
        </div>
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
