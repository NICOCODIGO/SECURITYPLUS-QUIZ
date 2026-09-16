import React, { useMemo, useState } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Switch } from '@/components/ui/switch';
import { ArrowRight, Clock, Layers, BarChart3 } from 'lucide-react';
import { createPageUrl } from '@/lib/utils';
import { getDomainById } from '../data/securityDomains';
import { shuffle } from '../data/questionPools';
import OptionChips from './OptionChips';

/**
 * Setup screen for a single domain quiz.
 *
 * Takes its colour, icon and ring from the domain's own metadata so it reads
 * as a continuation of the domain cards on Home and About, rather than a
 * generic red form.
 *
 * Question count is a set of presets rather than a slider — the old range
 * input let you pick 37 questions, which is a choice nobody needs to make,
 * and it could exceed the number of questions actually available.
 */

const COUNT_PRESETS = [10, 20, 30, 50];
const DIFFICULTIES = ['All', 'Beginner', 'Intermediate', 'Advanced'];

export default function DomainQuiz({ domain, questions }) {
  const [difficulty, setDifficulty] = useState('All');
  const [questionCount, setQuestionCount] = useState(10);
  const [timerEnabled, setTimerEnabled] = useState(false);

  // `domain` arrives from Lessons as a trimmed object; pull the full record
  // for the icon and colour tokens.
  const meta = getDomainById(domain.id);

  const available = useMemo(
    () =>
      difficulty === 'All'
        ? questions
        : questions.filter((q) => q.difficulty === difficulty),
    [questions, difficulty]
  );

  // Never offer more questions than exist at the chosen difficulty.
  const countOptions = useMemo(() => {
    const presets = COUNT_PRESETS.filter((n) => n < available.length);
    return [...presets, available.length];
  }, [available.length]);

  const effectiveCount = Math.min(questionCount, available.length);

  const difficultyCounts = useMemo(() => {
    const counts = { All: questions.length };
    DIFFICULTIES.slice(1).forEach((level) => {
      counts[level] = questions.filter((q) => q.difficulty === level).length;
    });
    return counts;
  }, [questions]);

  const handleStartQuiz = () => {
    const selected = shuffle(available).slice(0, effectiveCount);

    const quizId = `quiz_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(selected));

    const params = new URLSearchParams({
      type: 'domain',
      domain: domain.title,
      domainId: domain.id,
      percentage: domain.percentage,
      difficulty,
      timer: timerEnabled.toString(),
      quizId,
    });
    window.location.href = createPageUrl('TakeQuiz') + '?' + params.toString();
  };

  return (
    <Card className="border-2 border-slate-200 shadow-lg overflow-hidden">
      {/* Domain header — icon in its own colour ring, on charcoal. */}
      <div className="bg-comptia-charcoal px-6 py-6">
        <div className="flex items-center gap-4">
          {meta && (
            <div className={`w-16 h-16 flex-shrink-0 rounded-full bg-white border-4 ${meta.ringColor} shadow-lg flex items-center justify-center`}>
              <img src={meta.icon} alt="" className="w-9 h-9" />
            </div>
          )}
          <div className="min-w-0">
            <p className="text-xs font-bold text-slate-400 uppercase tracking-widest">
              Domain {meta ? meta.number : ''} · {domain.percentage} of exam
            </p>
            <h2 className="text-2xl font-black text-white leading-tight mt-0.5">
              {meta ? meta.title : domain.title}
            </h2>
            <p className="text-sm text-slate-400 mt-1">{domain.description}</p>
          </div>
        </div>
      </div>

      <CardContent className="p-6 space-y-6">
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <Stat icon={Layers} label="In this domain" value={`${questions.length} questions`} />
          <Stat icon={BarChart3} label="Exam weight" value={domain.percentage} />
          <Stat
            icon={Clock}
            label="Estimated time"
            value={`~${Math.max(1, Math.round(effectiveCount * 0.75))} min`}
          />
        </div>

        <OptionChips
          label="Difficulty"
          options={DIFFICULTIES.map((level) => ({
            value: level,
            label: level,
            hint: `${difficultyCounts[level]}`,
            disabled: difficultyCounts[level] === 0,
          }))}
          value={difficulty}
          onChange={setDifficulty}
        />

        <OptionChips
          label="Number of questions"
          options={countOptions.map((n) => ({
            value: n,
            label: n === available.length ? `All ${n}` : `${n}`,
          }))}
          value={effectiveCount}
          onChange={setQuestionCount}
        />

        <label className="flex items-center justify-between gap-4 p-4 bg-slate-50 rounded-xl border-2 border-slate-200 cursor-pointer">
          <span className="flex items-center gap-3">
            <Clock className="w-5 h-5 text-slate-600" />
            <span>
              <span className="block text-sm font-bold text-comptia-charcoal">Time limit</span>
              <span className="block text-xs text-slate-600">
                {timerEnabled
                  ? `${effectiveCount} minutes — 1 minute per question`
                  : 'Take as long as you need'}
              </span>
            </span>
          </span>
          <Switch checked={timerEnabled} onCheckedChange={setTimerEnabled} />
        </label>

        <Button
          onClick={handleStartQuiz}
          className="w-full bg-red-600 hover:bg-red-700 text-white h-14 text-base font-bold rounded-xl"
          disabled={available.length === 0}
        >
          Start {effectiveCount}-question quiz
          <ArrowRight className="w-5 h-5 ml-2" />
        </Button>
      </CardContent>
    </Card>
  );
}

function Stat({ icon, label, value }) {
  const Icon = icon;
  return (
    <div className="flex items-center gap-3 p-3 bg-slate-50 rounded-xl border border-slate-200">
      <Icon className="w-4 h-4 text-slate-500 flex-shrink-0" />
      <div className="min-w-0">
        <p className="text-[11px] font-bold text-slate-500 uppercase tracking-wide">{label}</p>
        <p className="text-sm font-bold text-comptia-charcoal truncate">{value}</p>
      </div>
    </div>
  );
}
