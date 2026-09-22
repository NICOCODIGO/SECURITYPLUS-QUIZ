// Lint, compared against a recorded baseline instead of against zero.
//
//   npm run lint:check                      whole project
//   npm run lint:check -- --update          re-record the baseline
//   node scripts/lint-baseline.mjs --file <path>    one file (used by the edit hook)
//
// `npm run lint` can't answer "did I make this worse?" on its own: this repo
// carries 6 pre-existing problems, so eslint always exits non-zero and the
// only signal is a count you have to remember and eyeball. That is a bad
// check for a person and a worse one for an agent — a regression looks
// exactly like the status quo.
//
// Problems are fingerprinted as `file:rule` rather than just counted, so
// fixing one error and introducing a different one is still caught. The
// baseline can only shrink silently; any new fingerprint, or more hits of an
// existing one, fails the run.

import { ESLint } from 'eslint';
import { readFileSync, writeFileSync, existsSync } from 'node:fs';
import { relative, resolve, dirname, isAbsolute } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const BASELINE_PATH = resolve(root, '.lint-baseline.json');

const argv = process.argv.slice(2);
const update = argv.includes('--update');
const fileFlag = argv.indexOf('--file');
const singleFile = fileFlag !== -1 ? argv[fileFlag + 1] : null;

const eslint = new ESLint({ cwd: root });

/** Every problem as { "src/file.jsx:rule-name": hitCount }, plus the raw totals. */
async function collect(patterns) {
  const results = await eslint.lintFiles(patterns);
  const counts = {};
  let errors = 0;
  let warnings = 0;

  for (const result of results) {
    for (const message of result.messages) {
      // Forward slashes always: the baseline is committed, and without this
      // every entry reads as both fixed and new when the suite runs on Windows.
      const path = relative(root, result.filePath).replaceAll('\\', '/');
      const key = `${path}:${message.ruleId ?? 'fatal-parse-error'}`;
      counts[key] = (counts[key] ?? 0) + 1;
      if (message.severity === 2) errors += 1;
      else warnings += 1;
    }
  }

  // Sorted so the committed file diffs cleanly rather than reordering itself.
  const sorted = Object.fromEntries(Object.entries(counts).sort(([a], [b]) => a.localeCompare(b)));
  return { counts: sorted, errors, warnings, results };
}

function readBaseline() {
  if (!existsSync(BASELINE_PATH)) return null;
  return JSON.parse(readFileSync(BASELINE_PATH, 'utf8'));
}

/* ------------------------------------------------------ single-file mode -- */

// Used by the PostToolUse hook after every edit. Scoped to one file so it
// stays fast enough to run on every write, and still baseline-aware so
// touching TakeQuiz.jsx doesn't re-report the unused var that was already
// there before the edit.
if (singleFile) {
  const abs = isAbsolute(singleFile) ? singleFile : resolve(process.cwd(), singleFile);

  if (!existsSync(abs) || (await eslint.isPathIgnored(abs))) process.exit(0);

  const { counts, results } = await collect([abs]);
  const baseline = readBaseline();
  const known = baseline?.counts ?? {};

  const added = Object.entries(counts).filter(([key, count]) => count > (known[key] ?? 0));
  if (added.length === 0) process.exit(0);

  const formatter = await eslint.loadFormatter('stylish');
  console.error(`New lint problems introduced in ${relative(root, abs)}:\n`);
  console.error(await formatter.format(results));
  console.error(
    added.length === Object.keys(counts).length
      ? 'All of the above are new.'
      : `New fingerprints: ${added.map(([k]) => k).join(', ')}\n(Other problems in this file predate the edit and are in .lint-baseline.json.)`,
  );
  process.exit(1);
}

/* ----------------------------------------------------- whole-project mode -- */

const { counts, errors, warnings } = await collect(['.']);
const total = errors + warnings;

if (update) {
  writeFileSync(BASELINE_PATH, `${JSON.stringify({ errors, warnings, counts }, null, 2)}\n`);
  console.log(`Baseline recorded: ${errors} error(s), ${warnings} warning(s) across ${Object.keys(counts).length} fingerprint(s).`);
  process.exit(0);
}

const baseline = readBaseline();
if (!baseline) {
  console.error('No .lint-baseline.json. Create it with:  npm run lint:check -- --update');
  process.exit(1);
}

const added = [];
const fixed = [];

for (const [key, count] of Object.entries(counts)) {
  const was = baseline.counts[key] ?? 0;
  if (count > was) added.push(`${key}  (${was} -> ${count})`);
}
for (const [key, was] of Object.entries(baseline.counts)) {
  const now = counts[key] ?? 0;
  if (now < was) fixed.push(`${key}  (${was} -> ${now})`);
}

if (fixed.length > 0) {
  console.log(`Fixed since the baseline (${fixed.length}):`);
  for (const line of fixed) console.log(`  - ${line}`);
  console.log('Lock the improvement in with:  npm run lint:check -- --update\n');
}

if (added.length > 0) {
  console.error(`New lint problems (${added.length}):`);
  for (const line of added) console.error(`  + ${line}`);
  console.error(`\nTotal is now ${total} (baseline ${baseline.errors + baseline.warnings}). Run \`npm run lint\` for the full text.`);
  process.exit(1);
}

console.log(`Lint OK — ${errors} error(s), ${warnings} warning(s), all known. Baseline unchanged.`);
