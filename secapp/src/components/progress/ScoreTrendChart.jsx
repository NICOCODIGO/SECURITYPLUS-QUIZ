import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { ArrowDown, ArrowUp, TrendingUp } from 'lucide-react';

/**
 * Score per practice quiz — domain, weakest-subject and custom — oldest to
 * newest. `trend` is getScoreTrend's { practice, mock }; only `practice` is
 * plotted. Mock exams are deliberately absent: a 10-question quiz and a
 * 90-question mock on one line made a bad quiz look like a failed exam, and
 * the ReadinessCard beside this one already tracks mock scores against the
 * pass mark.
 *
 * Hand-rolled SVG — the project has no chart library, and a single line does
 * not justify adding one. One series, so no legend: the card title says what
 * is plotted. Only the final point is directly labelled; the Recent Activity
 * table below lists every score, so no value is reachable only by hovering.
 */

const W = 720;
const H = 260;
const PAD = { top: 20, right: 56, bottom: 34, left: 40 };
const PLOT_W = W - PAD.left - PAD.right;
const PLOT_H = H - PAD.top - PAD.bottom;

const SERIES = '#C8102E';
const GRID = '#E2E8F0';
const INK_MUTED = '#64748B';

export default function ScoreTrendChart({ trend, className = '' }) {
  const series = trend.practice;
  const change = series.length >= 2 ? series[series.length - 1].score - series[0].score : null;

  return (
    <Card className={`border border-slate-200 shadow-sm min-w-0 overflow-hidden ${className}`}>
      <CardHeader className="p-5 pb-2">
        <div className="flex items-start justify-between gap-4 flex-wrap">
          <div>
            <CardTitle className="text-base font-bold text-comptia-charcoal">Score Trend</CardTitle>
            <p className="text-xs text-slate-500 mt-1">
              Every practice quiz, oldest to newest. Mock exams are tracked under Exam readiness.
            </p>
          </div>

          {/* Held in place (invisibly) with fewer than two quizzes, so the
              header doesn't reflow once the line appears. */}
          <div
            className={`text-right ${change === null ? 'invisible' : ''}`}
            aria-hidden={change === null ? 'true' : undefined}
          >
            <p className="text-[11px] font-bold text-slate-500 uppercase tracking-wide">Since first quiz</p>
            {/* An arrow instead of a +/- sign. The arrow is decorative, so
                the direction is spelled out for screen readers. */}
            {change === null || change === 0 ? (
              <p className="text-xl font-black text-slate-500">No change</p>
            ) : (
              <p
                className={`flex items-center justify-end gap-1 text-xl font-black tabular-nums ${
                  change > 0 ? 'text-emerald-700' : 'text-red-700'
                }`}
              >
                {change > 0 ? (
                  <ArrowUp className="w-5 h-5" strokeWidth={3} aria-hidden="true" />
                ) : (
                  <ArrowDown className="w-5 h-5" strokeWidth={3} aria-hidden="true" />
                )}
                <span className="sr-only">{change > 0 ? 'Up ' : 'Down '}</span>
                {Math.abs(change)} pts
              </p>
            )}
          </div>
        </div>
      </CardHeader>
      <CardContent className="px-5 pb-5">
        {series.length >= 2 ? (
          <Plot series={series} />
        ) : (
          // The plot's own shape, so the card is the same height either way.
          <div
            className="flex flex-col items-center justify-center gap-3 text-center px-6"
            style={{ aspectRatio: `${W} / ${H}` }}
          >
            <TrendingUp className="w-10 h-10 text-slate-300" />
            <p className="text-sm text-slate-600">
              {series.length === 0
                ? 'No practice quizzes yet. Take one to start plotting your scores.'
                : 'One practice quiz so far — take another to see a trend.'}
            </p>
          </div>
        )}
      </CardContent>
    </Card>
  );
}

function Plot({ series }) {
  const [active, setActive] = useState(null);

  const x = (i) => PAD.left + (i / (series.length - 1)) * PLOT_W;
  const y = (score) => PAD.top + PLOT_H - (score / 100) * PLOT_H;

  const points = series.map((point, i) => ({ ...point, cx: x(i), cy: y(point.score) }));
  const linePath = points.map((p, i) => `${i === 0 ? 'M' : 'L'}${p.cx},${p.cy}`).join(' ');
  const areaPath = `${linePath} L${points[points.length - 1].cx},${PAD.top + PLOT_H} L${points[0].cx},${PAD.top + PLOT_H} Z`;

  const last = points[points.length - 1];
  const first = points[0];
  const shown = active !== null ? points[active] : null;

  return (
    <div className="w-full min-w-0 overflow-hidden">
      <svg
        viewBox={`0 0 ${W} ${H}`}
        className="block w-full h-auto"
        role="img"
        aria-label={`Practice quiz scores across ${series.length} attempts, from ${first.score}% to ${last.score}%.`}
      >
        {/* Gridlines — solid hairlines, one step off the surface. */}
        {[0, 25, 50, 75, 100].map((tick) => (
          <g key={tick}>
            <line
              x1={PAD.left} x2={PAD.left + PLOT_W}
              y1={y(tick)} y2={y(tick)}
              stroke={GRID} strokeWidth="1"
            />
            <text
              x={PAD.left - 10} y={y(tick) + 4}
              textAnchor="end" fontSize="12" fill={INK_MUTED}
              style={{ fontVariantNumeric: 'tabular-nums' }}
            >
              {tick}
            </text>
          </g>
        ))}

        {/* No pass-mark rule here: it is a mock-exam threshold and says
            nothing about a 10-question practice quiz. ReadinessCard draws it. */}

        <path d={areaPath} fill={SERIES} opacity="0.1" />
        <path
          d={linePath}
          fill="none" stroke={SERIES} strokeWidth="2"
          strokeLinejoin="round" strokeLinecap="round"
        />

        {points.map((p, i) => (
          <g
            key={i}
            tabIndex={0}
            role="button"
            aria-label={`${p.label}: ${p.score}%`}
            onMouseEnter={() => setActive(i)}
            onMouseLeave={() => setActive(null)}
            onFocus={() => setActive(i)}
            onBlur={() => setActive(null)}
            style={{ cursor: 'pointer', outline: 'none' }}
          >
            {/* Generous invisible hit area — the visible dot is far below
                the ~24px minimum target on its own. */}
            <rect
              x={p.cx - PLOT_W / (series.length * 2) - 6}
              y={PAD.top}
              width={PLOT_W / series.length + 12}
              height={PLOT_H}
              fill="transparent"
            />
            <circle
              cx={p.cx} cy={p.cy} r={active === i ? 6 : 4}
              fill={SERIES} stroke="#FFFFFF" strokeWidth="2"
            />
          </g>
        ))}

        {/* Endpoint is the one directly-labelled value. */}
        <text
          x={last.cx + 10} y={last.cy + 4}
          fontSize="13" fontWeight="700" fill="#1D252D"
          stroke="#FFFFFF" strokeWidth="4" paintOrder="stroke"
          style={{ fontVariantNumeric: 'tabular-nums' }}
        >
          {last.score}%
        </text>

        <text x={PAD.left} y={H - 10} fontSize="11" fill={INK_MUTED}>
          Oldest
        </text>
        <text x={PAD.left + PLOT_W} y={H - 10} fontSize="11" fill={INK_MUTED} textAnchor="end">
          Latest
        </text>

        {shown && (
          <g pointerEvents="none">
            <line
              x1={shown.cx} x2={shown.cx}
              y1={PAD.top} y2={PAD.top + PLOT_H}
              stroke={INK_MUTED} strokeWidth="1" opacity="0.4"
            />
            <Tooltip point={shown} />
          </g>
        )}
      </svg>
    </div>
  );
}

function Tooltip({ point }) {
  const text = `${point.label} — ${point.score}%`;
  // Rough advance width; SVG has no text measurement before paint.
  const width = Math.max(120, text.length * 6.6 + 20);
  const flip = point.cx + width + 12 > W;
  const bx = flip ? point.cx - width - 12 : point.cx + 12;
  const by = Math.min(Math.max(point.cy - 34, PAD.top), PAD.top + PLOT_H - 46);

  return (
    <g>
      <rect
        x={bx} y={by} width={width} height={42} rx="6"
        fill="#1D252D" opacity="0.95"
      />
      <text x={bx + 10} y={by + 17} fontSize="11" fill="#CBD5E1">
        {new Date(point.date).toLocaleDateString(undefined, {
          month: 'short',
          day: 'numeric',
        })}
      </text>
      <text x={bx + 10} y={by + 33} fontSize="12" fontWeight="700" fill="#FFFFFF">
        {text}
      </text>
    </g>
  );
}
