import React from 'react';
import hourglass from '../assets/home page/hourglass.png';
import graphfork from '../assets/home page/graphfork.png';
import openbook from '../assets/home page/openbook.png';
import aboutIcon from '../assets/Nav icons/icon.png';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { ArrowRight } from 'lucide-react';
import { securityDomains } from '../components/data/securityDomains';
import { getAllQuestions } from '../components/data/quizData';
import ProgressPreview from '../components/previews/ProgressPreview';
import PracticePreview from '../components/previews/PracticePreview';
import ExamBlueprint from '../components/domains/ExamBlueprint';
import SourceLink from '../components/SourceLink';
import { lessons } from '../components/data/lessonsData';
import { getCompletedLessonsCount } from '../components/data/progressData';

export default function Home() {
  const completedLessons = getCompletedLessonsCount();
  const completionRate = lessons.length > 0 ? Math.round((completedLessons / lessons.length) * 100) : 0;

  // Derived, never hardcoded — the bank changes as questions are added.
  const totalQuestions = getAllQuestions().length;
  const domains = securityDomains;

  // Kept to two lines each — the band above already sells the detail.
  const steps = [
    {
      number: '01',
      icon: openbook,
      title: 'Study the Domains',
      description: 'See what each of the five SY0-701 domains covers and how much of the exam it is worth.',
      cta: 'Explore the domains',
      href: '/about#exam-domains',
      ringColor: 'border-red-600',
      accent: 'text-red-600',
      bar: 'bg-red-600',
    },
    {
      number: '02',
      icon: hourglass,
      title: 'Test Your Knowledge',
      description: 'Drill one domain at a time, then put it all together in a timed mock exam.',
      cta: 'Take a quiz',
      // The Quiz Center, not /quiz — that is TakeQuiz, which needs a quizId.
      href: '/lessons',
      ringColor: 'border-comptia-charcoal',
      accent: 'text-comptia-charcoal',
      bar: 'bg-comptia-charcoal',
    },
    {
      number: '03',
      icon: graphfork,
      title: 'Track Your Growth',
      description: 'Your accuracy by domain, your score trend, and the questions you keep missing.',
      cta: 'View progress',
      href: '/progress',
      ringColor: 'border-green-600',
      accent: 'text-green-600',
      bar: 'bg-green-600',
    },
  ];

  return (
    // -mb-8 cancels Layout's bottom padding too, so the closing red card's
    // section sets its own, even gap above and below.
    //
    // Bands use two tones only — `band-dark` (index.css) or white — so the
    // page reads as one material instead of a patchwork.
    <div className="relative -mt-8 -mb-8">

      {/* ── Hero ───────────────────────────────────────────── */}
      <section className="full-bleed band-dark relative py-16 lg:py-20 px-4 sm:px-6 lg:px-8 overflow-hidden">
        <div
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=1920&q=80)',
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />

        {/* One centred column. The hero used to put a tilted product
            showcase on the right, which said the same thing as the band
            directly below it — and in the same shape. The product now shows
            itself further down, with the real components. */}
        <div className="relative z-10 max-w-3xl mx-auto text-center">
          <h1 className="text-4xl md:text-5xl font-black text-white leading-[1.05]">
            One Certification <br />
            <span className="text-red-400">To Pivot Your Career</span>
          </h1>

          {/* The money hook rides in the same sentence as the pitch. As its
              own bordered block it added 160px of hero for one number. */}
          <p className="text-base md:text-lg text-slate-200 max-w-2xl mx-auto mt-4 leading-relaxed">
            That's all it takes to open a different door. US information security analysts earn a median of{' '}
            <span className="font-black text-white">$129,180</span> a year — and Security+ is the credential that
            gets you in.
          </p>

          <div className="flex flex-col sm:flex-row gap-3 justify-center pt-6">
            <Link to="/lessons">
              <Button className="w-full sm:w-auto bg-red-600 hover:bg-red-700 text-white px-7 py-5 text-sm font-bold shadow-lg hover:shadow-xl rounded-lg uppercase tracking-wide">
                Start Practising
              </Button>
            </Link>
            <Link to="/about">
              <Button
                variant="outline"
                className="w-full sm:w-auto bg-transparent hover:bg-white/10 text-white border-2 border-white/60 hover:border-white px-7 py-5 text-sm font-bold rounded-lg uppercase tracking-wide"
              >
                About the Exam
              </Button>
            </Link>
          </div>

          {/* One strip: the job market, then what is actually in the app.
              Figures, not invented usage numbers. */}
          <div className="mt-7 pt-6 border-t border-white/15">
            <div className="flex flex-wrap gap-x-7 gap-y-4 justify-center">
              <div>
                <p className="text-2xl font-black text-red-400 tabular-nums">21%</p>
                <p className="text-xs text-slate-300 mt-0.5">Job growth to 2035</p>
              </div>
              <div className="sm:pl-7 sm:border-l border-white/15">
                <p className="text-2xl font-black text-white tabular-nums">{totalQuestions}</p>
                <p className="text-xs text-slate-300 mt-0.5">Practice questions</p>
              </div>
              <div className="sm:pl-7 sm:border-l border-white/15">
                <p className="text-2xl font-black text-white tabular-nums">{domains.length}</p>
                <p className="text-xs text-slate-300 mt-0.5">Exam domains</p>
              </div>
              <div className="sm:pl-7 sm:border-l border-white/15">
                <p className="text-2xl font-black text-white tabular-nums">90</p>
                <p className="text-xs text-slate-300 mt-0.5">Question mock exam</p>
              </div>
              {completedLessons > 0 && (
                <div className="sm:pl-7 sm:border-l border-white/15">
                  <p className="text-2xl font-black text-red-400 tabular-nums">{completionRate}%</p>
                  <p className="text-xs text-slate-300 mt-0.5">Your progress</p>
                </div>
              )}
            </div>

            <SourceLink
              id="bls-infosec-analysts"
              label="BLS, May 2025"
              className="mt-4 text-slate-400 hover:text-white"
            />
          </div>
        </div>

      </section>

      {/* ── Practice Like It's Exam Day · DARK band ────────────
          The pitch, told as a short read on the left, with the two things it
          describes shown on the right — nothing more. Same dark tone as the
          hero; a hairline on top keeps the two bands from running together. */}
      <section className="full-bleed band-dark relative overflow-hidden border-t border-white/10 py-16 lg:py-24">
        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 grid lg:grid-cols-[1fr_1.05fr] gap-14 lg:gap-16 items-center">
          <div className="space-y-6">
            {/* pb-2 keeps the descenders inside the clipped gradient. */}
            <h2 className="pb-2 text-4xl md:text-5xl font-black leading-[1.05] bg-gradient-to-br from-red-400 via-orange-300 to-amber-300 bg-clip-text text-transparent">
              Practice Like <br />
              It's Exam Day
            </h2>

            <div className="max-w-xl space-y-4 text-base md:text-lg text-slate-300 leading-relaxed">
              <p>
                Attackers don't wait until you feel ready. Phishing emails reach inboxes every day, alerts
                pile up faster than anyone can triage them, and one misconfigured server can expose an entire
                company.
              </p>
              <p className="font-semibold text-white">That's where Security+ comes in.</p>
              <p>
                It shows employers you can spot suspicious activity, understand what it means, and act before
                it turns into a breach. That practical, job-ready knowledge is why Security+ is one of the most
                requested certifications for entry-level security roles.
              </p>
              <p>
                So practice the way the job works. Quizzes explain every answer, so you learn the reasoning
                instead of memorising it. A full mock exam, with 90 questions in 90 minutes, makes test day
                feel familiar.
              </p>
            </div>

            <div className="flex flex-col sm:flex-row gap-3 pt-2">
              <Link to="/lessons">
                <Button className="w-full sm:w-auto bg-red-600 hover:bg-red-700 text-white px-6 py-5 text-sm font-bold shadow-lg hover:shadow-xl rounded-lg uppercase tracking-wide gap-2">
                  Start Practising
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
              <Link to="/lessons?section=mock">
                <Button
                  variant="outline"
                  className="w-full sm:w-auto bg-transparent hover:bg-white/10 text-white hover:text-white border-2 border-white/60 hover:border-white px-6 py-5 text-sm font-bold rounded-lg uppercase tracking-wide"
                >
                  Take a Mock Exam
                </Button>
              </Link>
            </div>
          </div>

          <PracticePreview className="w-full max-w-xl mx-auto lg:max-w-none" />
        </div>
      </section>

      {/* ── How It Works · WHITE band ──────────────────────────
          A compact stepper: each step is one row (icon beside text) under a
          shared rule, with the step's colour marking its stretch of it. The
          old centred stacks — number, icon, title, paragraph, button, each on
          its own line — left three tall islands with dead space between. */}
      <section className="full-bleed bg-white py-12 lg:py-14">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-8">
          <div className="flex flex-col md:flex-row md:items-end md:justify-between gap-2 md:gap-8">
            <div>
              <h2 className="text-2xl md:text-3xl font-black text-comptia-charcoal uppercase">
                How It Works
              </h2>
              <p className="text-slate-600 mt-1">Three steps to go from zero to Security+ certified.</p>
            </div>
            <Link to="/about" className="text-sm font-bold text-red-600 hover:underline md:pb-1 shrink-0">
              New to Security+? See if it's right for you →
            </Link>
          </div>

          <ol className="grid gap-6 lg:grid-cols-3 lg:gap-10">
            {steps.map((step) => (
              <li key={step.number} className="relative border-t-2 border-slate-100 pt-5">
                <span className={`absolute -top-0.5 left-0 h-0.5 w-16 ${step.bar}`} aria-hidden="true" />

                <div className="flex items-start gap-4">
                  <div className={`w-12 h-12 flex-shrink-0 rounded-full bg-white border-2 ${step.ringColor} shadow-sm flex items-center justify-center`}>
                    <img src={step.icon} alt="" className="w-7 h-7 object-contain" />
                  </div>

                  <div className="min-w-0">
                    <p className={`text-xs font-black tracking-widest ${step.accent}`}>STEP {step.number}</p>
                    <h3 className="text-lg font-black text-comptia-charcoal leading-snug">{step.title}</h3>
                    <p className="text-sm text-slate-600 leading-relaxed mt-1">{step.description}</p>
                    <Link
                      to={step.href}
                      className="group inline-flex items-center gap-1.5 mt-2.5 text-sm font-bold text-comptia-charcoal hover:text-red-600 transition-colors"
                    >
                      {step.cta}
                      <ArrowRight className="w-4 h-4 group-hover:translate-x-0.5 transition-transform" />
                    </Link>
                  </div>
                </div>
              </li>
            ))}
          </ol>
        </div>
      </section>

      {/* ── Exam Blueprint · WHITE band ────────────────────────
          Asymmetric header: the title holds the left column and the
          supporting copy the right, so this section does not open with the
          same centred stack as the one above it.

          Only the bar lives here. The per-domain cards, topics and objectives
          are About's job — Home just shows the shape of the exam and gets
          people into a quiz. */}
      <section className="full-bleed bg-white border-t border-slate-200 py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-10">
          <div className="grid lg:grid-cols-2 gap-6 lg:gap-16 lg:items-end">
            <div className="space-y-3">
              <p className="text-xs font-bold uppercase tracking-[0.18em] text-red-600">Exam blueprint</p>
              <h2 className="text-2xl md:text-3xl font-black text-comptia-charcoal uppercase">
                What You'll Learn
              </h2>
            </div>
            <p className="text-slate-600 lg:pb-1">
              Five domains, each sized by its share of the SY0-701 exam. Click one to see what it covers.
            </p>
          </div>

          {/* Segments link to that domain's row on About, which opens on
              arrival via `?domain=`. */}
          <ExamBlueprint
            getHref={(domain) => `/about?domain=${domain.id}#exam-domains`}
            action="see what it covers"
          />
        </div>
      </section>

      {/* ── Track Your Progress · WHITE band ───────────────────
          The mirror of the practice band: the showcase takes the left this
          time and the read takes the right, so two text-left bands don't
          stack. Gradient headline in darker stops than the dark band's, for
          contrast on white. */}
      <section className="full-bleed bg-white border-t border-slate-200 py-16 lg:py-24">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 grid lg:grid-cols-[1.2fr_1fr] gap-12 lg:gap-14 items-center">
          <div className="space-y-6">
            {/* pb-2 keeps the descenders inside the clipped gradient. */}
            <h2 className="pb-2 text-4xl md:text-5xl font-black leading-[1.05] bg-gradient-to-br from-red-600 via-orange-700 to-amber-700 bg-clip-text text-transparent">
              See Your Growth <br />
              In Real Time
            </h2>

            <div className="max-w-xl space-y-4 text-base md:text-lg text-slate-600 leading-relaxed">
              <p>
                Practice only pays off when you know what's working. Left to instinct, most people revise what
                they already know and skip the domain that keeps catching them out.
              </p>
              <p className="font-semibold text-comptia-charcoal">That's what the dashboard is for.</p>
              <p>
                Every quiz updates your accuracy in each of the five domains, your score trend over time, and the
                list of questions you keep missing. So the next session aims at the gap instead of the
                comfortable material.
              </p>
            </div>

            <div className="flex flex-col sm:flex-row gap-3 pt-2">
              <Link to="/progress">
                <Button className="w-full sm:w-auto bg-red-600 hover:bg-red-700 text-white px-7 py-5 text-sm font-bold shadow-lg hover:shadow-xl rounded-lg uppercase tracking-wide gap-2">
                  View Your Dashboard
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </Link>
            </div>
          </div>

          <ProgressPreview className="lg:order-first w-full" />
        </div>
      </section>

      {/* ── CTA · red island ───────────────────────────────────
          A floating card on the canvas rather than a full-width band, to
          match About's closing card. Two ways out: practise now, or read
          about the certification first. The section's own padding sets the
          gap to the footer (the wrapper's -mb-8 removes Layout's). */}
      <section className="max-w-7xl mx-auto sm:px-4 py-12 lg:py-16">
        <div className="bg-red-600 shadow-2xl rounded-3xl p-6 sm:p-12 lg:p-16 text-white text-center space-y-6">
          <h2 className="text-4xl md:text-5xl font-black uppercase">Pick Your Starting Point</h2>
          <p className="text-lg md:text-xl max-w-2xl mx-auto leading-relaxed">
            Jump straight into a domain quiz or a full mock exam. Or, if you're still weighing it up, see what
            Security+ covers and what it can do for your career.
          </p>
          {/* Both buttons carry a 2px border so they match in height — the
              outline one needs it to show, and without it on the solid one
              the pair sits a few pixels out of line. Their icons are the nav's
              own Practice and About icons, so each button points at the page
              it opens the same way the nav does. */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
            <Link to="/lessons">
              <Button size="lg" className="w-full sm:w-auto bg-white border-2 border-white text-red-600 hover:bg-slate-100 px-4 sm:px-10 py-7 text-sm sm:text-lg font-bold rounded-lg shadow-xl uppercase tracking-wide gap-2.5">
                <img src={openbook} alt="" aria-hidden="true" className="w-6 h-6 object-contain" />
                Start Practising
              </Button>
            </Link>
            <Link to="/about">
              <Button size="lg" variant="outline" className="w-full sm:w-auto bg-transparent border-2 border-white text-white hover:bg-white/10 hover:text-white px-4 sm:px-10 py-7 text-sm sm:text-lg font-bold rounded-lg uppercase tracking-wide gap-2.5">
                <img src={aboutIcon} alt="" aria-hidden="true" className="w-6 h-6 object-contain" />
                About the Certification
              </Button>
            </Link>
          </div>
        </div>
      </section>

    </div>
  );
}
