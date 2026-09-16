import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Shield,
  BookOpen,
  CheckCircle2,
  Clock,
  Target,
  Users,
  Briefcase,
  RefreshCw,
} from 'lucide-react';
import DomainGrid from '../components/domains/DomainGrid';

const stats = [
  { value: '130%',    label: 'Higher Salary Potential',      sub: 'vs. non-certified peers' },
  { value: '90 min',  label: 'Exam Duration',                sub: 'timed, performance-based' },
  { value: '750/900', label: 'Passing Score',                sub: 'scaled score required' },
  { value: '90',      label: 'Max Questions',                sub: 'multiple-choice & PBQ' },
];

const whoIsItFor = [
  { icon: Briefcase, label: 'IT professionals moving into security roles' },
  { icon: RefreshCw, label: 'Career changers entering cybersecurity' },
  { icon: Shield,    label: 'Government & military IT personnel (DoD 8570)' },
  { icon: Users,     label: 'Help desk / sysadmin looking to level up' },
];

const skills = [
  'Identify and defend against cyber threats, malware, and social engineering',
  'Configure firewalls, intrusion detection systems, and endpoint protection',
  'Design secure network architectures for cloud and on-premises environments',
  'Manage identity, authentication methods, and access controls',
  'Assess organizational risk and develop mitigation strategies',
  'Apply encryption and cryptography to protect sensitive data',
  'Implement security policies and maintain regulatory compliance',
];

export default function AboutCertification() {
  return (
    <div className="relative space-y-16 -mt-8">

      {/* ── Hero ─────────────────────────────────────────── */}
      <section className="relative text-center space-y-6 py-24 px-4 sm:px-6 lg:px-8 overflow-hidden rounded-xl">
        <div className="absolute inset-0 bg-gradient-to-br from-comptia-charcoal via-comptia-charcoal-light to-comptia-charcoal" />
        <div
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1563986768609-322da13575f3?w=1920&q=80)',
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />
        <div className="relative z-10 max-w-4xl mx-auto space-y-6">
          <div className="inline-flex items-center gap-2 bg-white/20 backdrop-blur-sm px-5 py-2.5 rounded-full border-2 border-white/30">
            <Shield className="w-5 h-5 text-white" />
            <span className="text-sm font-bold text-white uppercase tracking-wide">CompTIA Security+ SY0-701</span>
          </div>

          <h1 className="text-5xl md:text-7xl font-black text-white uppercase tracking-tight leading-tight">
            About the <br />
            <span className="text-red-400">Certification</span>
          </h1>

          <p className="text-xl text-white/90 max-w-3xl mx-auto leading-relaxed">
            Security+ is the industry's first security certification IT professionals should earn — vendor-neutral, globally recognized, and trusted by employers worldwide.
          </p>

          <Link to="/lessons">
            <Button size="lg" className="bg-red-600 hover:bg-red-700 text-white px-10 py-7 text-lg font-bold rounded-lg uppercase tracking-wide shadow-xl mt-4">
              Start Practising Now
            </Button>
          </Link>
        </div>
      </section>

      {/* ── Stats Bar ────────────────────────────────────── */}
      <section className="max-w-7xl mx-auto px-4">
        <Card className="bg-white border-0 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-10">
            <div className="grid grid-cols-2 lg:grid-cols-4 gap-8 divide-y-2 lg:divide-y-0 lg:divide-x-2 divide-slate-100">
              {stats.map((s, i) => (
                <div key={i} className="text-center pt-6 lg:pt-0 first:pt-0">
                  <p className="text-5xl font-black text-red-600 leading-none">{s.value}</p>
                  <p className="text-base font-bold text-comptia-charcoal mt-2">{s.label}</p>
                  <p className="text-xs text-slate-500 mt-1">{s.sub}</p>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </section>

      {/* ── What is Security+ / Who is it for ────────────── */}
      <section className="max-w-7xl mx-auto px-4 space-y-8">
        <div className="text-center space-y-2">
          <h2 className="text-3xl md:text-4xl font-black text-comptia-charcoal uppercase">What is Security+?</h2>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* What it is */}
          <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
            <CardContent className="p-10 space-y-5">
              <div className="w-14 h-14 bg-red-600 rounded-2xl flex items-center justify-center shadow-lg">
                <Shield className="w-7 h-7 text-white" />
              </div>
              <h3 className="text-2xl font-black text-comptia-charcoal">The Certification</h3>
              <p className="text-slate-600 leading-relaxed">
                CompTIA Security+ establishes the foundational knowledge required for a career in cybersecurity. It proves you can assess enterprise security, identify vulnerabilities, implement solutions, and respond to incidents.
              </p>
              <p className="text-slate-600 leading-relaxed">
                It's vendor-neutral — skills you learn apply to any technology environment — and is required for many government and military IT positions under DoD 8570.
              </p>
              <div className="bg-red-50 border-2 border-red-100 rounded-xl p-4 flex items-start gap-3">
                <Clock className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
                <p className="text-sm text-slate-700">
                  <span className="font-bold">Recommended:</span> CompTIA Network+ plus two years in a security or sysadmin role — but dedicated self-study can get entry-level professionals there too.
                </p>
              </div>
            </CardContent>
          </Card>

          {/* Who is it for */}
          <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
            <CardContent className="p-10 space-y-5">
              <div className="w-14 h-14 bg-comptia-charcoal rounded-2xl flex items-center justify-center shadow-lg">
                <Target className="w-7 h-7 text-white" />
              </div>
              <h3 className="text-2xl font-black text-comptia-charcoal">Who Is It For?</h3>
              <p className="text-slate-600 leading-relaxed">
                Security+ is the right next step if any of these describe you:
              </p>
              <ul className="space-y-4">
                {whoIsItFor.map((item, i) => {
                  const Icon = item.icon;
                  return (
                    <li key={i} className="flex items-center gap-4">
                      <div className="w-10 h-10 bg-slate-100 rounded-xl flex items-center justify-center flex-shrink-0">
                        <Icon className="w-5 h-5 text-slate-700" />
                      </div>
                      <span className="text-slate-700 font-medium">{item.label}</span>
                    </li>
                  );
                })}
              </ul>
              <div className="bg-comptia-charcoal rounded-xl p-4 text-center">
                <p className="text-white text-sm font-medium">
                  7 in 10 companies recognize cybersecurity credentials as critical hiring criteria.
                </p>
              </div>
            </CardContent>
          </Card>
        </div>
      </section>

      {/* ── What's on the Exam ───────────────────────────── */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-3">
          <div className="inline-flex items-center gap-2 bg-red-50 px-5 py-2.5 rounded-full border-2 border-red-200">
            <span className="h-1.5 w-1.5 rounded-full bg-red-600" />
            <span className="text-sm font-bold text-red-700 uppercase tracking-wide">
              Exam Objectives
            </span>
          </div>
          <h2 className="text-3xl md:text-4xl font-black text-comptia-charcoal uppercase">
            What's on the Exam
          </h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Five domains — each with a specific weight on the real SY0-701 exam.
          </p>
        </div>

        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-8 sm:p-12 pt-12 sm:pt-16">
            <DomainGrid />
          </CardContent>
        </Card>
      </section>

      {/* ── Skills You'll Master ─────────────────────────── */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-2">
          <h2 className="text-3xl md:text-4xl font-black text-comptia-charcoal uppercase">Skills You'll Master</h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Everything the exam tests, you'll be able to do on the job.
          </p>
        </div>

        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-10">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              {skills.map((skill, i) => (
                <div key={i} className="flex items-start gap-4 bg-slate-50 rounded-xl p-4 border-2 border-slate-100">
                  <div className="w-8 h-8 bg-red-600 rounded-lg flex items-center justify-center flex-shrink-0 mt-0.5 shadow">
                    <CheckCircle2 className="w-4 h-4 text-white" />
                  </div>
                  <span className="text-slate-700 leading-relaxed">{skill}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </section>

      {/* ── CTA ──────────────────────────────────────────── */}
      <section className="max-w-7xl mx-auto px-4">
        <Card className="bg-red-600 border-0 shadow-2xl rounded-3xl">
          <CardContent className="p-16 text-white text-center space-y-6">
            <h2 className="text-4xl md:text-5xl font-black uppercase">Ready to Start Your Journey?</h2>
            <p className="text-xl max-w-2xl mx-auto leading-relaxed">
              Begin learning today and earn the certification that will transform your cybersecurity career.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
              <Link to="/lessons">
                <Button size="lg" className="bg-white text-red-600 hover:bg-slate-100 px-10 py-7 text-lg font-bold rounded-lg shadow-xl uppercase tracking-wide">
                  <BookOpen className="w-5 h-5 mr-2" />
                  Start Learning
                </Button>
              </Link>
              <Link to="/resources">
                <Button size="lg" variant="outline" className="bg-transparent border-2 border-white text-white hover:bg-white/10 px-10 py-7 text-lg font-bold rounded-lg uppercase tracking-wide">
                  Resources
                </Button>
              </Link>
            </div>
          </CardContent>
        </Card>
      </section>

    </div>
  );
}
