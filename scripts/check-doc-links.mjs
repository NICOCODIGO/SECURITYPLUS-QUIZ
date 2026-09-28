// Every repo path named in the README, CLAUDE.md, docs/*.md, docs/guide/*.md and
// .claude/agents/*.md must exist.
//
//   node scripts/check-doc-links.mjs
//
// The docs are only loaded on demand, which makes them useful and also makes them easy to
// leave behind: a renamed or deleted file breaks a pointer that nothing else would catch,
// and a doc that confidently names a file which no longer exists is worse than no doc.
//
// Two kinds of reference are checked:
//   - markdown links to repo-relative paths, [text](docs/frontend.md)
//   - inline-code paths that look like files, `secapp/src/lib/utils.js`
//
// Inline code is deliberately restricted to things with a known source extension or a
// trailing slash, so prose like `npm run build` and `grid-cols-1` is not mistaken for a
// path.

import { readFileSync } from 'node:fs';
import { globSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { resolve, dirname, join, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');

// What a fresh clone has: tracked files plus new ones not yet committed, minus anything
// gitignored. Checked against THIS rather than the disk, because an ignored path that happens
// to exist locally (infra/.terraform/, .vscode/) passes on the disk and then fails in CI,
// where it doesn't exist. Asking git makes this machine and CI give the same answer.
const inRepo = new Set();
for (const file of execFileSync('git', ['ls-files', '--cached', '--others', '--exclude-standard'], {
  cwd: root,
  encoding: 'utf8',
}).split('\n')) {
  if (!file) continue;
  const parts = file.split('/');
  for (let i = 1; i <= parts.length; i++) inRepo.add(parts.slice(0, i).join('/'));
}

const existsInRepo = (absolute) => {
  const path = relative(root, absolute).split(sep).join('/').replace(/\/$/, '');
  return path === '' || inRepo.has(path);
};

const FILE_EXT = /\.(js|jsx|mjs|cjs|json|md|sql|java|css|html|sh|yml|yaml|gradle|properties|bat|png|svg)$/;

// Skipped: URLs, anchors, the `@/` import alias, the site's home route (a bare `/` in a
// routes table), and build output a fresh clone lacks.
const IGNORE = [
  /^https?:/, /^#/, /^mailto:/, /^@/, /^\/$/,
  /node_modules/, /^server\/build/, /^server\/\.gradle/, /(^|\/)dist\/?$/,
];

// Referenced on purpose, does not exist yet. Each is something a roadmap phase creates;
// remove the entry when the file lands so the checker starts guarding it for real.
// (Empty today: phase 3's source.js and phase 6's infra/ both landed.)
const PLANNED = new Set([]);

// Local-only paths - gitignored, so a fresh clone and CI lack them - fail the check even
// when they exist on this disk. Write them without a trailing slash (`server/bin`,
// `infra/.terraform`), which this checker skips as prose, or add a pattern to IGNORE.
const files = [
  'README.md',
  'CLAUDE.md',
  ...globSync('docs/*.md', { cwd: root }),
  ...globSync('docs/guide/*.md', { cwd: root }),
  ...globSync('.claude/agents/*.md', { cwd: root }),
];

let checked = 0;
const missing = [];

for (const file of files) {
  const source = readFileSync(join(root, file), 'utf8');
  const refs = new Set();

  // [label](path)
  for (const [, target] of source.matchAll(/\[[^\]]*\]\(([^)]+)\)/g)) {
    refs.add(target.split('#')[0].trim());
  }
  // `path/like/this.ext` or `path/like/this/`
  for (const [, code] of source.matchAll(/`([^`\n]+)`/g)) {
    const candidate = code.trim();
    if (!candidate.includes('/')) continue;
    if (/\s/.test(candidate)) continue;           // `npm run build`
    if (!FILE_EXT.test(candidate) && !candidate.endsWith('/')) continue;
    refs.add(candidate);
  }

  for (const ref of refs) {
    if (!ref || IGNORE.some((re) => re.test(ref))) continue;
    // Globs and <placeholders> describe a shape, not a file.
    if (/[*<>]/.test(ref)) continue;
    if (PLANNED.has(ref)) continue;

    checked += 1;

    // A link inside docs/ resolves relative to docs/; a bare path from the repo root; and
    // the docs commonly use `quiz/Dashboard.jsx` shorthand for paths under secapp/src/.
    const candidates = [
      resolve(root, dirname(file), ref),
      resolve(root, ref),
      resolve(root, 'secapp/src', ref),
    ];

    if (!candidates.some(existsInRepo)) missing.push({ file, ref });
  }
}

if (missing.length > 0) {
  console.error(`Doc references that no longer exist (${missing.length}):`);
  for (const { file, ref } of missing) console.error(`  ${file}  ->  ${ref}`);
  console.error('\nFix the path or remove the reference.');
  process.exit(1);
}

console.log(`Doc links OK — ${checked} reference(s) across ${files.length} file(s) all resolve.`);
