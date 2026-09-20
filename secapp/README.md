# secapp — front end

React 19 + Vite 7 + Tailwind 3 + shadcn/ui, plain JSX. This is the whole user-facing app;
the API lives in [`../server`](../server) and the project overview is in the
[root README](../README.md).

```bash
npm install
npm run dev         # http://localhost:5173
npm run build       # production build to dist/
npm run preview     # serve the built dist/
npm run lint        # eslint — 6 known pre-existing problems
npm run objectives  # question-bank coverage per SY0-701 objective
```

## It runs without a back end

Set `VITE_API_URL` to talk to the API; leave it unset and the app falls back to browser
storage and the question bank bundled in `src/components/data/quizData.js`. That fallback is
deliberate and load-bearing — `npm run dev` on a clean checkout must give a fully working
app with no Docker, no database and no account.

```bash
VITE_API_URL=http://localhost:8080 npm run dev
```

## Layout

```
src/
├── pages/              route components (Home, Lessons, Progress, TakeQuiz, …)
├── components/
│   ├── data/           one accessor module per storage key + the question bank
│   ├── quiz/           quiz modes, navigator, results, Question of the Day
│   ├── progress/       dashboard panels and charts
│   ├── previews/       live product shots used on the Home page
│   └── ui/             shadcn primitives
└── lib/                utils, score thresholds, demo fixtures
```

`src/components/data/` is the important one: each browser-storage key has exactly one
accessor module, and the analytics selectors over quiz history all live in
`quizHistoryData.js`. Go through those rather than calling `localStorage` directly.

## Docker

`docker-compose up` here runs the **Vite dev server** in a container, not a production
build — same as `Dockerfile`. To run the full stack (API and database included), use
`docker compose up` from the repo root instead.

## Before you change anything

Read [`../CLAUDE.md`](../CLAUDE.md). It documents the decisions this codebase has already
made and reversed — why Home and About show the domains at different depths, why the quiz
flow crosses a hard page reload, why grids need a base column count — and it will save you
from redoing work that was deliberately undone.
