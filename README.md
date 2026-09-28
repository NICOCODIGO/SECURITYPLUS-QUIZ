# Certucation — a free CompTIA Security+ study platform

A free study platform for the **CompTIA Security+ (SY0-701)** exam: domain quizzes, a full
90-question mock exam, a custom quiz builder, Question of the Day, and a progress dashboard —
444 questions, every wrong answer explained.

**Live: https://certucation.click**

> **Status:** live and working. React front end on AWS Amplify, Spring Boot API on AWS App
> Runner, PostgreSQL on RDS. Accounts with email verification, password reset and optional
> two-factor sign-in; quiz history that follows your account between devices. Resumable mock
> exams are next — see the [roadmap](#roadmap).

**New here, or back after a break?** Start with the plain-English guides in
[docs/guide/](docs/guide/README.md).

---

## Why it works the way it does

**Studying is free and needs no account.** All 444 questions, the domain quizzes and the mock
exam work signed out, and always will.

**Recording your progress does need one.** Results are kept only while you are signed in. A
quiz taken signed out is graded and reviewed in full — you see your score and every
explanation — it just isn't saved, so there is no history to chart. The modes built on that
history — Weakest Subject, Build Your Own and Question of the Day — need an account too.

| | Signed out | Account |
|---|---|---|
| Domain quizzes, mock exam | ✅ | ✅ |
| Answers graded, score and explanations shown | ✅ | ✅ |
| Results kept after you close the page | — | ✅ |
| Progress dashboard | — | ✅ |
| Weakest Subject, Build Your Own, Question of the Day and its streak | — | ✅ |
| Sync across devices | — | ✅ |
| Resume an interrupted mock exam | — | planned |

With no API configured (`VITE_API_URL` unset) there is no account to have, so nothing is
recorded at all — the app still runs the domain quizzes and the mock exam from its built-in
question bank. The reasoning is in [docs/decisions.md](docs/decisions.md).

**There is no leaderboard and no comparison between users.** An account keeps your own study
data safe — it never shows you how you rank against anyone, and your results are never visible
to another user.

**Mock exams will run as a server-held session** (planned). Not to police anything, but because
a mock is 90 questions and about 90 minutes: closing the tab shouldn't lose all of it. Practice
quizzes are graded in the browser so feedback lands the instant you answer.

---

## How it's built

```
browser ── certucation.click ── AWS Amplify ──┬── the website (React)
                                              └── /api/*  →  App Runner (Spring Boot API)
                                                               ├── RDS PostgreSQL
                                                               └── SES (email)
```

The website and the API share **one domain** — Amplify serves the pages and passes `/api/*`
through to the API. That is not for tidiness: the sign-in cookie is `SameSite=Strict`, so an
API on its own domain would never receive it and every session would end fifteen minutes after
sign-in. The whole AWS setup is written as code (Terraform, in [`infra/`](infra/README.md)).

The full walk-through, in plain English: [The big picture](docs/guide/big-picture.md).

### Security

- **Passwords** are stored only as BCrypt hashes. Sign-in uses a 15-minute token plus a rotating
  30-day refresh token in an `httpOnly`, `SameSite=Strict` cookie; reusing an old refresh token
  signs that account out everywhere.
- **Optional two-factor sign-in** by email code or authenticator app, with one-time recovery
  codes. Every authenticator code works once.
- **Email verification** gates password reset, and a reset ends every other session.
- **Rate limits** per account and globally, not just per IP — so guessing passwords or flooding
  someone's inbox doesn't work even from many addresses.
- **Every page** sends a Content Security Policy and anti-framing headers; **the database** sits
  in a private network only the API can reach.

Details: [docs/backend.md](docs/backend.md).

---

## Getting started

**You need:** Git, **Node 22+**, **JDK 25**, and **Docker Desktop** (running). Only Node is
needed for the website alone.

```bash
git clone https://github.com/NICOCODIGO/SECURITYPLUS-QUIZ.git
cd SECURITYPLUS-QUIZ
./scripts/doctor.sh      # checks your tools, installs packages, creates secapp/.env.local
```

**Run it** — two terminals:

```bash
cd server && ./gradlew bootRun    # the API on :8080, with its database in Docker
cd secapp && npm run dev          # the website on http://localhost:5173
```

The first `bootRun` takes a few minutes while Docker downloads the database. It stays at
`80% EXECUTING` while it runs — that's normal. Locally, emails are printed in the API's terminal
instead of sent.

**Check your work:**

```bash
./verify.sh          # everything: docs, question bank, lint, website build, API tests
./verify.sh --web    # the website only — no Docker needed
```

It prints PASS / FAIL / SKIP per check; API tests show SKIPPED, not passed, without Docker.

**On Windows:** run the scripts from **Git Bash**, not PowerShell. **On a Mac:** Terminal works
as-is. More in [Everyday tasks](docs/guide/everyday-tasks.md).

## Shipping

- **The website:** push to `main`. Amplify builds and publishes it in about three minutes — after
  running the lint and question-bank checks, so a failing build never replaces the live site.
- **The API and the AWS setup:** `./scripts/deploy.sh` (needs `aws configure` and Docker).
- **A change that needs both:** run `deploy.sh` first, then push.

## Repository layout

```
secapp/     the website (React, Vite, Tailwind)
server/     the API (Java 25, Spring Boot, PostgreSQL)
infra/      the AWS setup (Terraform)
scripts/    doctor.sh, deploy.sh, and doc/content checks
docs/       technical docs — and docs/guide/, the plain-English guides
verify.sh   every check, one command
```

Every file and folder, one line each: [docs/guide/files.md](docs/guide/files.md).

## Documentation

| | |
|---|---|
| [docs/guide/](docs/guide/README.md) | **Start here.** Plain-English guides: the big picture, where the data lives, every file explained, everyday tasks, a glossary. |
| [docs/decisions.md](docs/decisions.md) | What was built, and what was deliberately removed — read before adding "missing" features. |
| [docs/architecture.md](docs/architecture.md) | The roadmap and phases. |
| [docs/devops.md](docs/devops.md), [infra/README.md](infra/README.md) | Docker, CI, deploying, the domain and email. |
| [docs/backend.md](docs/backend.md), [docs/database.md](docs/database.md) | The API, sign-in, the schema. |
| [docs/frontend.md](docs/frontend.md), [docs/components.md](docs/components.md) | Pages, storage, styling. |
| [docs/content.md](docs/content.md) | The question bank. |

---

## Tech stack

**Front end** — React 19, Vite 7, React Router 7, Tailwind CSS 3, shadcn/ui, lucide-react,
react-markdown. Plain JSX, not TypeScript.

**Back end** — Java 25, Spring Boot 4.1, Spring Security, Spring Data JPA, Flyway, PostgreSQL,
Gradle. Tested with JUnit 5 and Testcontainers.

**Deployment** — AWS: Amplify (website), App Runner and ECR (API), RDS (PostgreSQL), SES
(email), Route 53 and ACM (domain and HTTPS), SSM Parameter Store (secrets). Defined with
Terraform; CI on GitHub Actions.

### Why Postgres *and* DynamoDB

Users, questions, attempts and per-question answers are deeply relational and the whole
progress dashboard is aggregates over them — that is Postgres's job. The one thing that
isn't relational is an **in-progress exam session**: written on every answer, read only by
its own id, never joined to anything, and worthless once the exam is finished or given up
on. DynamoDB stores it as a single item and a TTL attribute expires the abandoned ones for
free, with no cleanup job to write or run. DynamoDB is not in use yet — it arrives with
resumable mock exams.

---

## Roadmap

- [x] Front end: quizzes, mock exam, custom builder, progress dashboard
- [x] Wrong-answer explanations for all 1,332 incorrect choices
- [x] Back end groundwork — schema, migrations, containers, CI
- [x] Question bank served from the database
- [x] Accounts — email + password, rotating refresh tokens, email verification, password reset,
      optional two-factor sign-in
- [x] Study history synced to your account, across devices
- [x] AWS deployment — live at certucation.click, website shipping on every push to `main`
- [x] Security review and hardening
- [ ] Resumable mock exams, drawn weighted to the real exam blueprint
- [ ] Question authoring UI, then performance-based questions (drag-and-drop, hotspot)

### Known gaps

- The lesson-reading flow is orphaned — the six lessons in
  `secapp/src/components/data/lessonsData.js` have full content but no route reads them.
- 147 of the 444 questions are filed under a different domain than their objective, so
  per-domain stats describe the filing rather than the content. `npm run objectives` lists them.
- Mock exams draw a flat random 90, with no per-domain weighting yet.
- Six objectives are too thin to practise against (fewer than 5 questions each): 1.3, 2.1, 2.5,
  4.2, 4.9 and 5.3.
- Email only reaches the account owner's verified address until AWS grants SES production
  access.
- Authenticator-app secrets are stored in plain text in the (private, encrypted) database; they
  should be encrypted with a key held outside it.
