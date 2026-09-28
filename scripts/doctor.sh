#!/usr/bin/env bash
#
# Is this machine ready to work on the project? Run it after switching
# machines, from the repo root:  ./scripts/doctor.sh
#
# This project is worked on from more than one computer. Git carries the code,
# but not the installed tools, a running Docker, or node_modules, and each of
# those fails later as something that looks like a code bug — "cannot find
# module", a Testcontainers stack trace. This finds them up front.
#
# It fixes the one thing it safely can: front-end packages that are missing or
# out of date after a pull. Everything else it reports with the fix.
#
# Works under Git Bash on Windows as well as macOS and Linux.

set -uo pipefail
cd "$(dirname "$0")/.."

RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; BOLD=$'\033[1m'; OFF=$'\033[0m'

failed=0
pass() { printf '  %sPASS%s  %s\n' "$GREEN" "$OFF" "$1"; }
warn() { printf '  %sWARN%s  %s\n' "$YELLOW" "$OFF" "$1"; [ -n "${2:-}" ] && printf '        → %s\n' "$2"; }
fail() { printf '  %sFAIL%s  %s\n' "$RED" "$OFF" "$1"; [ -n "${2:-}" ] && printf '        → %s\n' "$2"; failed=1; }
info() { printf '  INFO  %s\n' "$1"; }
section() { printf '\n%s%s%s\n' "$BOLD" "$1" "$OFF"; }

# ----------------------------------------------------------------------- git --

section "Code"

# Forgetting to pull is the most common way a switch goes wrong: you carry on
# from where this machine last was, not from where you actually left off.
if git fetch -q origin 2>/dev/null; then
  read -r ahead behind < <(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null || echo "0 0")
  if [ "$behind" -gt 0 ]; then
    fail "$behind commit(s) on GitHub that this machine doesn't have" \
         "pull first: VS Code's Sync Changes button, or 'git pull'"
  else
    pass "up to date with GitHub"
  fi
  [ "$ahead" -gt 0 ] && warn "$ahead commit(s) here not pushed yet" \
                             "push before switching machines, or the other one won't see them"
else
  warn "couldn't reach GitHub, so pull/push status is unknown"
fi

if [ -n "$(git status --porcelain)" ]; then
  info "uncommitted changes here: commit and push them before switching machines"
fi

# --------------------------------------------------------------------- tools --

section "Tools"

if command -v node >/dev/null; then
  node_major=$(node -p 'process.versions.node.split(".")[0]')
  if [ "$node_major" -ge 22 ]; then
    pass "Node $(node -v)"
  else
    fail "Node $(node -v) is too old" "install Node 22 or newer (CI uses 22)"
  fi
else
  fail "Node not installed" "install Node 22 or newer from nodejs.org"
fi

# The Gradle toolchain asks for exactly 25 and has no auto-download plugin, so
# a JDK 25 has to be installed. A different `java` on PATH is only a warning:
# Gradle also finds JDKs installed in the usual places.
if command -v java >/dev/null; then
  java_major=$(java -version 2>&1 | head -1 | sed -E 's/.*version "([0-9]+).*/\1/')
  if [ "$java_major" = "25" ]; then
    pass "Java 25"
  else
    warn "java on PATH is version $java_major, the API needs 25" \
         "install a JDK 25 (e.g. Temurin) if './gradlew bootRun' can't find one"
  fi
else
  fail "Java not installed" "install a JDK 25, e.g. Temurin from adoptium.net"
fi

# Docker runs Postgres and DynamoDB for the API, and the API's tests.
if ! command -v docker >/dev/null; then
  fail "Docker not installed" "install Docker Desktop"
elif docker info >/dev/null 2>&1; then
  pass "Docker running"
else
  fail "Docker installed but not running" "open Docker Desktop and wait for it to finish starting"
fi

# ---------------------------------------------------------------- packages --

section "Front-end packages"

# After a pull that changed package-lock.json, node_modules is stale and the
# dev server dies on an import. npm ls is npm's own check that what's installed
# matches the lockfile. node_modules is never copied between machines: some
# packages ship per-OS binaries.
if ! command -v node >/dev/null; then
  info "skipped: needs Node"
elif npm ls --prefix secapp >/dev/null 2>&1; then
  pass "secapp/node_modules matches package-lock.json"
else
  printf '        installing (packages missing or out of date)...\n'
  if npm install --prefix secapp --no-audit --no-fund >/dev/null 2>&1 \
     && npm ls --prefix secapp >/dev/null 2>&1; then
    pass "secapp packages installed"
  else
    fail "npm install failed" "run 'npm install' in secapp/ to see the error"
  fi
fi

# The local API address. git ignores it (secapp/.gitignore: *.local), so a fresh
# clone has none and the dev server quietly runs with no API: the bundled
# question bank, no sign-in, nothing recorded - which looks like a broken
# account feature, not a missing file. Created with the same value the other
# machines use; delete it to work API-off on purpose.
if [ -f secapp/.env.local ]; then
  pass "secapp/.env.local present ($(grep -m1 '^VITE_API_URL=' secapp/.env.local || echo 'no VITE_API_URL'))"
else
  printf 'VITE_API_URL=http://localhost:8080\n' > secapp/.env.local
  pass "created secapp/.env.local (VITE_API_URL=http://localhost:8080, for './gradlew bootRun')"
fi

# ------------------------------------------------------------------ deploy --

section "Deploying (not needed for development)"

# Informational only. AWS credentials are needed on the day you deploy, and
# never for building or testing the app locally.
if ! command -v aws >/dev/null; then
  info "AWS CLI not installed. Only needed to run scripts/deploy.sh"
elif aws sts get-caller-identity >/dev/null 2>&1; then
  info "AWS credentials configured"
else
  info "AWS credentials not set up. Run 'aws configure' on the day you first deploy"
fi

# ------------------------------------------------------------------ result --

if [ "$failed" -ne 0 ]; then
  printf '\n%sNot ready yet: fix the FAIL lines above.%s\n' "$RED" "$OFF"
  exit 1
fi
printf '\n%sReady to work.%s\n' "$GREEN" "$OFF"
