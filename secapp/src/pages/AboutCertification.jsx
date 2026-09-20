import React from 'react';
import { Link } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  ExternalLink,
  BadgeCheck,
  CheckCircle2,
  ClipboardCheck,
  Headset,
  Landmark,
  RefreshCw,
  Server,
  TrendingUp,
} from 'lucide-react';
import DomainBreakdown from '../components/domains/DomainBreakdown';
import { getDomainById } from '../components/data/securityDomains';
import SourceLink from '../components/SourceLink';
import practiceIcon from '../assets/home page/openbook.png';

const stats = [
  { value: 'SY0-701', label: 'Current Exam Version',         sub: 'objectives v5.0, 2023' },
  { value: '90 min',  label: 'Exam Duration',                sub: 'timed, performance-based' },
  { value: '750/900', label: 'Passing Score',                sub: 'scaled score required' },
  { value: '90',      label: 'Max Questions',                sub: 'multiple-choice & PBQ' },
];

// What holding the certificate does for you outside the exam room. What the
// exam tests is covered further down the page, in What's on the Exam.
const outcomes = [
  {
    icon: BadgeCheck,
    title: 'Asked for by employers',
    line: 'Employers name it in job postings for entry-level security roles.',
    sourceId: 'cyberseek',
  },
  {
    icon: Landmark,
    title: 'Counts for government work',
    line: 'Listed against US DoD 8140 work roles, from cyber defence analyst to system administrator.',
    sourceId: 'comptia-security-plus',
  },
  {
    icon: TrendingUp,
    title: 'A first step, not the last',
    line: "The centre of CompTIA's security pathway, and a springboard to intermediate-level roles.",
    sourceId: 'nice-career-pathways',
  },
];

const background = [
  { title: 'CompTIA Network+', line: 'Or equivalent networking knowledge — subnets, ports, routing.' },
  { title: 'About two years in IT', line: 'Ideally a role with security in it, such as sysadmin or help desk.' },
  { title: 'Or dedicated self-study', line: 'Plenty of people pass without either.' },
];

// Who takes it, and what it adds for each of them. Every skill is an
// objective in data/examObjectives.js, and domainIds must name the domains
// those objectives sit in — the line under each card is built from them.
const whoItsFor = [
  {
    icon: RefreshCw,
    title: 'Career changers',
    line: 'Coming from outside IT, you start with the ideas the rest of the field is built on.',
    skills: [
      'Explain the CIA triad, zero trust and security controls',
      'Know when to use encryption, hashing or a certificate',
      'Compare threat actors and what drives them',
    ],
    domainIds: ['domain1', 'domain2'],
  },
  {
    icon: Headset,
    title: 'Help desk levelling up',
    line: 'You already reset the passwords and field the "is this email real?" tickets.',
    skills: [
      'Spot phishing and other social engineering',
      'Recognise the signs of malware',
      'Manage accounts, MFA and access control',
    ],
    domainIds: ['domain2', 'domain4'],
  },
  {
    icon: Server,
    title: 'IT pros moving into security',
    line: 'You already run the systems. This is the half of the job that protects them.',
    skills: [
      'Configure firewalls, IDS and endpoint protection',
      'Design secure networks, in the cloud and on-premises',
      'Respond to an incident and recover from it',
    ],
    domainIds: ['domain3', 'domain4'],
  },
  {
    icon: ClipboardCheck,
    title: 'Managers & compliance',
    line: 'You own a team, a project or an audit, and security keeps landing on your desk.',
    skills: [
      'Assess risk and plan how to reduce it',
      'Write and enforce security policy',
      'Prepare for compliance checks and audits',
    ],
    domainIds: ['domain5'],
  },
];

export default function AboutCertification() {
  return (
    <div className="relative space-y-12 -mt-8">

      {/* ── Hero ─────────────────────────────────────────── */}
      <section className="full-bleed band-dark relative text-center space-y-4 py-16 px-4 sm:px-6 lg:px-8 overflow-hidden">
        <div
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1563986768609-322da13575f3?w=1920&q=80)',
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />
        <div className="relative z-10 max-w-4xl mx-auto space-y-6">
          <h1 className="text-3xl md:text-5xl font-black text-white uppercase tracking-tight leading-tight">
            About the <br />
            <span className="text-red-400">Certification</span>
          </h1>

          {/* A map of the page, not a pitch — What is Security+ below makes
              the case, so the hero doesn't make it first. */}
          <p className="text-base text-white/90 max-w-2xl mx-auto leading-relaxed text-balance">
            Whether you're deciding if Security+ is for you or getting ready to sit it, start here: what the
            certification does for your career, what the SY0-701 exam covers, and how it's timed and scored.
          </p>

          <Link to="/lessons" className="inline-block pt-4">
            <Button size="lg" className="bg-red-600 hover:bg-red-700 text-white px-8 py-5 text-sm font-bold rounded-lg uppercase tracking-wide shadow-xl">
              Start Practising Now
            </Button>
          </Link>
        </div>
      </section>

      {/* ── Stats Bar ────────────────────────────────────── */}
      <section className="max-w-7xl mx-auto px-4">
        <Card className="bg-white border-0 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-7">
            <div className="grid grid-cols-2 lg:grid-cols-4 gap-8 divide-y-2 lg:divide-y-0 lg:divide-x-2 divide-slate-100">
              {stats.map((s, i) => (
                <div key={i} className="text-center pt-6 lg:pt-0 first:pt-0">
                  <p className="text-2xl sm:text-3xl font-black text-red-600 leading-none">{s.value}</p>
                  <p className="text-sm font-bold text-comptia-charcoal mt-1.5">{s.label}</p>
                  <p className="text-xs text-slate-500 mt-1">{s.sub}</p>
                </div>
              ))}
            </div>
            <div className="text-center mt-6">
              <SourceLink id="comptia-security-plus" />
            </div>
          </CardContent>
        </Card>
      </section>

      {/* ── What is Security+ ──────────────────────────────
          One card, not a left/right pair: the statement, what the certificate
          does for you in practice, and the background CompTIA suggests. The
          statement stays at "fundamentals" on purpose — it is a baseline
          credential, and overselling it reads as marketing. Sources sit on
          the claim they back, rather than in a list at the foot of the page.

          Who it's for lives further down, paired with skills. A row of persona
          cards used to follow this card, and each one restated a line in it. */}
      <section className="max-w-7xl mx-auto px-4 space-y-8">
        <div className="text-center space-y-2">
          <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">The basics</p>
          <h2 className="text-2xl md:text-3xl font-black text-comptia-charcoal uppercase">What is Security+?</h2>
        </div>

        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-7 sm:p-9 space-y-7">
            <div className="max-w-4xl mx-auto text-center space-y-4">
              <p className="text-xl md:text-2xl font-black text-comptia-charcoal leading-snug">
                Security+ is a widely recognised certification that shows employers you have the core knowledge a
                cybersecurity job is built on.
              </p>
              <p className="text-slate-600 leading-relaxed">
                It covers the ground every security role shares — risk management, incident response, cryptography,
                network security and compliance — and it's vendor-neutral, so none of it is tied to one company's
                products. It won't make you an expert by itself. It proves you have the fundamentals, and that's what
                gets you in the door.
              </p>
              <SourceLink id="comptia-security-plus" />
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
              {outcomes.map((item) => {
                const Icon = item.icon;
                return (
                  <div key={item.title} className="flex flex-col rounded-2xl bg-slate-50 border-2 border-slate-100 p-4">
                    <span className="inline-flex w-9 h-9 items-center justify-center rounded-lg bg-red-600 text-white">
                      <Icon className="w-5 h-5" />
                    </span>
                    <h3 className="font-black text-comptia-charcoal mt-3 leading-snug">{item.title}</h3>
                    <p className="text-sm text-slate-600 leading-relaxed mt-1 flex-1">{item.line}</p>
                    <SourceLink id={item.sourceId} className="mt-3" />
                  </div>
                );
              })}
            </div>

            <div className="border-t-2 border-slate-100 pt-6 space-y-4">
              <div className="flex flex-col sm:flex-row sm:items-baseline sm:justify-between gap-x-4 gap-y-1">
                <h3 className="text-lg font-black text-comptia-charcoal">Recommended background</h3>
                <p className="text-sm text-slate-500">
                  What CompTIA suggests you bring. None of it is enforced at the test centre.
                </p>
              </div>

              <ol className="grid sm:grid-cols-3 gap-4">
                {background.map((item, i) => (
                  <li key={item.title} className="flex items-start gap-3">
                    <span className="flex w-8 h-8 flex-shrink-0 items-center justify-center rounded-full border-2 border-slate-200 text-sm font-black text-comptia-charcoal tabular-nums">
                      {i + 1}
                    </span>
                    <span className="min-w-0">
                      <span className="block font-bold text-comptia-charcoal leading-snug">{item.title}</span>
                      <span className="block text-sm text-slate-600 leading-relaxed mt-0.5">{item.line}</span>
                    </span>
                  </li>
                ))}
              </ol>

              <SourceLink id="comptia-security-plus" />
            </div>
          </CardContent>
        </Card>
      </section>

      {/* ── What's on the Exam ───────────────────────────── */}
      {/* Home's "full domain breakdown" link lands here via the id. */}
      <section id="exam-domains" className="space-y-8 max-w-7xl mx-auto px-4 scroll-mt-24">
        <div className="text-center space-y-3">
          <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Exam objectives</p>
          <h2 className="text-2xl md:text-3xl font-black text-comptia-charcoal uppercase">
            What's on the Exam
          </h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Five domains, each sized by its share of the SY0-701 exam. Open one to see the official objectives it covers.
          </p>
          <SourceLink id="comptia-security-plus" label="CompTIA exam objectives" />
        </div>

        <Card className="border-2 border-slate-200 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-5 sm:p-8">
            <DomainBreakdown />
          </CardContent>
        </Card>
      </section>

      {/* ── Who It's For ─────────────────────────────────
          Each reader paired with what Security+ adds for them. This replaced
          a flat "Skills You'll Master" checklist that had no one attached to
          it, and a separate persona row that repeated the What is Security+
          card. */}
      <section className="space-y-8 max-w-7xl mx-auto px-4">
        <div className="text-center space-y-3">
          <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Skills you'll build</p>
          <h2 className="text-2xl md:text-3xl font-black text-comptia-charcoal uppercase">Who It's For</h2>
          <p className="text-slate-600 max-w-2xl mx-auto">
            Wherever you're starting from, here's what Security+ adds to what you already know.
          </p>
          <SourceLink id="comptia-security-plus" label="CompTIA exam objectives" />
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {whoItsFor.map((person) => {
            const Icon = person.icon;
            const domains = person.domainIds.map(getDomainById);
            // Subgrid rows keep the intro, skills and domain line aligned
            // across a row of cards whose intros wrap to different lengths.
            return (
              <div
                key={person.title}
                className="row-span-3 grid grid-rows-subgrid gap-0 rounded-2xl border-2 border-slate-200 bg-white p-5 shadow-sm"
              >
                <div>
                  <span className="inline-flex w-10 h-10 items-center justify-center rounded-xl bg-comptia-charcoal text-white">
                    <Icon className="w-5 h-5" />
                  </span>
                  <h3 className="font-black text-comptia-charcoal mt-3 leading-snug">{person.title}</h3>
                  <p className="text-sm text-slate-600 leading-relaxed mt-1">{person.line}</p>
                </div>

                <div className="mt-4 pt-4 border-t-2 border-slate-100">
                  <p className="text-[11px] font-bold uppercase tracking-wider text-slate-500">You'll learn to</p>
                  <ul className="mt-2 space-y-2">
                    {person.skills.map((skill) => (
                      <li key={skill} className="flex items-start gap-2 text-sm text-slate-700 leading-snug">
                        <CheckCircle2 className="w-4 h-4 text-red-600 flex-shrink-0 mt-px" />
                        {skill}
                      </li>
                    ))}
                  </ul>
                </div>

                <p className="flex items-center gap-2 mt-4 text-[11px] font-bold uppercase tracking-wider text-slate-500">
                  <span className="flex gap-1" aria-hidden="true">
                    {domains.map((domain) => (
                      <span
                        key={domain.id}
                        className="w-2 h-2 rounded-full"
                        style={{ backgroundColor: domain.chartColor }}
                      />
                    ))}
                  </span>
                  {domains.length > 1 ? 'Domains' : 'Domain'} {domains.map((domain) => domain.number).join(' & ')}
                </p>
              </div>
            );
          })}
        </div>
      </section>

      {/* ── CTA ──────────────────────────────────────────── */}
      <section className="max-w-7xl mx-auto px-4">
        <Card className="bg-red-600 border-0 shadow-2xl rounded-3xl">
          <CardContent className="p-8 sm:p-12 lg:p-16 text-white text-center space-y-6">
            <h2 className="text-4xl md:text-5xl font-black uppercase">Ready to Start Your Journey?</h2>
            <p className="text-xl max-w-2xl mx-auto leading-relaxed">
              Begin learning today and earn the certification that will transform your cybersecurity career.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
              <Link to="/lessons">
                <Button size="lg" className="bg-white border-2 border-white text-red-600 hover:bg-slate-100 px-10 py-7 text-lg font-bold rounded-lg shadow-xl uppercase tracking-wide gap-2.5">
                  {/* The nav's own Practice icon, as on Home's closing card. */}
                  <img src={practiceIcon} alt="" aria-hidden="true" className="w-6 h-6 object-contain" />
                  Start Learning
                </Button>
              </Link>
              <Link to="/resources">
                <Button size="lg" variant="outline" className="bg-transparent border-2 border-white text-white hover:bg-white/10 hover:text-white px-10 py-7 text-lg font-bold rounded-lg uppercase tracking-wide">
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
