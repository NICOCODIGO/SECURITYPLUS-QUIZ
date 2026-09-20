// Every repo path named in CLAUDE.md, docs/*.md and .claude/agents/*.md must exist.
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

import { readFileSync, existsSync } from 'node:fs';
import { globSync } from 'node:fs';
import { resolve, dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');

const FILE_EXT = /\.(js|jsx|mjs|cjs|json|md|sql|java|css|html|sh|yml|yaml|gradle|properties|bat|png|svg)$/;

// Skipped: URLs, anchors, the `@/` import alias, and build output a fresh clone lacks.
const IGNORE = [
  /^https?:/, /^#/, /^mailto:/, /^@/,
  /node_modules/, /^server\/build/, /^server\/\.gradle/, /(^|\/)dist\/?$/,
];

// Referenced on purpose, does not exist yet. Each is something a roadmap phase creates;
// remove the entry when the file lands so the checker starts guarding it for real.
const PLANNED = new Set([
  'infra/',                                   // phase 6, Terraform
  'secapp/src/components/data/source.js',     // phase 3, the Local/RemoteSource seam
]);

const files = [
  'CLAUDE.md',
  ...globSync('docs/*.md', { cwd: root }),
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

    if (!candidates.some((path) => existsSync(path))) missing.push({ file, ref });
  }
}

if (missing.length > 0) {
  console.error(`Doc references that no longer exist (${missing.length}):`);
  for (const { file, ref } of missing) console.error(`  ${file}  ->  ${ref}`);
  console.error('\nFix the path or remove the reference.');
  process.exit(1);
}

console.log(`Doc links OK — ${checked} reference(s) across ${files.length} file(s) all resolve.`);
