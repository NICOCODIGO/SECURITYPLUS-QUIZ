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

`npm run lint` currently exits non-zero with 6 pre-existing problems (5 errors, 1 warning): an unused var and an exhaustive-deps warning in `TakeQuiz.jsx`, a `setState`-in-effect in `LessonDetail`, `__dirname` in `vite.config.js`, and two shadcn fast-refresh complaints (`ui/badge.jsx`, `ui/button.jsx`). Treat that count as the baseline; make sure your changes don't add to it rather than expecting a clean run.

## Architecture

### Domain data is centralized; most other data is not

`src/components/data/securityDomains.js` is the single source of truth for the five exam domains — id, number, weight, title, topics, icon, `chartColor`, and Tailwind color tokens. `numberedTitle` and `questionCount` are **derived** (`questionCount` counts the real entries in `quizData`), so never hardcode either. Home, About, the Quiz Center, and Progress all read from it. This module was extracted to kill five drifting copies; put new domain metadata here rather than inline in a page.

The official objectives outline lives separately in `src/components/data/examObjectives.js` (all five domains, nested up to four levels).

### Bands come in two tones

Full-width sections use `.band-dark` (`src/index.css`) or plain white. Home previously mixed three different darks and a cream band on top of that, which read as a patchwork. Red stays an accent (buttons, rules, small labels), with one exception: Home and About both close on a floating red card (a rounded island on the canvas, not a full-width band) as the last thing above the footer. Home's used to be a full-bleed red band and was changed to match About's.

White bands that sit next to each other carry a `border-t border-slate-200` hairline so they don't merge.

Section labels are plain uppercase text (`text-xs font-bold uppercase tracking-[0.18em]`), not pills. A `HeroBadge` pill component used to sit above every heading, including in the two heroes, where it just restated the headline; it was removed rather than restyled.

`band-dark` is now only the Home hero, Home's pitch band and the About hero (the two heroes add a photo layer on top of it). The Progress page opens with a white header band closed by a `border-b border-slate-200`. The Practice page opens with a floating header card instead, the width of the content below it, carrying only the page's name — it scrolls away with the page (it was sticky for a while: a frozen 126px card under the nav took too much of the screen for a title), and the stat pills that sat in it were removed as Progress's job.

### Home and About show the domains at different depths — on purpose

Each page has one job, so they must not repeat the same domain section:

- **Home** shows only `ExamBlueprint` — the weighted bar. Each segment links into that domain's quiz, and one link below goes to `/about#exam-domains`.
- **About** owns the detail. `DomainBreakdown` is the same bar in select mode (`onSelect`, no labels) over an expandable row per domain listing its objective headings. `DomainDetailModal` holds the full outline.

Don't add per-domain cards back to Home. `ScrollToTop` honours URL hashes, which is what makes the `#exam-domains` link land on the section.

### Home shows the product once, low on the page

The hero is words only: one centred column, no artwork. It used to carry a tilted product showcase, which said the same thing as the band right below it and in the same shape (text left, art right). The product now demonstrates itself further down, and each band owns one part of it:

- **"Practice Like It's Exam Day"** (`previews/PracticePreview.jsx`) — the real `QuizQuestion`, answered wrongly so the explanation shows, above the real `QuestionNavigator` part-way through a 90-question mock.
- **"See Your Growth in Real-Time"** (`previews/ProgressPreview.jsx`) — the real `ScoreTrendChart` and `DomainPerformancePanel`, each laid out at its natural width and then scaled from its corner into an overlapping showcase. At working size the two panels ran to ~950px and read as a second dashboard bolted onto Home. Phones get the chart alone, unscaled.

Both render the app's own components rather than drawings of them, so changing a component changes the marketing picture with it. Both stages are `aria-hidden` + `inert` + `pointer-events-none`: they are pictures of the product, holding live inputs, chart tooltips and links that must not react or be tabbable inside a decoration.

Don't reintroduce a product showcase in the hero, and keep the pitch band to two ideas — an earlier six-tile feature grid there was judged too much to take in. Keep the copy truthful to what the app actually does.

### Quiz flow crosses a full page reload

Quiz setup and quiz taking are separate pages joined by a **hard navigation**, not react-router:

1. A setup component (`DomainQuiz`, `MockExam`, `WeakestSubjectQuiz`, `CustomQuizBuilder`) picks the questions.
2. It writes them to `sessionStorage` under a generated `quiz_<timestamp>` key — done to dodge URL length limits.
3. It sets `window.location.href` to `TakeQuiz?...` with that `quizId`, a `type` (`domain` | `mock` | `weakest` | `custom`), display params, and a `returnTo` section.
4. `TakeQuiz` reads `window.location.search` directly and pulls the questions back out of `sessionStorage`.
5. On exit, `TakeQuiz` hard-navigates back to `Lessons?section=<returnTo>`.

Because of this, `TakeQuiz` and `Lessons` read `window.location.search` rather than `useSearchParams`. If you convert any leg of this to client-side routing, convert the whole chain or the handoff breaks.

`/daily` (`pages/DailyQuestion.jsx`) is the one other full-screen page: an exit button and a title above the real `QuestionOfTheDay` card. It is plain react-router — no `sessionStorage` handoff — because the card reads the day's question itself and writes only to `daily_question`.

`MockExamSetup` (difficulty / count / timer options) is imported by nothing — the Practice page uses the simpler `MockExam`.

`TakeQuiz` is built to fit one laptop screen without scrolling: a single top bar (exit, title, timer, flag), Previous/Next inside the question card's footer, and — from lg — the navigator in a sidebar beside the question rather than stacked under it. `Layout` also drops the page padding on this route. Keep that constraint in mind when adding anything to the screen.

`createPageUrl()` in `src/lib/utils.js` returns a **relative** path (`"TakeQuiz"`, not `"/TakeQuiz"`). That works for `window.location.href` assignment from a top-level route, but inside a `<Link to=...>` React Router resolves it against the *current* route — from `/lesson/:id` it produces `/lesson/Lessons`, which matches nothing. Prefer explicit absolute paths in `<Link>`.

`App.jsx` deliberately registers both `/quiz` and `/TakeQuiz` for the same page because `createPageUrl('TakeQuiz')` generates the capitalized form. Route matching is case-insensitive (React Router default), so `/Lessons` still hits `path="/lessons"`.

### `/lessons` is the Practice page

The route is still `/lessons` so existing links keep working, but the nav item and the page both say "Practice". `QuizSidebar` switches sections: `dashboard`, `custom`, `mock`, `weakest`, or a domain id. Question of the Day is **not** a section — it has its own full-screen route (below) — and `?section=daily`, from when it was one, falls back to `dashboard`.

`?section=` is the initial state, and `changeSection` mirrors the current section back into the URL with a search-only `navigate(..., { replace: true })`. That keeps the page mounted (so no remount, and `ScrollToTop` stays put, since it only watches path and hash) while a reload or a shared link still lands on the right section. A `<Link>` to `/lessons?section=…` from *inside* the page won't switch sections — call `changeSection` instead.

The `dashboard` section (`quiz/Dashboard.jsx`) is the overview. It opens with one recommended next step chosen from the visitor's state (brand new, weak domain, no mock yet, keeping sharp), then the domains as a compact list, then the exam and targeted modes. It reads storage once on mount, which is safe because finishing a quiz always reloads this page.

Keep first-open in mind when editing it: a new visitor should see what each mode involves, not a grid of zeros.

### Outside links live in one module

`src/components/data/references.js` holds the external sources About cites, and `components/SourceLink.jsx` renders one as a small "Source: CompTIA" line **underneath the claim it backs** — not gathered into a list at the foot of the page, which was tried and removed.

Every URL there was fetched and confirmed to resolve before being added; do the same for anything new, and fix or drop a link rather than leaving a dead one. Keep the file to entries something actually cites. DoD 8140 is deliberately absent: `cyber.mil` redirects to a military SSO login.

Claims that can't be sourced come off the page — a "130% higher salary potential" stat and a "7 in 10 companies" line were both removed for this reason.

The Home hero's salary hook ($129,180 median, 21% growth to 2035) is BLS data for *information security analysts*, not for Security+ holders. Keep the distinction in the copy: the certificate opens the door to the role, it doesn't pay the median. Refresh the figures when BLS updates the handbook.

### Grids need a base column count

A `grid` with only `lg:grid-cols-*` has no column count below `lg`, so its single implicit column is sized by the widest card's max-content and overflows narrow screens. Always pair it with `grid-cols-1`, which resolves to `repeat(1, minmax(0, 1fr))` and is capped by the container. The Progress dashboard pushed phones sideways by 113px until this was added.

### Browser storage

Each key has one accessor module in `src/components/data/`. Go through it rather than calling storage directly.

- **`quiz_history`** (`quizHistoryData.js`) is the main one. `TakeQuiz` appends an attempt on submit. Each attempt records:
  - `type`
  - score and duration
  - `domainTitle`
  - a per-domain `domainBreakdown`
  - per-question results keyed by `hashQuestion`

  Progress and the Quiz Center dashboard are both selectors over this array (`getQuizStats`, `getModeStats` for per-type counts, `getDomainPerformance`, `getScoreTrend`, …). `WeakestSubjectQuiz` and the custom-quiz pools also read it.

  Averages are weighted by question (total correct ÷ total answered), never by attempt, so a 10-question quiz can't count as much as a 90-question mock. `getScoreTrend` returns `{ practice, mock }` rather than one series; `ScoreTrendChart` plots `practice` only and draws no pass-mark rule, because mock scores belong to Progress's `ReadinessCard` (a 10-question quiz on the same line as a 90-question mock made a bad quiz look like a failed exam).
- **`daily_question`** (`dailyQuestion.js`) holds Question of the Day answers and the streak. It is deliberately **not** in `quiz_history`, because a one-question 0%/100% would swing the averages. It is shown separately: in the Quiz Center's daily strip (a link to `/daily`), and in Progress's `PracticeMixPanel`.
- **`flagged_questions`** (`questionPools.js`) holds questions flagged during a quiz. They are one of the Build Your Own Quiz pools.
- **`security_plus_progress`** (`progressData.js`) holds lesson completion. Its only writer is unreachable (see below), so the Home hero's progress counter never appears.

### Wrong answers get their own explanations

Each question carries one `explanation`, which only covers the right answer. Why a *wrong* choice is wrong lives in `src/components/data/rationales/domain<N>.js`, keyed by question text and then by the wrong choice's text — readable on their own, and unaffected by choices being reordered. `choiceRationales.js` merges them and exposes `getChoiceRationale(question, choiceIndex)`.

All 1,332 wrong choices are covered. If you edit a question or a choice's wording in `quizData`, rename the matching key or that choice silently loses its note. `AnswerExplanation` renders the pair (right answer, then your wrong pick) and is used by the quiz, the results review and Question of the Day.

Question labels in `quizData` ("Domain 3: Architecture & Design") don't match the titles in `securityDomains`. Join attempts back to domain metadata with `getDomainByQuizLabel`, never by title.

`getDomainPerformance` returns `strongest` / `weakest` as `null` unless at least two attempted domains have different accuracy. For "the lowest domain so far", use `ranked[0]`, as `WeakestSubjectQuiz` does.

Score thresholds live in `src/lib/performanceStatus.js`:
- `MOCK_PASS_MARK` is the single 83% mock pass mark.
- `statusForAccuracy` gives the on-track / shaky / needs-work colours.

Don't redefine either locally.

Progress has a "Sample data" switch. It feeds the `src/lib/demoProgressData.js` fixture through the same selectors without writing storage:
- `demoQuizHistory` stands in for quiz history.
- `demoDailyStats` stands in for the daily streak, since that data isn't in the history.

Home's two previews fall back to `demoQuizHistory` as well, labelled as sample data, and switch to the visitor's own results once there are two attempts of the same kind (`canDrawTrend`: two practice quizzes or two mocks, since the trend chart plots them apart and needs two points to draw a line). Use the switch to check populated layouts without taking quizzes.

### The lesson-reading flow is disconnected

There is no route that lists or reads lessons. The reading path is orphaned:

- `LessonCard.jsx` is imported by nothing. It links to `/lessons/:id`, but the route is `/lesson/:id` (singular). It also reads `lesson.domain` / `lesson.estimatedMinutes`, which don't exist in `lessonsData`; the fields are `category` and `duration`.
- `LessonDetail` is routed as `/lesson/:id` but reads its id from `?id=` via `URLSearchParams` instead of `useParams`, so it always renders "Lesson not found". Nothing links to it anyway.
- Consequently `markLessonComplete()`, which only `LessonDetail` calls, is unreachable, and `security_plus_progress` is never written.

The six entries in `lessonsData.js` (each with full markdown `content`) are currently used only for their `length` as a denominator. Restoring this flow is a known gap, not an accident to work around.

### Question bank

`quizData.js` exports `quizQuestions` keyed `domain1`–`domain5`, plus `getAllQuestions()`. It holds 444 questions.

Every question carries an `objective` (`'4.6'`, `'2.4'`, …) naming the SY0-701 objective it tests — the one the official outline in `examObjectives.js` lists that term under. New questions need one. `npm run objectives` prints coverage per objective and fails if a question has no `objective` or names one that doesn't exist.

**147 of the 444 are filed in a domain array that doesn't match their objective** (risk-management questions under Domain 1, crypto under Domain 3, and so on), so per-domain stats currently describe the filing, not the content. `npm run objectives` lists them and compares both splits against the exam weights. Moving them is deliberately not done yet: it changes what each domain quiz asks.

Coverage by the array a question is filed in is skewed against the real exam weights:

| Domain | Questions |
|---|---|
| 1–3 | 104–110 each |
| 4 (Security Operations) | 36, despite being 28% of the exam |
| 5 | 87 |

`MockExam` draws a random 90 from the pooled bank with no per-domain weighting. The copy in Home's How It Works calling questions "weighted to match the real SY0-701 exam" is therefore untrue today.

### Styling

Tailwind 3 + shadcn/ui with the `@/` alias (configured in both `vite.config.js` and `jsconfig.json` — update both if it changes). Brand colors are the `comptia-*` palette in `tailwind.config.cjs` (`charcoal`, `cream`, `canvas`, …). Per-domain fills use each domain's `chartColor` hex through inline `style`, because they're chosen at runtime.

The brand red is applied by an inline `<style>` block in `Layout.jsx` that overrides Tailwind's `red-600`/`red-700`/`red-50` utilities with `!important` to hit `#C8102E`. So `bg-red-600` in any component renders the brand red, not Tailwind's default. Changing the brand color means editing that block, not the Tailwind config.

Pages build full-width bands with the `.full-bleed` utility (`src/index.css`). They sit inside a `-mt-8` wrapper that escapes the `Layout` main padding; Home also uses `-mb-8`, so its closing card's section sets its own even gap above the footer. The nav is sticky at 4.5rem, so anchor targets need `scroll-mt-24`. `Layout` hides its nav and footer, and trims the page padding, on the two full-screen pages — `currentPageName` of `"TakeQuiz"` or `"DailyQuestion"` (`isFullScreen`).

Asset imports are case-sensitive in the Alpine-based Docker build but not on the default macOS/Windows filesystems — match the on-disk filename exactly (several asset folders also contain spaces, e.g. `assets/home page/`).
