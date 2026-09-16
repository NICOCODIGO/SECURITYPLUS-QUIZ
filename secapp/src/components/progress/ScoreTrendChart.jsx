import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { TrendingUp } from 'lucide-react';

/**
 * Score per attempt, oldest to newest.
 *
 * Hand-rolled SVG — the project has no chart library, and one line plus a
 * reference rule does not justify adding one. Single series, so no legend:
 * the card title says what is plotted. Only the final point is directly
 * labelled; the Recent Activity table below lists every score, so no value
 * is reachable only by hovering.
 */

const W = 720;
const H = 260;
const PAD = { top: 20, right: 56, bottom: 34, left: 40 };
const PLOT_W = W - PAD.left - PAD.right;
const PLOT_H = H - PAD.top - PAD.bottom;

// 750/900 on the real exam. TakeQuiz uses the same figure to mark a mock
// pass/fail, so the chart and the results screen agree.
const PASS_MARK = 83;

const SERIES = '#C8102E';
const GRID = '#E2E8F0';
const INK_MUTED = '#64748B';

export default function ScoreTrendChart({ trend }) {
  const [active, setActive] = useState(null);

  if (trend.length < 2) {
    return (
      <Card className="border-2 border-slate-200 shadow-lg">
        <CardHeader>
          <CardTitle className="text-xl font-bold text-comptia-charcoal">Score Trend</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col items-center justify-center gap-3 py-12 text-center">
            <TrendingUp className="w-10 h-10 text-slate-300" />
            <p className="text-sm text-slate-600">
              {trend.length === 0
                ? 'Take a quiz to start plotting your scores.'
                : 'One attempt so far — take another to see a trend.'}
            </p>
          </div>
        </CardContent>
      </Card>
    );
  }

  const x = (i) =>
    PAD.left + (trend.length === 1 ? PLOT_W / 2 : (i / (trend.length - 1)) * PLOT_W);
  const y = (score) => PAD.top + PLOT_H - (score / 100) * PLOT_H;

  const points = trend.map((point, i) => ({ ...point, cx: x(i), cy: y(point.score) }));
  const linePath = points.map((p, i) => `${i === 0 ? 'M' : 'L'}${p.cx},${p.cy}`).join(' ');
  const areaPath = `${linePath} L${points[points.length - 1].cx},${PAD.top + PLOT_H} L${points[0].cx},${PAD.top + PLOT_H} Z`;

  const last = points[points.length - 1];
  const first = points[0];
  const change = last.score - first.score;
  const shown = active !== null ? points[active] : null;

  return (
    <Card className="border-2 border-slate-200 shadow-lg">
      <CardHeader>
        <div className="flex items-start justify-between gap-4 flex-wrap">
          <div>
            <CardTitle className="text-xl font-bold text-comptia-charcoal">Score Trend</CardTitle>
            <p className="text-sm text-slate-600">
              Every attempt, oldest to newest.
            </p>
          </div>
          <div className="text-right">
            <p className="text-xs font-bold text-slate-500 uppercase tracking-wide">
              Since first attempt
            </p>
            <p className={`text-2xl font-black ${change >= 0 ? 'text-emerald-700' : 'text-red-700'}`}>
              {change >= 0 ? '+' : ''}{change} pts
            </p>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <svg
          viewBox={`0 0 ${W} ${H}`}
          className="w-full h-auto"
          role="img"
          aria-label={`Quiz scores across ${trend.length} attempts, from ${first.score}% to ${last.score}%.`}
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

          {/* Mock-exam pass mark. A reference value, not a gridline. */}
          <line
            x1={PAD.left} x2={PAD.left + PLOT_W}
            y1={y(PASS_MARK)} y2={y(PASS_MARK)}
            stroke={SERIES} strokeWidth="1" opacity="0.35"
          />
          <text
            x={PAD.left + PLOT_W + 6} y={y(PASS_MARK) + 4}
            fontSize="11" fill={INK_MUTED}
          >
            Pass {PASS_MARK}%
          </text>

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
                x={p.cx - PLOT_W / (trend.length * 2) - 6}
                y={PAD.top}
                width={PLOT_W / trend.length + 12}
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
      </CardContent>
    </Card>
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
