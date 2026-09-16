import React from 'react';
import hourglass from '../assets/home page/hourglass.png';
import graphfork from '../assets/home page/graphfork.png';
import openbook from '../assets/home page/openbook.png';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Shield, TrendingUp, ArrowRight } from 'lucide-react';
import ProgressPreview from '../components/previews/ProgressPreview';
import ExamBlueprint from '../components/domains/ExamBlueprint';
import { lessons } from '../components/data/lessonsData';
import { getCompletedLessonsCount } from '../components/data/progressData';

export default function Home() {
  const completedLessons = getCompletedLessonsCount();
  const completionRate = lessons.length > 0 ? Math.round((completedLessons / lessons.length) * 100) : 0;

  const steps = [
    {
      number: '01',
      icon: openbook,
      title: 'Study the Domains',
      description:
        'Work through all 5 Security+ domains with structured lessons covering everything from threat analysis to security architecture.',
      cta: 'Go to Lessons',
      href: '/lessons',
      ringColor: 'border-red-600',
      numberColor: 'text-red-600',
    },
    {
      number: '02',
      icon: hourglass,
      title: 'Test Your Knowledge',
      description:
        'Take timed quizzes for each domain. Questions are weighted to match the real SY0-701 exam, with instant explanations on every answer.',
      cta: 'Take a Quiz',
      href: '/quiz',
      ringColor: 'border-comptia-charcoal',
      numberColor: 'text-comptia-charcoal',
    },
    {
      number: '03',
      icon: graphfork,
      title: 'Track Your Growth',
      description:
        'Your dashboard shows exactly where you stand — lessons completed, average scores, time spent, and which domains need more work.',
      cta: 'View Progress',
      href: '/progress',
      ringColor: 'border-green-600',
      numberColor: 'text-green-600',
    },
  ];

  return (
    <div className="relative space-y-16 -mt-8">

      {/* ── Hero ───────────────────────────────────────────── */}
      <section className="relative text-center space-y-8 py-24 px-4 sm:px-6 lg:px-8 overflow-hidden rounded-xl">

        <div className="absolute inset-0 bg-gradient-to-br from-comptia-charcoal via-comptia-charcoal-light to-comptia-charcoal" />
        <div
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=1920&q=80)',
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />

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

          <div className="flex flex-col sm:flex-row gap-4 justify-center pt-8">
            <Link to="/lessons">
              <Button size="lg" className="bg-red-600 hover:bg-red-700 text-white px-10 py-7 text-lg font-bold shadow-lg hover:shadow-xl rounded-lg uppercase tracking-wide">
                Start Learning
              </Button>
            </Link>
            <Link to="/about">
              <Button
                size="lg"
                variant="outline"
                className="bg-transparent hover:bg-white/10 text-white border-2 border-white/60 hover:border-white px-10 py-7 text-lg font-bold rounded-lg uppercase tracking-wide"
              >
                About the Exam
              </Button>
            </Link>
          </div>

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
                      <p className="text-4xl font-black text-comptia-charcoal">{completedLessons}</p>
                    </div>
                    <div>
                      <p className="text-sm font-bold text-slate-600 uppercase mb-2">Total</p>
                      <p className="text-4xl font-black text-comptia-charcoal">{lessons.length}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          )}
        </div>
      </section>

      {/* ── How It Works ───────────────────────────────────── */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-2">
          <h2 className="text-3xl md:text-4xl font-black text-comptia-charcoal uppercase">
            How It Works
          </h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Three steps to go from zero to Security+ certified.
          </p>
        </div>

        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-12">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-12 relative">
              {/* Desktop connector lines */}
              <div className="hidden md:block absolute top-[4.5rem] left-[calc(33.33%+2rem)] right-[calc(33.33%+2rem)] h-0.5 bg-slate-200 z-0" />

              {steps.map((step, i) => (
                <div key={i} className="relative z-10 flex flex-col items-center text-center space-y-4">
                  <p className={`text-7xl font-black leading-none ${step.numberColor}`}>{step.number}</p>

                  <div className={`w-24 h-24 rounded-full bg-white border-4 ${step.ringColor} shadow-md flex items-center justify-center`}>
                    <img src={step.icon} alt={step.title} className="w-14 h-14 object-contain" />
                  </div>

                  <h3 className="text-xl font-black text-comptia-charcoal">{step.title}</h3>
                  <p className="text-sm text-slate-600 leading-relaxed">{step.description}</p>

                  <Link to={step.href}>
                    <Button
                      variant="outline"
                      className="border-2 border-slate-300 hover:border-red-600 hover:text-red-600 font-bold text-sm rounded-lg gap-2 mt-2"
                    >
                      {step.cta}
                      <ArrowRight className="w-4 h-4" />
                    </Button>
                  </Link>
                </div>
              ))}
            </div>

            <div className="mt-10 pt-8 border-t-2 border-slate-100 text-center">
              <p className="text-sm text-slate-500">
                New to Security+?{' '}
                <Link to="/about" className="font-bold text-red-600 hover:underline">
                  Learn what the certification covers and if it's right for you →
                </Link>
              </p>
            </div>
          </CardContent>
        </Card>
      </section>

      {/* ── Exam Blueprint ─────────────────────────────────── */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-3">
          <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
            <span className="h-1.5 w-1.5 rounded-full bg-red-600" />
            <span className="text-sm font-bold text-red-700 uppercase tracking-wide">
              Exam Blueprint
            </span>
          </div>
          <h2 className="text-3xl md:text-4xl font-black text-comptia-charcoal uppercase">
            What You'll Learn
          </h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            All five SY0-701 domains, weighted exactly like the real exam. Pick one to start practising.
          </p>
        </div>

        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-6 sm:p-10 space-y-6">
            <ExamBlueprint />

            <div className="text-center pt-2 border-t-2 border-slate-100">
              <Link
                to="/about"
                className="inline-block pt-5 text-sm font-bold text-red-600 hover:underline"
              >
                See the full domain breakdown →
              </Link>
            </div>
          </CardContent>
        </Card>
      </section>

      {/* ── Progress Preview ───────────────────────────────── */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-3">
          <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
            <TrendingUp className="w-5 h-5 text-red-600" />
            <span className="text-sm font-bold text-red-700 uppercase tracking-wide">Track Your Progress</span>
          </div>
          <h2 className="text-3xl md:text-4xl font-black text-comptia-charcoal">
            See Your Growth in Real-Time
          </h2>
          <p className="text-lg text-slate-600 max-w-2xl mx-auto">
            Our intelligent dashboard tracks every practice session, highlighting your strengths and pinpointing areas that need improvement.
          </p>
        </div>

        <Card className="border-2 border-slate-200 shadow-2xl rounded-2xl overflow-hidden bg-white">
          <CardContent className="p-8 space-y-6">
            <ProgressPreview />

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

      {/* ── CTA ────────────────────────────────────────────── */}
      <section className="text-center space-y-6 py-16 max-w-7xl mx-auto px-4">
        <Card className="bg-red-600 border-0 shadow-2xl rounded-3xl">
          <CardContent className="p-16 text-white space-y-6">
            <h2 className="text-4xl md:text-5xl font-black uppercase">Master Security+ Certification</h2>
            <p className="text-xl max-w-2xl mx-auto">
              Get the skills and knowledge you need to pass the CompTIA Security+ SY0-701 exam.
            </p>
            <Link to="/lessons">
              <Button size="lg" className="bg-white text-red-600 hover:bg-slate-100 px-10 py-7 text-lg font-bold rounded-lg shadow-xl uppercase tracking-wide">
                Start Practising Now
              </Button>
            </Link>
          </CardContent>
        </Card>
      </section>

    </div>
  );
}
