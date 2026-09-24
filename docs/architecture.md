# Architecture

Start here. This file is the map; the other docs are the territory.

## What this is

A free study platform for the CompTIA Security+ **SY0-701** exam: lessons, domain quizzes,
a 90-question mock exam, a custom quiz builder, Question of the Day, and a progress
dashboard.

**Live at https://d1cl3du8tc9284.cloudfront.net.** The front end is complete, the API serves
the question bank and **has accounts** — register, login, rotating refresh, logout, me — and
the whole stack is deployed on AWS.

Study data is kept only while signed in, and still in that browser's local storage: an account
gates recording, but does not yet carry results between devices. Cross-device sync is phase 3,
and exam sessions phase 4. See [decisions.md](decisions.md).

## Tech stack

| Layer | Choice | Notes |
|---|---|---|
| Front end | React 19, Vite 7, React Router 7, Tailwind 3, shadcn/ui | Plain **JSX, not TypeScript** |
| Back end | Java 25, Spring Boot 4.1, Gradle wrapper | Initializr no longer offers Boot 3.x |
| Relational | PostgreSQL 17 + Flyway | System of record |
| Key-value | DynamoDB | In-progress exam sessions only |
| Auth | Own bcrypt + JWT, rotating refresh | Not Cognito |
| Deploy | S3 + CloudFront, ECR → App Runner, RDS, Terraform | Live; see `infra/` |
| CI | GitHub Actions | `.github/workflows/ci.yml` |

The AWS stack the original README planned — Lambda, API Gateway, Cognito, Amplify, MySQL —
was **abandoned**. So were TypeScript and React Query. See [decisions.md](decisions.md).

## Repo map

```
secapp/     React front end          → frontend.md, components.md, content.md
server/     Spring Boot API          → backend.md, database.md
docs/       these files
infra/      Terraform for AWS        → devops.md, infra/README.md
verify.sh   the one verification command
```

## The product rule everything inherits

**Studying is free without an account.** All 444 questions and every quiz mode work
anonymously. **Progress reporting does not** — results are only kept while signed in.

| | Anonymous | Account |
|---|---|---|
| Lessons, quizzes, mock exam, custom builder, Question of the Day | ✅ | ✅ |
| Answers graded, score and explanations shown | ✅ | ✅ |
| Results kept after the page closes | — | ✅ |
| Progress dashboard · streak · weakest-subject drill | — | ✅ |
| Cross-device sync | — | Phase 3 |
| Resume an interrupted mock exam | — | Phase 4 |

That second row is the deliberate narrowing: you can study as much as you like signed out, but
nothing is recorded, so there is no history to chart. One predicate decides it —
`secapp/src/components/data/persistence.js`. See [decisions.md](decisions.md) for the
reasoning and what it costs.

Three rules that follow from this, and that everything else is built around:

1. **Never put a *studying* feature behind the login.** Every quiz and all 444 questions work
   signed out and always must. Recording the results is the part that needs an account — a
   deliberate narrowing of the original rule, see [decisions.md](decisions.md).
2. **Nothing comparative.** No leaderboard, ranking, percentiles or cross-user visibility —
   rejected deliberately, and it set the shape of the whole back end.
3. **Storage is per account.** Keys are namespaced by user id, so two people sharing a browser
   never see each other's history. Phase 3's `POST /me/import` is a merge the user asks for;
   silently adopting whatever was already in the browser is not.

## Roadmap

Each phase ends with the app fully working, deployed or not.

- **0 — Groundwork.** ✅ Done. `server/` scaffold, compose files, Flyway baseline, CI,
  rewritten READMEs.
- **1 — Question service (read-only).** ✅ Done.
  - ✅ Importer (`scripts/generate-seed.mjs`) → `R__seed_content.sql`: 28 objectives, 444
    questions, 1,776 choices, 1,332 rationales, seeded and verified against real Postgres.
  - ✅ Server-side integrity tests (`ContentSeedTests`) — a bad tag now fails CI.
  - ✅ Public question endpoints — `/questions`, `/objectives`, `/domains`, with CORS,
    deny-by-default security and RFC 7807 errors. 29 tests.
  - ✅ Front end hydrates from the API on boot (`questionBank.js`), falling back to the
    bundled bank when `VITE_API_URL` is unset or the API is unreachable.
  - **Phase 1 complete.**
- **2 — Auth.** ✅ Done, server side. Register/login/refresh/logout/me, BCrypt 12, 15-minute
  access JWT, rotating refresh in an httpOnly `SameSite=Strict` cookie scoped to
  `/api/v1/auth`, reuse detection that revokes the whole token family, in-memory rate
  limiting, and login responses that are byte-identical for a wrong password and an unknown
  email. Register returns 409 on a duplicate — a documented narrowing, see
  [decisions.md](decisions.md). 52 tests. No new migration: `V1__init.sql` already had
  `users` and `refresh_tokens`.
- **3 — Sync + merge-on-signup.** `/me/attempts`, `/me/flags`, `/me/daily`, `/me/presets`,
  the `RemoteSource`, and `POST /me/import` merging by `(legacy_hash, submitted_at)` so a
  double import can't duplicate.
- **4 — Resumable mock exams.** DynamoDB session lifecycle, keyless question delivery,
  blueprint-weighted draw, submit + review payload.
- **5 — ~~Leaderboard~~. Cut.** See [decisions.md](decisions.md).
- **6 — Deploy.** ✅ Done. **Live at https://d1cl3du8tc9284.cloudfront.net.** Terraform in
  `infra/`, shipped by `./scripts/deploy.sh`; S3 + CloudFront, ECR → App Runner, RDS
  `t4g.micro` in a private subnet, secrets in SSM, state in S3. One distribution serves both
  the site and `/api/*` — required, not tidy: the `SameSite=Strict` refresh cookie is never
  sent to a different domain. No NAT gateway (no outbound calls) and no DynamoDB (unused until
  phase 4). Request-id correlation on every log line; JSON logs in `prod`.
- **7 — Content.** Admin authoring behind the `role` column, question drafts/review, then
  performance-based questions (drag-and-drop, hotspot).

## Where to look for what

| Question | File |
|---|---|
| How does routing / state / browser storage work? | [frontend.md](frontend.md) |
| What are the styling and layout rules? | [components.md](components.md) |
| How is the API structured? | [backend.md](backend.md) |
| What does the schema look like? | [database.md](database.md) |
| How do I run / build / deploy this? | [devops.md](devops.md) |
| How do questions and rationales work? | [content.md](content.md) |
| Why was something removed? Can I add X back? | [decisions.md](decisions.md) |
