# secapp — the website

This folder is the website: every page a visitor sees on certucation.click, including the
quizzes, the mock exam and the progress dashboard. It is built with React 19, Vite 7,
Tailwind 3 and shadcn/ui, written in plain JSX (not TypeScript).

The API is in [`../server`](../server), and the project overview is in the
[root README](../README.md). Terms such as React, Vite and lint are explained in the
[glossary](../docs/guide/glossary.md#website-tools).

## Commands

Run these from this folder:

```bash
npm install
npm run dev         # http://localhost:5173
npm run build       # production build to dist/
npm run preview     # serve the built dist/
npm run lint:check  # lint against the baseline of 6 known problems (use this, not npm run lint)
npm run objectives  # question-bank coverage per SY0-701 objective
```

## Running without the API

**The website works on its own, with no API, database or Docker.** This is deliberate and
required: `npm run dev` on a clean checkout must give a working app.

With `VITE_API_URL` unset, the app uses the question bank bundled in
`src/components/data/quizData.js`. The domain quizzes, the mock exam and all questions work as
normal. There are no accounts in this mode, so no results are recorded, and the modes that need
an account (Weakest Subject, Build Your Own and Question of the Day) are unavailable.

To connect to a local API:

```bash
VITE_API_URL=http://localhost:8080 npm run dev
```

## Layout

```
src/
├── pages/              one file per page (Home, Lessons, Progress, TakeQuiz, …)
├── components/
│   ├── data/           the question bank, and one accessor module per storage key
│   ├── quiz/           quiz modes, navigator, results, Question of the Day
│   ├── progress/       the panels and charts on the Progress dashboard
│   ├── auth/           the sign-in form and account menu
│   ├── domains/        the per-domain breakdowns and exam blueprint
│   ├── lessons/        lesson cards
│   ├── previews/       live product previews used on the Home page
│   └── ui/             shadcn building blocks (buttons, cards, dialogs)
├── api/                sends requests to the API and holds the sign-in token in memory
├── auth/               tracks who is signed in and handles sign-in calls
├── lib/                small shared helpers: utilities, score thresholds, demo data
└── assets/             images
```

**`src/components/data/` is the most important folder.** Each browser-storage key has exactly
one accessor module, and the analytics over quiz history are all in `quizHistoryData.js`. Use
those modules rather than calling `localStorage` directly.

## Docker

`docker-compose up` in this folder runs the **Vite dev server** in a container, the same as
`Dockerfile`. It is not a production build; Amplify builds the live site. To run the full stack
(API and database included), run `docker compose up` from the repository root instead.

## Before you change anything

**Read [docs/decisions.md](../docs/decisions.md) first.** It records features that were built
and then deliberately removed. Many of them look like obvious missing features, so checking it
first avoids rebuilding something that was undone on purpose.

Other front-end details are in:

- [docs/frontend.md](../docs/frontend.md): pages, routing and browser storage, including
  [why the quiz flow crosses a full page reload](../docs/frontend.md#the-quiz-flow-crosses-a-full-page-reload).
- [docs/components.md](../docs/components.md): styling and layout, including why Home and
  About show the domains at different levels of detail, and why grids need a base column count.

[CLAUDE.md](../CLAUDE.md) is the index of all the docs.
