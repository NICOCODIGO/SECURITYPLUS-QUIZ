// PostToolUse hook: lint the one file that was just written.
//
//   node .claude/hooks/lint-changed-file.mjs   < hook payload on stdin
//
// Runs after every Write/Edit. If the edit introduced a *new* lint problem it
// exits 2, which hands the eslint output back to Claude as a blocking error to
// fix before replying — so regressions surface at the edit, not at review.
//
// Written in Node rather than bash on purpose. The previous shell version
// needed `jq`, which Windows does not ship, and it swallowed the failure:
// `jq` missing meant an empty path, which meant a silent exit 0. A guard that
// quietly stops guarding is worse than no guard. Node is guaranteed present —
// this is a Node project — and behaves the same on macOS, Linux and Windows.
//
// Deliberately a no-op unless the file is a .js/.jsx under secapp/, and
// baseline-aware via .lint-baseline.json, so the 6 pre-existing problems in
// this repo never fire it.

import { spawnSync } from 'node:child_process';
import { existsSync, statSync } from 'node:fs';
import { dirname, extname, relative, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const webRoot = resolve(root, 'secapp');

/** Nothing to lint is the common case — exit quietly. */
const skip = () => process.exit(0);

const stdin = await new Promise((resolvePromise) => {
  let data = '';
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', (chunk) => {
    data += chunk;
  });
  process.stdin.on('end', () => resolvePromise(data));
  process.stdin.on('error', () => resolvePromise(''));
});

let payload;
try {
  payload = JSON.parse(stdin);
} catch {
  skip();
}

const file = payload?.tool_response?.filePath || payload?.tool_input?.file_path;
if (!file) skip();

const absolute = resolve(file);

// Deleted, or a directory.
if (!existsSync(absolute) || !statSync(absolute).isFile()) skip();

// Only our front-end JavaScript.
if (!['.js', '.jsx'].includes(extname(absolute))) skip();

const fromWeb = relative(webRoot, absolute);
if (fromWeb.startsWith('..') || fromWeb.startsWith(`..${sep}`)) skip();

// Before `npm install`, there is nothing to lint with.
if (!existsSync(resolve(webRoot, 'node_modules/eslint'))) skip();

const result = spawnSync(process.execPath, ['scripts/lint-baseline.mjs', '--file', absolute], {
  cwd: webRoot,
  encoding: 'utf8',
});

if (result.status !== 0) {
  process.stderr.write(`${result.stdout ?? ''}${result.stderr ?? ''}`);
  process.exit(2);
}

process.exit(0);
