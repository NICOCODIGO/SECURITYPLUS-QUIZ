#!/usr/bin/env bash
#
# Everything that can say "this is broken", in one command.
#
#   ./verify.sh              front end + back end
#   ./verify.sh --web        front end only (no Docker needed)
#   ./verify.sh --api        back end only
#
# Verification used to be four commands across two directories, which is three
# opportunities to run most of them and call it checked. This runs the lot,
# keeps going after a failure so you get the full picture in one pass, and
# prints a summary at the end.
#
# Backend tests need a Docker daemon for Testcontainers. If one is not running
# they are reported as SKIPPED rather than passed — a check that silently does
# nothing is worse than no check.

set -uo pipefail
cd "$(dirname "$0")"

RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; BOLD=$'\033[1m'; OFF=$'\033[0m'

run_web=true
run_api=true
case "${1:-}" in
  --web) run_api=false ;;
  --api) run_web=false ;;
  "") ;;
  *) echo "usage: $0 [--web|--api]" >&2; exit 2 ;;
esac

names=(); states=()

record() { names+=("$1"); states+=("$2"); }

step() {
  local label="$1"; shift
  printf '\n%s==> %s%s\n' "$BOLD" "$label" "$OFF"
  if "$@"; then
    record "$label" ok
  else
    record "$label" fail
  fi
}

skip() {
  printf '\n%s==> %s  (skipped: %s)%s\n' "$YELLOW" "$1" "$2" "$OFF"
  record "$1" skip
}

# Docs are loaded on demand, so a stale path in them is invisible until it misleads
# someone. Cheap to check, and it runs in both modes because docs span both projects.
step "docs · file references" node scripts/check-doc-links.mjs

# The seed migration is generated from the front end's question bank. A stale
# one is invisible — the app runs, it just serves yesterday's content.
step "content · seed is current" node scripts/generate-seed.mjs --check

if $run_web; then
  step "web · lint (vs baseline)" npm --prefix secapp run --silent lint:check
  step "web · question objectives" npm --prefix secapp run --silent objectives
  step "web · production build"    npm --prefix secapp run --silent build
fi

if $run_api; then
  if docker info >/dev/null 2>&1; then
    step "api · build + tests" ./server/gradlew -p server build
  else
    skip "api · build + tests" "no Docker daemon; Testcontainers cannot start"
    # The compile still tells us something useful without Docker.
    step "api · compile only" ./server/gradlew -p server compileTestJava
  fi
fi

printf '\n%s──────── summary ────────%s\n' "$BOLD" "$OFF"
failed=0
for i in "${!names[@]}"; do
  case "${states[$i]}" in
    ok)   printf '  %sPASS%s  %s\n' "$GREEN" "$OFF" "${names[$i]}" ;;
    fail) printf '  %sFAIL%s  %s\n' "$RED" "$OFF" "${names[$i]}"; failed=1 ;;
    skip) printf '  %sSKIP%s  %s\n' "$YELLOW" "$OFF" "${names[$i]}" ;;
  esac
done

if [ "$failed" -ne 0 ]; then
  printf '\n%sVerification failed.%s\n' "$RED" "$OFF"
  exit 1
fi
printf '\n%sAll checks passed.%s\n' "$GREEN" "$OFF"
