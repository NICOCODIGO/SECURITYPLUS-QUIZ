# Question bank & content

The 444 questions, their objectives, their wrong-answer rationales, and the external sources
the site cites. All are written in `secapp/src/components/data/`. The API serves a copy of the
bank from Postgres, generated from those files ([database.md](database.md)).

## Where the bank lives

The source of truth is still `secapp/src/components/data/quizData.js` plus the files in
`secapp/src/components/data/rationales/`. `node scripts/generate-seed.mjs` turns those into
`server/src/main/resources/db/migration/R__seed_content.sql`, which Flyway loads into
Postgres — see [database.md](database.md).

**After editing any question, choice or rationale, regenerate the seed.** `./verify.sh`
fails if you forget.

## Shape of a question

`quizData.js` exports `quizQuestions` keyed `domain1`–`domain5`, plus `getAllQuestions()`.

```js
{
  difficulty: 'Beginner' | 'Intermediate' | 'Advanced',
  domain: 'Domain 1: General Security Concepts',   // the quizLabel, see the join warning
  objective: '1.2',                                 // required
  question: 'What does the CIA triad stand for...',
  choices: ['...', '...', '...', '...'],            // always 4 today
  correctAnswer: 0,                                 // index into choices
  explanation: 'Why the correct answer is correct.'
}
```

**Current totals: 444 questions, 1,776 choices, 1,332 wrong choices — all 1,332 covered by a
rationale.**

## Every question needs an `objective`

The `objective` names the SY0-701 objective the question tests — the one the official outline
in `examObjectives.js` lists that term under.

```bash
cd secapp && npm run objectives
```

Prints coverage per objective and **fails** if a question has no `objective` or names one
that doesn't exist. It runs in CI and in `./verify.sh`.

## The 147 misfiled questions

**147 of the 444 sit in a domain array that doesn't match their objective** — risk-management
questions under Domain 1, crypto under Domain 3, and so on. So per-domain stats today
describe the *filing*, not the content.

The two splits are very different:

| Domain | Filed | By objective | Exam weight |
|---|---|---|---|
| 1.0 General Security Concepts | 104 (23%) | 67 (15%) | 12% |
| 2.0 Threats, Vulnerabilities, Mitigations | 107 (24%) | 109 (25%) | 22% |
| 3.0 Security Architecture | 110 (25%) | 76 (17%) | 18% |
| 4.0 Security Operations | **36 (8%)** | **93 (21%)** | 28% |
| 5.0 Security Program Management | 87 (20%) | 99 (22%) | 20% |

**Read that Domain 4 row carefully.** The often-quoted "Domain 4 only has 36 questions" is a
fact about the filing. By objective it has 93, which is what a blueprint-weighted mock draw
will actually use — so a weighted 90-question exam needs ~25 of 93 and works fine.

Moving the 147 is **deliberately not done yet**: it changes what each domain quiz asks.

### Genuinely thin objectives

These are the real content gaps, and the place to add questions first:

| Objective | Questions |
|---|---|
| 4.9 Use data sources to support an investigation | **1** |
| 4.2 Hardware/software/data asset security | **2** |
| 1.3 Change management | 3 |
| 2.1 Threat actors and motivations | 3 |
| 2.5 Mitigation techniques | 3 |
| 5.3 Third-party risk | 3 |

## Wrong answers get their own explanations

Each question's `explanation` only covers the **right** answer. Why a *wrong* choice is wrong
lives in `secapp/src/components/data/rationales/domain<N>.js`:

```js
{ "<exact question text>": { "<exact wrong choice text>": "why it's wrong" } }
```

Keyed by **text**, not index — so they read on their own and survive choices being reordered.
`choiceRationales.js` merges the five files and exposes
`getChoiceRationale(question, choiceIndex)`. `AnswerExplanation` renders the pair (right
answer, then your wrong pick) and is used by the quiz, the results review, and Question of
the Day.

> ⚠️ **The fragility to know about.** If you edit a question's wording, or a choice's
> wording, in `quizData.js`, you must rename the matching key in the rationale file or that
> choice **silently** loses its note. Nothing errors. This is the single easiest way to
> quietly damage the content.

The same fragility hits history: question ids are `hashQuestion(question.question)`, a djb2
hash of the text, so **editing a question's wording retires its history** for every user.
Postgres does give each question a stable uuid, but it does not fix this yet: the browser and
sync still identify questions by the hash (`legacy_hash`), and the seed is keyed on it, so an
edited question arrives as a new row and the old one is retired.

## Joining questions back to domains

Question labels in `quizData` (`"Domain 3: Architecture & Design"`) **do not match** the
titles in `securityDomains.js`. Always join with `getDomainByQuizLabel`, **never by title**.

`securityDomains.js` is the single source of truth for the five domains — id, number, weight,
title, `quizLabel`, topics, icon, `chartColor`, Tailwind tokens. `numberedTitle` and
`questionCount` are **derived** (`questionCount` counts real entries in `quizData`), so never
hardcode either. It was extracted to kill five drifting copies; put new domain metadata here,
not inline in a page.

The official objectives outline lives separately in `examObjectives.js` — all five domains,
nested up to four levels.

## Question of the Day

Derived from the date, never stored. `dailyQuestion.js` steps through the bank by a stride
coprime with the bank size, so every question comes up exactly once per full cycle (444 days
at the current size) while consecutive days land far apart. Hashing each date independently
looked random but repeated questions inside a fortnight, which is very noticeable on
something labelled "of the day".

Only the answer and the streak are persisted, and **not** into `quiz_history` — a
one-question 0%/100% would swing the averages. It is account-only: signed out it isn't
offered at all (see `secapp/src/components/quiz/accountOnly.js`).

## Mock exam draw

`MockExam` currently draws a **random 90 from the pooled bank with no per-domain weighting**.
Home's How It Works copy calling questions "weighted to match the real SY0-701 exam" is
therefore **untrue today**. Phase 4 makes it true with a server-side weighted draw; until
then, don't add copy that leans on it.

## External sources

`secapp/src/components/data/references.js` holds the sources About cites.
`components/SourceLink.jsx` renders one as a small "Source: CompTIA" line **underneath the
claim it backs** — not gathered into a list at the foot of the page, which was tried and
removed.

Rules:

- **Every URL must be fetched and confirmed to resolve before it is added.** Do the same for
  anything new, and fix or drop a dead link rather than leaving it.
- Keep the file to entries something actually cites.
- **DoD 8140 is deliberately absent** — `cyber.mil` redirects to a military SSO login.
- **Claims that can't be sourced come off the page.** A "130% higher salary potential" stat
  and a "7 in 10 companies" line were both removed for this reason.
- The Home hero's salary hook ($129,180 median, 21% growth to 2035) is **BLS data for
  information security analysts**, not for Security+ holders. Keep that distinction in the
  copy: the certificate opens the door to the role, it doesn't pay the median. Refresh when
  BLS updates the handbook.

## Lessons

`lessonsData.js` holds six lessons with full markdown `content`, currently used only for
their `length` as a denominator — the reading flow is orphaned. See [frontend.md](frontend.md).
