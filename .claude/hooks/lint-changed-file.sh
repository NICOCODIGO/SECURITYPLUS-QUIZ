#!/usr/bin/env bash
#
# PostToolUse hook: lint the one file that was just written.
#
# Runs after every Write/Edit. If the edit introduced a *new* lint problem,
# it exits 2, which hands the eslint output back to Claude as a blocking
# error to fix before replying — so lint regressions get caught during the
# edit rather than at review time.
#
# Deliberately a no-op unless the file is a .js/.jsx under secapp/, and
# baseline-aware via .lint-baseline.json, so the 6 pre-existing problems in
# this repo never fire it. A hook that cries wolf gets ignored or disabled.

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

payload="$(cat)"
file="$(printf '%s' "$payload" | jq -r '.tool_response.filePath // .tool_input.file_path // empty' 2>/dev/null)"

# Nothing to lint: no path, a deleted file, or a tool that reports no path.
[ -n "$file" ] || exit 0
[ -f "$file" ] || exit 0

case "$file" in
  "$ROOT"/secapp/*.js | "$ROOT"/secapp/*.jsx) ;;
  *) exit 0 ;;   # not ours: server/, docs, config, any other extension
esac

# npx --no-install: use the eslint from secapp/node_modules, never reach out
# to the network mid-edit. Before `npm install` has run, skip silently.
[ -d "$ROOT/secapp/node_modules/eslint" ] || exit 0

if ! output="$(cd "$ROOT/secapp" && node scripts/lint-baseline.mjs --file "$file" 2>&1)"; then
  printf '%s\n' "$output" >&2
  exit 2
fi

exit 0
