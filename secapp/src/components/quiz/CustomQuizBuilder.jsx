import React, { useMemo, useState } from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Switch } from '@/components/ui/switch';
import {
  Sparkles,
  RotateCcw,
  XCircle,
  Flag,
  Clock,
  ArrowRight,
  AlertCircle,
  Wrench,
} from 'lucide-react';
import { createPageUrl } from '@/lib/utils';
import { securityDomains } from '../data/securityDomains';
import {
  POOL_KINDS,
  POOL_LABELS,
  POOL_DESCRIPTIONS,
  getQuestionPools,
  buildCustomPool,
  shuffle,
} from '../data/questionPools';
import OptionChips from './OptionChips';

/**
 * Build a quiz from your own history: questions you've never seen, ones you
 * already answered, ones you got wrong, and ones you flagged.
 *
 * The first three come straight out of `quiz_history` — no extra bookkeeping
 * — because TakeQuiz records which question ids were answered and whether
 * each was correct.
 */

const POOL_ICONS = {
  new: Sparkles,
  answered: RotateCcw,
  incorrect: XCircle,
  flagged: Flag,
};

const COUNT_PRESETS = [10, 20, 30, 50];
const DIFFICULTIES = ['Beginner', 'Intermediate', 'Advanced'];

export default function CustomQuizBuilder() {
  const [selectedPools, setSelectedPools] = useState(['incorrect']);
  const [domainIds, setDomainIds] = useState([]);
  const [difficulties, setDifficulties] = useState([]);
  const [questionCount, setQuestionCount] = useState(10);
  const [timerEnabled, setTimerEnabled] = useState(false);

  // Pools only change when a quiz is submitted or a flag toggled, neither of
  // which happens while this screen is open.
  const pools = useMemo(() => getQuestionPools(), []);

  const matching = useMemo(
    () => buildCustomPool({ pools: selectedPools, domainIds, difficulties }),
    [selectedPools, domainIds, difficulties]
  );

  const countOptions = useMemo(() => {
    const presets = COUNT_PRESETS.filter((n) => n < matching.length);
    return matching.length > 0 ? [...presets, matching.length] : [];
  }, [matching.length]);

  const effectiveCount = Math.min(questionCount, matching.length);

  const toggle = (list, setList, value) =>
    setList(list.includes(value) ? list.filter((v) => v !== value) : [...list, value]);

  const handleStart = () => {
    const selected = shuffle(matching).slice(0, effectiveCount);

    const quizId = `quiz_${Date.now()}`;
    sessionStorage.setItem(quizId, JSON.stringify(selected));

    const params = new URLSearchParams({
      type: 'custom',
      domain: 'Custom Quiz',
      timer: timerEnabled.toString(),
      quizId,
      returnTo: 'custom',
    });
    window.location.href = createPageUrl('TakeQuiz') + '?' + params.toString();
  };

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-3xl font-black text-comptia-charcoal">Build Your Own Quiz</h2>
        <p className="text-slate-600 mt-2">
          Target exactly what you need to work on — new material, past mistakes, or anything you flagged.
        </p>
      </div>

      {/* Pools */}
      <Card className="border-2 border-slate-200 shadow-lg">
        <CardContent className="p-6 space-y-4">
          <div>
            <p className="text-sm font-bold text-comptia-charcoal">Pick your questions from</p>
            <p className="text-xs text-slate-600 mt-0.5">
              Choose one or more. Overlapping pools are merged, never duplicated.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {POOL_KINDS.map((kind) => {
              const Icon = POOL_ICONS[kind];
              const active = selectedPools.includes(kind);
              const count = pools[kind].length;
              const empty = count === 0;

              return (
                <button
                  key={kind}
                  type="button"
                  disabled={empty}
                  aria-pressed={active}
                  onClick={() => toggle(selectedPools, setSelectedPools, kind)}
                  className={`flex items-start gap-3 p-4 rounded-xl border-2 text-left transition-all ${
                    empty
                      ? 'border-slate-100 bg-slate-50 cursor-not-allowed'
                      : active
                      ? 'border-red-600 bg-red-50 shadow-sm'
                      : 'border-slate-200 bg-white hover:border-slate-400'
                  }`}
                >
                  <span
                    className={`w-10 h-10 flex-shrink-0 rounded-lg flex items-center justify-center ${
                      empty ? 'bg-slate-200' : active ? 'bg-red-600' : 'bg-slate-100'
                    }`}
                  >
                    <Icon
                      className={`w-5 h-5 ${
                        empty ? 'text-slate-400' : active ? 'text-white' : 'text-slate-600'
                      }`}
                    />
                  </span>
                  <span className="min-w-0 flex-1">
                    <span className="flex items-baseline justify-between gap-2">
                      <span className={`text-sm font-bold ${empty ? 'text-slate-400' : 'text-comptia-charcoal'}`}>
                        {POOL_LABELS[kind]}
                      </span>
                      <span className={`text-sm font-black tabular-nums ${empty ? 'text-slate-300' : 'text-red-600'}`}>
                        {count}
                      </span>
                    </span>
                    <span className={`block text-xs mt-0.5 ${empty ? 'text-slate-400' : 'text-slate-600'}`}>
                      {empty ? emptyReason(kind) : POOL_DESCRIPTIONS[kind]}
                    </span>
                  </span>
                </button>
              );
            })}
          </div>
        </CardContent>
      </Card>

      {/* Filters */}
      <Card className="border-2 border-slate-200 shadow-lg">
        <CardContent className="p-6 space-y-6">
          <div>
            <p className="text-sm font-bold text-comptia-charcoal mb-1">Domains</p>
            <p className="text-xs text-slate-600 mb-3">Leave all unselected to include every domain.</p>
            <div className="flex flex-wrap gap-2">
              {securityDomains.map((domain) => {
                const active = domainIds.includes(domain.quizLabel);
                return (
                  <button
                    key={domain.id}
                    type="button"
                    aria-pressed={active}
                    onClick={() => toggle(domainIds, setDomainIds, domain.quizLabel)}
                    className={`inline-flex items-center gap-2 pl-1.5 pr-4 py-1.5 rounded-full border-2 text-sm font-bold transition-all ${
                      active
                        ? 'border-red-600 bg-red-50 text-comptia-charcoal'
                        : 'border-slate-200 bg-white text-slate-600 hover:border-slate-400'
                    }`}
                  >
                    <span className={`w-7 h-7 rounded-full bg-white border-2 ${domain.ringColor} flex items-center justify-center`}>
                      <img src={domain.icon} alt="" className="w-4 h-4" />
                    </span>
                    {domain.number}
                  </button>
                );
              })}
            </div>
          </div>

          <div>
            <p className="text-sm font-bold text-comptia-charcoal mb-1">Difficulty</p>
            <p className="text-xs text-slate-600 mb-3">Leave all unselected for a mix.</p>
            <div className="flex flex-wrap gap-2">
              {DIFFICULTIES.map((level) => {
                const active = difficulties.includes(level);
                return (
                  <button
                    key={level}
                    type="button"
                    aria-pressed={active}
                    onClick={() => toggle(difficulties, setDifficulties, level)}
                    className={`px-4 py-2.5 rounded-xl border-2 text-sm font-bold transition-all ${
                      active
                        ? 'border-red-600 bg-red-600 text-white'
                        : 'border-slate-200 bg-white text-slate-700 hover:border-slate-400'
                    }`}
                  >
                    {level}
                  </button>
                );
              })}
            </div>
          </div>

          {countOptions.length > 0 && (
            <OptionChips
              label="Number of questions"
              options={countOptions.map((n) => ({
                value: n,
                label: n === matching.length ? `All ${n}` : `${n}`,
              }))}
              value={effectiveCount}
              onChange={setQuestionCount}
            />
          )}

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
        </CardContent>
      </Card>

      {/* Summary + start */}
      <Card className="border-2 border-slate-200 shadow-lg overflow-hidden">
        <div className="bg-comptia-charcoal px-6 py-5 flex items-center gap-3">
          <Wrench className="w-5 h-5 text-red-400" />
          <div>
            <p className="text-sm font-black text-white uppercase tracking-wide">Your quiz</p>
            <p className="text-xs text-slate-400">
              {matching.length} question{matching.length === 1 ? '' : 's'} match your filters
            </p>
          </div>
        </div>
        <CardContent className="p-6">
          {selectedPools.length === 0 ? (
            <Notice text="Pick at least one source above to build a quiz." />
          ) : matching.length === 0 ? (
            <Notice text="No questions match that combination — try removing a domain or difficulty filter." />
          ) : (
            <Button
              onClick={handleStart}
              className="w-full bg-red-600 hover:bg-red-700 text-white h-14 text-base font-bold rounded-xl"
            >
              Start {effectiveCount}-question quiz
              <ArrowRight className="w-5 h-5 ml-2" />
            </Button>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

function emptyReason(kind) {
  if (kind === 'new') return 'You have seen every question — nice work';
  if (kind === 'flagged') return 'Flag questions during a quiz to collect them here';
  return 'Take a quiz first to fill this pool';
}

function Notice({ text }) {
  return (
    <div className="flex items-center gap-3 p-4 bg-amber-50 border-2 border-amber-200 rounded-xl">
      <AlertCircle className="w-5 h-5 text-amber-700 flex-shrink-0" />
      <p className="text-sm text-amber-900 font-medium">{text}</p>
    </div>
  );
}
