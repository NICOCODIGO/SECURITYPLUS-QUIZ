# Front end

React 19 + Vite 7 + React Router 7, plain JSX. Lives in `secapp/`. Styling rules are in
[components.md](components.md); the question bank is in [content.md](content.md).

## Routes

Registered in `secapp/src/App.jsx`:

| Path | Page | Notes |
|---|---|---|
| `/` | `Home.jsx` | |
| `/about` | `AboutCertification.jsx` | |
| `/lessons` | `Lessons.jsx` | **This is the Practice page** — see below |
| `/lesson/:id` | `LessonDetail.jsx` | Orphaned, see below |
| `/progress` | `Progress.jsx` | |
| `/resources` | `AdminContentManager.jsx` | **Misnamed** — it is a Study Resources page, not an admin panel |
| `/daily` | `DailyQuestion.jsx` | Full-screen |
| `/quiz` and `/TakeQuiz` | `TakeQuiz.jsx` | Full-screen; both paths on purpose |

`/quiz` and `/TakeQuiz` both exist because `createPageUrl('TakeQuiz')` generates the
capitalized form. Route matching is case-insensitive (React Router default), so `/Lessons`
still hits `path="/lessons"`.

### `createPageUrl` returns a *relative* path

`createPageUrl()` in `secapp/src/lib/utils.js` returns `"TakeQuiz"`, not `"/TakeQuiz"`. That
works for `window.location.href` assignment from a top-level route, but inside a
`<Link to=...>` React Router resolves it against the **current** route — from `/lesson/:id`
it produces `/lesson/Lessons`, which matches nothing. **Prefer explicit absolute paths in
`<Link>`.**

## The quiz flow crosses a full page reload

Quiz setup and quiz taking are separate pages joined by a **hard navigation**, not
react-router:

1. A setup component (`DomainQuiz`, `MockExam`, `WeakestSubjectQuiz`, `CustomQuizBuilder`)
   picks the questions.
2. It writes them to `sessionStorage` under a generated `quiz_<timestamp>` key — done to
   dodge URL length limits.
3. It sets `window.location.href` to `TakeQuiz?...` with that `quizId`, a `type`
   (`domain` | `mock` | `weakest` | `custom`), display params, and a `returnTo` section.
4. `TakeQuiz` reads `window.location.search` directly and pulls the questions back out of
   `sessionStorage`.
5. On exit, `TakeQuiz` hard-navigates back to `Lessons?section=<returnTo>`.

Because of this, `TakeQuiz` and `Lessons` read `window.location.search` rather than
`useSearchParams`. **If you convert any leg of this to client-side routing, convert the
whole chain or the handoff breaks.**

Phase 4 adds a `sessionId` to this handoff for server-held mock exams. That is the only
planned change to the chain — don't take the opportunity to rewrite it as client-side
routing at the same time.

`/daily` is the one other full-screen page and is plain react-router, no `sessionStorage`
handoff, because the card reads the day's question itself and writes only to
`daily_question`.

`TakeQuiz` is built to fit one laptop screen without scrolling: a single top bar (exit,
title, timer, flag), Previous/Next inside the question card's footer, and — from `lg` — the
navigator in a sidebar beside the question rather than stacked under it. `Layout` drops the
page padding on this route. Keep that constraint in mind when adding anything to the screen.

`MockExamSetup` (difficulty / count / timer options) is imported by nothing — the Practice
page uses the simpler `MockExam`.

## `/lessons` is the Practice page

The route stays `/lessons` so existing links keep working, but the nav item and the page
both say "Practice". `QuizSidebar` switches sections: `dashboard`, `custom`, `mock`,
`weakest`, or a domain id. Question of the Day is **not** a section — it has its own
full-screen route — and `?section=daily`, from when it was one, falls back to `dashboard`.

`?section=` is the initial state, and `changeSection` mirrors the current section back into
the URL with a search-only `navigate(..., { replace: true })`. That keeps the page mounted
(no remount, and `ScrollToTop` stays put since it only watches path and hash) while a reload
or a shared link still lands on the right section.

**A `<Link>` to `/lessons?section=…` from *inside* the page won't switch sections — call
`changeSection` instead.**

The `dashboard` section (`secapp/src/components/quiz/Dashboard.jsx`) is the overview: one recommended next step
chosen from the visitor's state (brand new, weak domain, no mock yet, keeping sharp), then
the domains as a compact list, then the exam and targeted modes. It reads storage once on
mount, which is safe because finishing a quiz always reloads this page. Keep first-open in
mind when editing it — a new visitor should see what each mode involves, not a grid of
zeros.

## Browser storage

**Each key has exactly one accessor module in `secapp/src/components/data/`. Go through it
rather than calling `localStorage` directly.**

| Key | Module | Holds |
|---|---|---|
| `quiz_history` | `quizHistoryData.js` | Every finished attempt. The main one. |
| `daily_question` | `dailyQuestion.js` | Question-of-the-Day answers and streak |
| `flagged_questions` | `questionPools.js` | Questions flagged during a quiz |
| `security_plus_progress` | `progressData.js` | Lesson completion — **never written**, see below |

### `quiz_history` and the selector pattern

`TakeQuiz` appends an attempt on submit. Each record:

```js
{ date, type, score, questionsCount, durationSeconds, domainTitle,
  domainBreakdown: [{ domain, percentage, correct, total }],
  answers: [{ id, ok }] }          // id = hashQuestion(question.question)
```

Progress and the Practice dashboard are both **pure selectors over this array** —
`getQuizStats`, `getModeStats`, `getDomainPerformance`, `getScoreTrend`, `getMostMissed`,
`getRecentAttempts`. Every one takes the history array as an optional argument, which is how
the Progress sample-data switch renders a populated dashboard through the exact same code
path.

**That argument is also the seam the back end plugs into.** Phase 3 returns attempts from
`GET /me/attempts` in exactly this record shape, so the selectors work unchanged and no
analytics logic is duplicated server-side. Don't reimplement these on the server.

Rules that live in these selectors:

- **Averages are weighted by question** (total correct ÷ total answered), never by attempt,
  so a 10-question quiz can't count as much as a 90-question mock.
- `getScoreTrend` returns `{ practice, mock }`, not one series. `ScoreTrendChart` plots
  `practice` only and draws no pass-mark rule — mock scores belong to Progress's
  `ReadinessCard`, because a 10-question quiz on the same line as a 90-question mock made a
  bad quiz look like a failed exam.
- `getDomainPerformance` returns `strongest`/`weakest` as `null` unless at least two
  attempted domains differ in accuracy. For "the lowest domain so far" use `ranked[0]`, as
  `WeakestSubjectQuiz` does.
- Records written before `answers` / `durationSeconds` existed are still in people's
  browsers, so every selector tolerates them being absent.

Score thresholds live in `secapp/src/lib/performanceStatus.js` — `MOCK_PASS_MARK` (83%) and
`statusForAccuracy`. **Don't redefine either locally.**

### Why `daily_question` is separate

A single question scores 0% or 100%, which would swing the weighted averages. It is shown
separately: in the Practice page's daily strip (a link to `/daily`) and in Progress's
`PracticeMixPanel`.

### Sample data

Progress has a "Sample data" switch feeding `secapp/src/lib/demoProgressData.js` through the
same selectors without writing storage — `demoQuizHistory` for history, `demoDailyStats` for
the streak (that data isn't in the history). Home's two previews fall back to
`demoQuizHistory` as well, labelled as sample, and switch to real results once `canDrawTrend`
is satisfied (two practice quizzes or two mocks — the trend chart plots them apart and needs
two points to draw a line). Use the switch to check populated layouts without taking quizzes.

## The question bank: bundled by default, API when available

`secapp/src/api/apiClient.js` is a small fetch wrapper around `VITE_API_URL`. One `ApiError`
type carries the status, and `isOffline` distinguishes "the server said no" from "the server
isn't there".

`secapp/src/components/data/questionBank.js` holds whichever copy of the bank is active.
The bundled one from `quizData.js` is the default **and** the fallback — it is synchronous,
and nine places depend on that, including module-level derivations like
`securityDomains.questionCount`. `App.jsx` calls `hydrate()` once on boot, which walks the
paged API (200 per page, 444 total) and swaps the bank in on success.

Consequences worth knowing:

- Before hydration finishes, callers get the bundled bank. Both hold the same 444 questions
  today, so only a server-side edit made in the last second is at stake.
- `securityDomains.questionCount` is derived at import time and always reflects the bundled
  bank. Use `getBank().total` for a live count.
- The API returns choices as objects with an `is_correct` flag; `toQuizDataShape` translates
  them back to `quizData`'s string array plus index, so that assumption lives in one place.
- Questions are keyed to their **filed** domain label on the way in, so domain quizzes keep
  asking what they ask today. Switching to the objective's domain is a product decision, not
  a side effect of moving to the API.

Phase 3 adds an `AuthContext` and `source.js` for *user data* on the same pattern. The accessor modules above keep their exported signatures and read through
whichever source is active.

**Fallback is a hard requirement.** If `VITE_API_URL` is unset or a request fails, everything
falls back to `LocalSource` and the bundled question bank. `npm run dev` on a clean checkout
must give a fully working app with no Docker, no database and no account.

## The lesson-reading flow is disconnected

There is no route that lists or reads lessons. The path is orphaned, and this is a **known
gap, not an accident to work around**:

- `LessonCard.jsx` is imported by nothing. It links to `/lessons/:id`, but the route is
  `/lesson/:id` (singular). It also reads `lesson.domain` / `lesson.estimatedMinutes`, which
  don't exist in `lessonsData` — the fields are `category` and `duration`.
- `LessonDetail` is routed as `/lesson/:id` but reads its id from `?id=` via
  `URLSearchParams` instead of `useParams`, so it always renders "Lesson not found".
- Consequently `markLessonComplete()` is unreachable and `security_plus_progress` is never
  written, so the Home hero's progress counter never appears.

The six entries in `lessonsData.js` each have full markdown `content` but are currently used
only for their `length` as a denominator.
