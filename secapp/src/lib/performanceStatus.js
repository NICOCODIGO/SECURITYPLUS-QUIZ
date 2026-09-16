// Shared thresholds and status colours for quiz accuracy.
//
// Accuracy is a *state* (doing fine / shaky / weak), not an identity, so it
// gets status colours rather than per-domain hues — the domain's own icon and
// title carry identity. Every place these colours appear they are paired with
// the numeric value and the `label` below, so the meaning never rests on
// colour alone (red/green is the classic colour-vision trap).
//
// The three hexes were checked against the surface and each other for
// colour-vision separation; don't swap them for lighter Tailwind steps
// without re-checking — amber and red collapse into each other easily.

export const PASSING_ACCURACY = 70;

const STATUSES = {
  good: {
    key: 'good',
    label: 'On track',
    color: '#047857',
    text: 'text-emerald-800',
    bg: 'bg-emerald-50',
    border: 'border-emerald-200',
  },
  warning: {
    key: 'warning',
    label: 'Shaky',
    color: '#D97706',
    text: 'text-amber-800',
    bg: 'bg-amber-50',
    border: 'border-amber-200',
  },
  critical: {
    key: 'critical',
    label: 'Needs work',
    color: '#C8102E',
    text: 'text-red-800',
    bg: 'bg-red-50',
    border: 'border-red-200',
  },
};

export const statusForAccuracy = (accuracy) => {
  if (accuracy >= 80) return STATUSES.good;
  if (accuracy >= 60) return STATUSES.warning;
  return STATUSES.critical;
};

export const NEUTRAL_STATUS = {
  key: 'none',
  label: 'Not attempted',
  color: '#94A3B8',
  text: 'text-slate-500',
  bg: 'bg-slate-50',
  border: 'border-slate-200',
};
