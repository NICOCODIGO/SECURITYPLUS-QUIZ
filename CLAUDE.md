# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Front-end study platform for the CompTIA Security+ SY0-701 exam (lessons, domain quizzes, mock exam, progress dashboard). React 19 + Vite 7 + Tailwind 3 + shadcn/ui, plain JSX — **not** TypeScript, despite what the root `README.md` claims.

There is no backend. All state is browser storage. `src/api/apiClient.js` is a three-line comment file; note that the root `README.md` plans an AWS stack (Lambda/API Gateway/RDS/Cognito) while that comment says Spring Boot — the direction was never reconciled, so confirm intent before building against either.

## Commands

The app lives in `secapp/`, not the repo root. All npm commands must run from there.

```bash
cd secapp
npm install
npm run dev      # Vite dev server (default port 5173)
npm run build    # production build to dist/
npm run preview  # serve the built dist/
npm run lint     # eslint
```

Docker (`docker-compose up` from `secapp/`) runs the **dev server**, not a production build.

There is no test framework configured — no test runner, no test files, no `test` script. Verification here means `npm run lint` and `npm run build`, plus loading pages against `npm run dev`.

`npm run lint` currently exits non-zero with ~8 pre-existing problems (unused vars in the quiz components, a `setState`-in-effect in `LessonDetail`, `__dirname` in `vite.config.js`, two shadcn fast-refresh complaints). Treat that count as the baseline; make sure your changes don't add to it rather than expecting a clean run.

## Architecture

### Domain data is centralized; most other data is not

`src/components/data/securityDomains.js` is the single source of truth for the five exam domains — id, number, weight, title, topics, icon, and Tailwind color tokens. `numberedTitle` and `questionCount` are **derived** (`questionCount` counts the real entries in `quizData`), so never hardcode either. Home, AboutCertification, Lessons, and the quiz Dashboard all read from it. This module was extracted to kill five drifting copies; put new domain metadata here rather than inline in a page.

### Quiz flow crosses a full page reload

Quiz setup and quiz taking are separate pages joined by a **hard navigation**, not react-router:

1. A setup component (`DomainQuiz`, `MockExamSetup`, `MockExam`, `WeakestSubjectQuiz`) filters the question list.
2. It writes the selected questions to `sessionStorage` under a generated `quiz_<timestamp>` key — done to dodge URL length limits.
3. It sets `window.location.href` to `TakeQuiz?...` with that `quizId` plus display params in the query string.
4. `TakeQuiz` reads `window.location.search` directly and pulls the questions back out of `sessionStorage`.

Because of this, `TakeQuiz` and `Lessons` read `window.location.search` rather than `useSearchParams`, and `useNavigate` is imported but unused in some setup components. If you convert any leg of this to client-side routing, convert the whole chain or the handoff breaks.

`createPageUrl()` in `src/lib/utils.js` returns a **relative** path (`"TakeQuiz"`, not `"/TakeQuiz"`). That works for `window.location.href` assignment from a top-level route, but inside a `<Link to=...>` React Router resolves it against the *current* route — from `/lesson/:id` it produces `/lesson/Lessons`, which matches nothing. Prefer explicit absolute paths in `<Link>`.

`App.jsx` deliberately registers both `/quiz` and `/TakeQuiz` for the same page because `createPageUrl('TakeQuiz')` generates the capitalized form. Route matching is case-insensitive (React Router default), so `/Lessons` still hits `path="/lessons"`.

### Browser storage is three disconnected islands

Know which key you are touching:

- **`security_plus_progress`** — lesson completion records. The only key with an accessor module (`src/components/data/progressData.js`). Drives the Progress dashboard stat cards and the Home hero counter.
- **`quiz_history`** — written by `TakeQuiz` when a quiz finishes; read by `WeakestSubjectQuiz` to pick weak-area questions.
- **`quizScores`** — read by `Progress.jsx` for the Strongest/Weakest Domain cards, **and written by nothing**. Those two cards therefore never render. Wiring them means either having `TakeQuiz` also write this key or repointing Progress at `quiz_history`.

Quiz results never flow into `security_plus_progress`, so quiz performance and lesson progress are tracked entirely separately.

### The lesson-reading flow is disconnected

`/lessons` renders the **Quiz Center** (sidebar + domain quizzes + mock exam), not a list of lessons. The actual reading path is orphaned:

- `LessonCard.jsx` is imported by nothing, links to `/lessons/:id` (the route is `/lesson/:id`, singular), and reads `lesson.domain` / `lesson.estimatedMinutes`, which don't exist in `lessonsData` (the fields are `category` and `duration`).
- `LessonDetail` is routed as `/lesson/:id` but reads its id from `?id=` via `URLSearchParams` instead of `useParams`, so it always renders "Lesson not found". Nothing links to it anyway.
- Consequently `markLessonComplete()` — called only from `LessonDetail` — is unreachable, so `security_plus_progress` is never written and the Progress dashboard shows zeros in normal use.

The six entries in `lessonsData.js` (each with full markdown `content`) are currently used only for their `length` as a denominator. Restoring this flow is a known gap, not an accident to work around.

### Question bank

`quizData.js` exports `quizQuestions` keyed `domain1`–`domain5`, plus `getAllQuestions()`. 466 questions total, but coverage is skewed against the real exam weights — Domain 4 (Security Operations) has 38 questions despite being 28% of the exam, while Domains 1–3 have 112–114 each.

### Styling

Tailwind 3 + shadcn/ui with the `@/` alias (configured in both `vite.config.js` and `jsconfig.json` — update both if it changes).

The brand red is applied by an inline `<style>` block in `Layout.jsx` that overrides Tailwind's `red-600`/`red-700`/`red-50` utilities with `!important` to hit `#C8102E`. So `bg-red-600` in any component renders the brand red, not Tailwind's default. Changing the brand color means editing that block, not the Tailwind config.

Pages are built as full-bleed sections inside a `-mt-8` wrapper that escapes the `Layout` main padding; `Layout` also hides its nav and footer on the quiz page via `currentPageName === "TakeQuiz"`.

Asset imports are case-sensitive in the Alpine-based Docker build but not on the Windows dev machine — match the on-disk filename exactly.
