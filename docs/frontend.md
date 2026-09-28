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

### Link previews

`secapp/index.html` carries the Open Graph and Twitter tags that give a shared
certucation.click link its title, description and image. The image is
`secapp/public/og-image.jpg`, a copy of the README's `.github/assets/social-preview.jpg` — the
same file is uploaded by hand as the repo's social preview (GitHub → Settings → Social preview),
because GitHub has no API for it. Change all three together. `og:image` must be an absolute URL;
crawlers don't resolve relative ones.

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
`daily_question`. It is account-only: signed out it renders `AccountRequired`, and while
auth is `loading` a placeholder, so neither the question nor the lock flashes.

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

**`weakest`, `custom` and Question of the Day are account-only.**
`secapp/src/components/quiz/accountOnly.js` is the list. `isSectionLocked(mode, status)` is
the check for the two locked modes — the Overview's cards, `QuizSidebar`'s lock icons and
`Lessons`' section switch all ask it. Signed out (or with no API), the card turns into a
greyed `LockedModeCard` and the section renders `AccountRequired` in place of the mode; the
sign-up and sign-in links carry `?next=` back to the mode. `?next=` is only ever followed
through `secapp/src/auth/safeNext.js`, which keeps a value only if it resolves to this origin —
anything else is an open redirect to a phishing page, right after a genuine sign-in. A prefix
check is not enough: browsers read `/\evil.example` as `//evil.example`. The two modes stay
unlocked while auth is `loading`, so a signed-in visitor never sees the lock flash. Question of the Day is
*hidden* instead (`showsDailyQuestion`), so it only appears once signed in — the Progress
page's signed-out card is where it is advertised.

The `dashboard` section (`secapp/src/components/quiz/Dashboard.jsx`) is the overview: one recommended next step
chosen from the visitor's history (weak domain, no mock yet, keeping sharp), then
the domains as a compact list, then the exam and targeted modes. `DailyQuestionCard` is the
page's only entry to Question of the Day: when today's question *is* the recommendation
(signed in, no quizzes yet, not answered today) there is no separate next-step card and it
takes the lead styling instead — don't add it back as a `pickNextStep` branch, that showed it
twice. With no history there is no recommendation at all — signed out, the page opens on the
domain list (the old "Take your first quiz" card is in decisions.md). Its reads are keyed on
`signedIn`, not `[]`: auth resolves after mount, and a read taken before it lands is empty
and never retried. Keep first-open in mind when editing it — a new visitor should see what
each mode involves, not a grid of zeros.

## Browser storage

**Each key has exactly one accessor module in `secapp/src/components/data/`. Go through it
rather than calling `localStorage` directly.**

| Key | Module | Holds |
|---|---|---|
| `quiz_history:<user id>` | `quizHistoryData.js` | Every finished attempt. The main one. |
| `daily_question:<user id>` | `dailyQuestion.js` | Question-of-the-Day answers and streak |
| `flagged_questions:<user id>` | `questionPools.js` | Questions flagged during a quiz |
| `security_plus_progress` | `progressData.js` | Lesson completion — **never written**, see below |

The first three are **namespaced by account**, via `scopedKey()` in `persistence.js`. Two
people share a browser more often than "local storage" suggests — a family laptop, a library
machine — and without the namespace the second person to sign in reads the first one's history
as their own and appends to it. `security_plus_progress` is not namespaced because nothing
writes it.

### Persistence requires an account

`secapp/src/components/data/persistence.js` exports **one** predicate,
`isPersistenceAllowed()`, and the first three accessors above consult it before every read and
every write. It is true only while an account is signed in.

Signed out, a quiz is taken, scored and reviewed exactly as normal — the score lives in
`TakeQuiz`'s own state — but nothing is written and nothing previously written is read.
`getQuizHistory()` returns `[]`, so every selector over it returns its empty shape and the
whole dashboard, the streak and the weakest-subject pool are empty by design.

Two things to hold onto:

- **Nothing is ever deleted.** A signed-out browser stops *reading* its old `quiz_history`;
  the key is left alone. The policy is one line and reversing it restores the data.
- **With `VITE_API_URL` unset there is no account**, so nothing persists at all. This narrows
  the fallback rule below: a clean checkout still runs the domain quizzes, the mock exam and
  the whole bank, but keeps no results; Weakest Subject and Build Your Own stay locked and
  Question of the Day hidden. `ProgressGate` says so on the page rather than showing an empty dashboard.
  Recorded in [decisions.md](decisions.md).

### `quiz_history` and the selector pattern

`TakeQuiz` appends an attempt on submit. Each record:

```js
{ id, date, type, score, questionsCount, durationSeconds, domainTitle,
  domainBreakdown: [{ domain, percentage, correct, total }],
  answers: [{ id, ok }] }          // answers[].id = hashQuestion(question.question)
```

The record `id` is a `crypto.randomUUID()` minted by `TakeQuiz`, and it is the **entire**
dedupe strategy for sync: `POST /me/attempts` is `on conflict (id) do nothing`, so re-sending
an attempt after a flaky request stores nothing rather than duplicating the quiz. Records
written before this existed have no `id`; `source.js` assigns one at first sync and persists
it back.

Progress and the Practice dashboard are both **pure selectors over this array** —
`getQuizStats`, `getModeStats`, `getDomainPerformance`, `getScoreTrend`, `getMostMissed`,
`getRecentAttempts`. Every one takes the history array as an optional argument, which is how
Home's `ProgressPreview` renders a populated teaser from a fixture through the exact same
code path as real results.

**That argument is also the seam the back end plugs into.** `GET /me/attempts` returns records
in exactly this shape, so every selector works unchanged and no analytics logic is duplicated
server-side. Don't reimplement these on the server.

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
separately: in the Practice page's `DailyQuestionCard` (a link to `/daily`) and in
Progress's `PracticeMixPanel`.

### Sample data

Home's two previews fall back to `demoQuizHistory` from `secapp/src/lib/demoProgressData.js`,
labelled as sample, and switch to real results once `canDrawTrend` is satisfied (two practice
quizzes or two mocks — the trend chart plots them apart and needs two points to draw a line).
The fixture goes through the same selectors and never writes storage.

**Home is the only place a fixture is shown.** Progress used to have a "Sample data" switch
reading the same file; it was removed — a demo surface inside the product. See
[decisions.md](decisions.md).

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

## Syncing study data: `source.js`

`secapp/src/components/data/source.js` is how an account's history reaches a second device. It
follows the same shape as `questionBank.js`: **pull once, write into the store the accessors
already read, and leave every read synchronous.**

That last part is the constraint everything else bends around. `Progress.jsx` reads the
accessors inside `useMemo` and some derivations run at import time, so turning them async to
fetch per-call would ripple through every caller. Instead `hydrate()` fetches
`/me/attempts`, `/me/flags` and `/me/daily` once and writes them into the namespaced local
keys; nothing downstream changes at all.

Three things about it are deliberate:

- **It merges, it does not overwrite.** The server holds everything recorded from any device,
  but this browser may hold attempts the server has never seen — history written before sync
  existed. Replacing local with remote would delete exactly those, silently. Local-only
  attempts get an id if they lack one, are pushed up, and are kept.
- **It runs before the UI believes it is signed in.** `AuthProvider` awaits it before
  `setStatus('authenticated')`, in both the boot-refresh and the sign-in path, so the first
  signed-in render already has real data. Hydrating afterwards paints an empty dashboard for a
  beat, which reads as data loss.
- **It never blocks sign-in.** A failed pull leaves whatever is local in place and the app
  carries on — the same judgement `questionBank.js` makes when the API is unreachable.

Writes go local first (instant, works offline) and then up. A failed `POST /me/attempts` is
queued under its own namespaced key and flushed on the next hydrate, *before* the fetch, so a
quiz taken offline is never lost. The server dedupes on the attempt's client-minted id, so
re-sending one that did land after all is a no-op rather than a duplicate.

**Fallback is a hard requirement.** If `VITE_API_URL` is unset or a request fails, everything
falls back to browser storage and the bundled question bank. `npm run dev` on a clean checkout
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
