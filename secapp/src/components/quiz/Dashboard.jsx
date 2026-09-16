import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { FileText, Wrench, ArrowRight, TrendingDown } from 'lucide-react';
import { securityDomains } from '../data/securityDomains';
import QuestionOfTheDay from './QuestionOfTheDay';

export default function Dashboard({ onSectionChange }) {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-black text-comptia-charcoal">Practice Quizzes</h1>
        <p className="text-slate-600 mt-2">
          Warm up with today's question, drill a single domain, or build a quiz from your own weak spots.
        </p>
      </div>

      <QuestionOfTheDay />

      {/* Mock exam + custom builder */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <FeatureCard
          icon={FileText}
          title="Mock Exam Simulator"
          description="A full-length practice test — 90 questions, 90-minute timer, weighted like the real SY0-701."
          cta="Start mock exam"
          onClick={() => onSectionChange('mock')}
          tone="red"
        />
        <FeatureCard
          icon={Wrench}
          title="Build Your Own Quiz"
          description="Pull from questions you've never seen, ones you got wrong, or anything you flagged for review."
          cta="Build a quiz"
          onClick={() => onSectionChange('custom')}
          tone="charcoal"
        />
      </div>

      <div>
        <h2 className="text-xl font-black text-comptia-charcoal mb-4">Practice by Domain</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {securityDomains.map((domain) => (
            <button
              key={domain.id}
              onClick={() => onSectionChange(domain.id)}
              className="text-left"
            >
              <Card className={`h-full border-2 border-slate-200 ${domain.hoverBorder} hover:shadow-xl transition-all`}>
                <CardContent className="p-5">
                  <div className="flex items-start gap-4">
                    <div className={`w-14 h-14 flex-shrink-0 rounded-full bg-white border-4 ${domain.ringColor} shadow-sm flex items-center justify-center`}>
                      <img src={domain.icon} alt="" className="w-8 h-8" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-slate-500 uppercase tracking-wide">
                        Domain {domain.number}
                      </p>
                      <h3 className="font-black text-comptia-charcoal leading-snug mt-0.5">
                        {domain.title}
                      </h3>
                      <p className="text-xs text-slate-600 mt-1.5 line-clamp-2">{domain.topics}</p>

                      <div className="flex flex-wrap items-center gap-2 mt-3">
                        <span className={`text-xs font-bold ${domain.badgeColor} border px-3 py-1 rounded-full`}>
                          {domain.weight} of exam
                        </span>
                        <span className="text-xs font-bold text-slate-600 bg-slate-100 border border-slate-200 px-3 py-1 rounded-full">
                          {domain.questionCount} questions
                        </span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </button>
          ))}
        </div>
      </div>

      <Card className="border-2 border-slate-200">
        <CardContent className="p-5">
          <button
            onClick={() => onSectionChange('weakest')}
            className="w-full flex items-center gap-4 text-left group"
          >
            <div className="w-12 h-12 flex-shrink-0 rounded-lg bg-amber-100 border-2 border-amber-200 flex items-center justify-center">
              <TrendingDown className="w-6 h-6 text-amber-700" />
            </div>
            <div className="flex-1 min-w-0">
              <h3 className="font-black text-comptia-charcoal">Weakest Subject Practice</h3>
              <p className="text-sm text-slate-600">
                20 questions from whichever domain you score lowest in.
              </p>
            </div>
            <ArrowRight className="w-5 h-5 text-slate-400 group-hover:text-red-600 group-hover:translate-x-1 transition-all flex-shrink-0" />
          </button>
        </CardContent>
      </Card>
    </div>
  );
}

function FeatureCard({ icon, title, description, cta, onClick, tone }) {
  const Icon = icon;
  const red = tone === 'red';

  return (
    <Card
      className={`h-full border-2 shadow-lg overflow-hidden ${
        red ? 'border-red-600' : 'border-comptia-charcoal'
      }`}
    >
      <CardContent className="p-0 h-full flex flex-col">
        <div className={`px-5 py-4 flex items-center gap-3 ${red ? 'bg-red-600' : 'bg-comptia-charcoal'}`}>
          <Icon className="w-6 h-6 text-white flex-shrink-0" />
          <h3 className="text-lg font-black text-white">{title}</h3>
        </div>
        <div className="p-5 flex-1 flex flex-col gap-4">
          <p className="text-sm text-slate-600 flex-1">{description}</p>
          <button
            onClick={onClick}
            className={`inline-flex items-center justify-center gap-2 font-bold px-5 py-2.5 rounded-lg transition-all text-sm text-white ${
              red ? 'bg-red-600 hover:bg-red-700' : 'bg-comptia-charcoal hover:bg-comptia-charcoal-light'
            }`}
          >
            {cta}
            <ArrowRight className="w-4 h-4" />
          </button>
        </div>
      </CardContent>
    </Card>
  );
}
