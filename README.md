# Security+ Learning Platform

A free study platform for the **CompTIA Security+ (SY0-701)** exam: lessons, domain quizzes,
a full 90-question mock exam, a custom quiz builder, Question of the Day, and a progress
dashboard.

> **Status:** the front end is complete and usable. The back end is being built now — see
> [Roadmap](#roadmap). The app works with the API switched off, so nothing here depends on a
> server being up.

---

## Why it works the way it does

**Everything is free without an account.** All 444 questions, every quiz mode, and the whole
progress dashboard work anonymously, saving to browser storage. An account adds durability
and comparison, not access:

| | Anonymous | Account |
|---|---|---|
| Lessons, quizzes, mock exam, custom builder, Question of the Day | ✅ | ✅ |
| Progress dashboard | ✅ browser storage, last 50 attempts | ✅ durable, unlimited |
| Sync across devices · streak that survives a cache clear | — | ✅ |
| Saved custom quizzes · synced flagged questions | — | ✅ |
| Resume a mock exam you got interrupted in | — | ✅ |

Signing up **merges** your existing anonymous history rather than discarding it.

**There is no leaderboard and no comparison between users.** An account keeps your own study
data safe and in sync — it never shows you how you rank against anyone, and your results are
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

**Deployment (planned)** — S3 + CloudFront for the front end; Docker → ECR → App Runner for
the API; RDS Postgres; DynamoDB on-demand; secrets in SSM Parameter Store; Terraform;
GitHub Actions.

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
