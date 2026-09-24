# CLAUDE.md

Guidance for Claude Code working in this repository.

This file is an **index**, not the documentation. The detail lives in `docs/` and is loaded
on demand — read the one or two files your task needs rather than everything.

## Project

Free study platform for the CompTIA Security+ SY0-701 exam. Front end: React 19 + Vite 7 +
Tailwind 3 + shadcn/ui, plain **JSX, not TypeScript** (`secapp/`). Back end: Java 25 +
Spring Boot 4.1 + PostgreSQL + DynamoDB (`server/`), **partly built — the question bank is
served over a public read-only API; accounts and sync are not.**

## Read this first

| Working on | Read |
|---|---|
| Anything visual or product-shaped | **[docs/decisions.md](docs/decisions.md) first** |
| Orientation, tech stack, roadmap | [docs/architecture.md](docs/architecture.md) |
| Pages, routing, state, browser storage | [docs/frontend.md](docs/frontend.md) |
| Styling, layout, Tailwind, shadcn | [docs/components.md](docs/components.md) |
| Spring Boot, endpoints, auth | [docs/backend.md](docs/backend.md) |
| Schema, migrations, DynamoDB | [docs/database.md](docs/database.md) |
| Docker, CI, env vars, deploys | [docs/devops.md](docs/devops.md) |
| Questions, objectives, rationales | [docs/content.md](docs/content.md) |

`decisions.md` records what was built and deliberately removed. Most of it looks like an
obvious missing feature. It isn't.

## Commands

Two projects, two working directories.

```bash
cd secapp
npm install
npm run dev         # Vite dev server on :5173
npm run build       # production build to dist/
npm run lint:check  # lint vs baseline — use this, not `npm run lint`
npm run objectives  # question-bank coverage; fails on a bad objective tag
```

```bash
cd server
./gradlew bootRun   # API on :8080; starts Postgres + DynamoDB Local automatically
./gradlew test      # JUnit 5 + Testcontainers (needs a running Docker daemon)
```

```bash
./verify.sh         # from the repo root: everything, with a PASS/FAIL/SKIP summary
./verify.sh --web   # front end only, no Docker required
./scripts/doctor.sh # is this machine ready? run after switching machines
```

## Rules that hold everywhere

Short list, kept here because missing one is expensive. Everything else is in `docs/`.

1. **Nothing comparative.** No leaderboard, ranking, percentiles, or cross-user visibility.
2. **Studying is never behind the login; recording it is.** Every quiz, the mock exam and all
   444 questions work signed out and always must. But study data is kept **only while signed
   in** — one predicate, `secapp/src/components/data/persistence.js`. Don't gate a *studying*
   feature, and don't scatter that check.
3. **The app must work with the API off.** `VITE_API_URL` unset falls back to the bundled
   question bank and every quiz still runs. Note it no longer falls back to browser storage
   for results: no API means no account, so nothing is recorded. See
   [docs/decisions.md](docs/decisions.md).
4. **Grids need `grid-cols-1`.** A `grid` with only `lg:grid-cols-*` overflows narrow
   screens.
5. **Lint baseline is 6 problems.** `npm run lint` always exits non-zero; judge with
   `npm run lint:check`.
6. **Flyway owns the schema.** New `V<n>__*.sql`; never edit an applied migration.
7. **Join questions to domains with `getDomainByQuizLabel`**, never by title — the labels in
   `quizData` don't match `securityDomains`.
8. **One accessor module per browser-storage key**, in `secapp/src/components/data/`. Don't
   touch `localStorage` directly.
9. **Editing a question's wording** silently orphans its wrong-answer rationales and retires
   its history. See [docs/content.md](docs/content.md).
10. **Verify, don't assume.** Run `./verify.sh`; for UI work, look at the page with the
    `browser-automation` skill.

## Specialist agents

Three subagents in `.claude/agents/` carry the relevant docs and keep noisy output out of the
main thread: `content-curator` (question bank), `frontend-ui` (UI + visual verification),
`backend-api` (Spring Boot, SQL, Gradle).

## Keeping the docs honest

`docs/` is loaded on demand, so it is only useful if it stays true. When you change
behaviour, update the one doc that owns it — and don't copy its content back into this file.
`node scripts/check-doc-links.mjs` (part of `./verify.sh`) checks that every path referenced
in the docs still exists.
