import React from 'react';

/**
 * One headline number on the Progress dashboard's header band, and in Home's
 * progress showcase — the same component in both, so the teaser can't drift
 * from the real thing.
 */
export default function KpiTile({ icon, tint, label, value, detail }) {
  const Icon = icon;
  return (
    <div className="rounded-xl border-2 border-slate-200 bg-white p-4 min-w-0">
      <div className="flex items-center justify-between gap-2">
        <p className="text-xs font-bold text-slate-600">{label}</p>
        <span className={`flex h-8 w-8 flex-shrink-0 items-center justify-center rounded-lg ${tint}`}>
          <Icon className="h-4 w-4 text-white" />
        </span>
      </div>
      <p className="mt-2 text-2xl sm:text-3xl font-black text-comptia-charcoal tabular-nums leading-none">{value}</p>
      <p className="mt-1.5 text-xs text-slate-500 truncate">{detail}</p>
    </div>
  );
}
