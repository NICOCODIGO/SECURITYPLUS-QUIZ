# Security+ Learning Platform

A free study platform for the **CompTIA Security+ (SY0-701)** exam: lessons, domain quizzes,
a full 90-question mock exam, a custom quiz builder, Question of the Day, and a progress
dashboard.

**Live: https://d1cl3du8tc9284.cloudfront.net**

> **Status:** deployed and working. React front end on S3 + CloudFront, Spring Boot API on App
> Runner, PostgreSQL on RDS, accounts with rotating refresh tokens, and quiz history that
> follows your account between devices. Resumable mock exams are the next piece — see
> [Roadmap](#roadmap). The app also runs with the API switched off, straight from a clean
> checkout.

---

## Why it works the way it does

**Studying is free and needs no account.** All 444 questions, every quiz mode, the mock exam
and Question of the Day work signed out, and always will.

**Recording your progress does need one.** Results are kept only while you are signed in. A
quiz taken signed out is graded and reviewed in full — you see your score and every
explanation — it just isn't saved, so there is no history to chart.

| | Signed out | Account |
|---|---|---|
| Lessons, quizzes, mock exam, custom builder, Question of the Day | ✅ | ✅ |
| Answers graded, score and explanations shown | ✅ | ✅ |
| Results kept after you close the page | — | ✅ |
| Progress dashboard, streak, weakest-subject drill | — | ✅ |
| Sync across devices | — | ✅ |
| Resume an interrupted mock exam | — | planned |

With no API configured (`VITE_API_URL` unset) there is no account to have, so nothing is
recorded at all — the app still runs every quiz from its bundled question bank. The reasoning
is in [docs/decisions.md](docs/decisions.md).

**There is no leaderboard and no comparison between users.** An account keeps your own study
data safe — it never shows you how you rank against anyone, and your results are
never visible to another user.

**Mock exams run as a server-held session.** Not to police anything, but because a mock is 90
questions and about 90 minutes: closing the tab shouldn't lose all of it. The server keeps
the session so an interrupted exam can be picked back up, and scores it there because that's
where the session already is. Practice quizzes are graded in the browser so feedback lands
the instant you answer.

---

## Repository layout

```
secapp/     React front end (Vite)
server/     Spring Boot API
infra/      Terraform for the AWS deployment      (not yet)
```

## Setting up a new machine

**Prerequisites.** Only Node is needed to run the front end; the rest is for the API.

| Tool | Version | Needed for |
|---|---|---|
| Node | 22+ | the front end, and every script in `scripts/` |
| JDK | 25 | the API. The Gradle *wrapper* is included, but the JDK is not |
| Docker Desktop | any current | Postgres, DynamoDB Local, and the back-end tests |
| Git | any current | on Windows, this also supplies Git Bash for `verify.sh` |

```bash
git clone https://github.com/NICOCODIGO/SECURITYPLUS-QUIZ.git
cd SECURITYPLUS-QUIZ
cd secapp && npm install && cd ..

./verify.sh --web      # front end only — should pass with no Docker
./verify.sh            # everything, once Docker is running
```

`./verify.sh` is the fastest way to confirm a machine is set up correctly: it
prints PASS/FAIL/SKIP per check, and reports back-end tests as **SKIPPED** rather
than passed when Docker isn't running.

### On Windows

- Run `./verify.sh` from **Git Bash**, not PowerShell — it's a bash script.
- Use `gradlew.bat` instead of `./gradlew` outside Git Bash.
- Everything in `scripts/` and the Claude Code edit hook are Node, so they work
  in any shell.

### Picking up where the last session left off

`CLAUDE.md` is the index; the roadmap and current phase live in
[`docs/architecture.md`](docs/architecture.md). Start there rather than reading
the whole `docs/` folder.

## Running it

**Front end only** — no Docker, no database, everything from the bundled question bank:

```bash
cd secapp
npm install
npm run dev          # http://localhost:5173
```

**API** — starts Postgres and DynamoDB Local automatically via `server/compose.yaml`
(needs a running Docker daemon):

```bash
cd server
./gradlew bootRun    # http://localhost:8080
./gradlew test       # unit + Testcontainers integration tests
```

**Everything in containers:**

```bash
docker compose up    # from the repo root
```

Point the front end at the API by setting `VITE_API_URL=http://localhost:8080`. Leave it
unset and the app falls back to browser storage and its bundled questions.

### Verifying a change

```bash
./verify.sh          # lint, question-bank coverage, web build, API build + tests
./verify.sh --web    # front end only — no Docker required
```

One command, both projects, a PASS/FAIL/SKIP summary at the end. Back-end tests report as
SKIPPED rather than passed when Docker isn't running, since Testcontainers needs a daemon.

```bash
cd secapp
npm run build        # production build to dist/
npm run lint         # eslint — always non-zero, 6 known pre-existing problems
npm run lint:check   # the useful one: fails only on problems that are new
npm run objectives   # question-bank coverage per SY0-701 objective; fails on a bad tag
```

---

## Tech stack

**Front end** — React 19, Vite 7, React Router 7, Tailwind CSS 3, shadcn/ui, lucide-react,
react-markdown. Plain JSX, not TypeScript.

**Back end** — Java 25, Spring Boot 4.1, Spring Security, Spring Data JPA, Flyway,
PostgreSQL, DynamoDB, Gradle. Tested with JUnit 5 and Testcontainers.

**Deployment** {D} live on AWS, defined in [`infra/`](infra/) with Terraform and shipped by
`./scripts/deploy.sh`. React build on S3, API as a container in ECR running on App Runner,
PostgreSQL on RDS in a private subnet, secrets in SSM Parameter Store, CI on GitHub Actions.

The one design choice worth calling out: **the site and the API share a single CloudFront
distribution**, with `/api/*` routed to App Runner and everything else to S3. That is not for
tidiness. The refresh token is a `SameSite=Strict` cookie, so an API on its own domain would
never receive it and every session would die fifteen minutes after sign-in {D} a failure local
development cannot reproduce, because `localhost:5173` and `localhost:8080` count as the same
site.

There is no NAT gateway (the API makes no outbound calls) and no DynamoDB yet (nothing uses it
until resumable mock exams land).

### Why Postgres *and* DynamoDB

Users, questions, attempts and per-question answers are deeply relational and the whole
progress dashboard is aggregates over them — that is Postgres's job. The one thing that
isn't relational is an **in-progress exam session**: written on every answer, read only by
its own id, never joined to anything, and worthless once the exam is finished or given up
on. DynamoDB stores it as a single item and a TTL attribute expires the abandoned ones for
free, with no cleanup job to write or run.

---

## Roadmap

- [x] Front end: lessons, quizzes, mock exam, custom builder, progress dashboard
- [x] Wrong-answer explanations for all 1,332 incorrect choices
- [x] Back end groundwork — schema, migrations, containers, CI
- [ ] Question bank served from the database
- [ ] Accounts (email + password, bcrypt, rotating refresh tokens)
- [ ] Cross-device sync and merge-on-signup
- [ ] Resumable mock exams, drawn weighted to the real exam blueprint
- [ ] AWS deployment
- [ ] Question authoring UI, then performance-based questions (drag-and-drop, hotspot)

### Known gaps

- The lesson-reading flow is orphaned — the six lessons in `lessonsData.js` have full
  content but no route reads them. See `CLAUDE.md`.
- 147 of the 444 questions sit in a domain array that doesn't match their objective, so
  per-domain stats currently describe the filing rather than the content. `npm run
  objectives` lists them; the database import fixes it.
- Mock exams currently draw a flat random 90 with no per-domain weighting.
- Six objectives are too thin to practise against — 4.9 has 1 question, 4.2 has 2, and
  1.3, 2.1, 2.5 and 5.3 have 3 each.
