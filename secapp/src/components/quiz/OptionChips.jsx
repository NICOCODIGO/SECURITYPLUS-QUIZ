import React from 'react';

/**
 * A labelled row of single-select chips.
 *
 * Replaces the range slider in the quiz setup screens — the useful choices
 * are a handful of presets, and a slider both implies more precision than the
 * question bank supports and hides which values are actually available.
 */
export default function OptionChips({ label, options, value, onChange }) {
  return (
    <div>
      <p className="text-sm font-bold text-comptia-charcoal mb-2.5">{label}</p>
      <div className="flex flex-wrap gap-2">
        {options.map((option) => {
          const active = option.value === value;

          return (
            <button
              key={option.value}
              type="button"
              disabled={option.disabled}
              onClick={() => onChange(option.value)}
              aria-pressed={active}
              className={`px-4 py-2.5 rounded-xl border-2 text-sm font-bold transition-all ${
                option.disabled
                  ? 'border-slate-100 bg-slate-50 text-slate-300 cursor-not-allowed'
                  : active
                  ? 'border-red-600 bg-red-600 text-white shadow-sm'
                  : 'border-slate-200 bg-white text-slate-700 hover:border-slate-400'
              }`}
            >
              {option.label}
              {option.hint !== undefined && (
                <span className={`ml-2 text-xs font-medium ${active ? 'text-white/70' : 'text-slate-400'}`}>
                  {option.hint}
                </span>
              )}
            </button>
          );
        })}
      </div>
    </div>
  );
}
