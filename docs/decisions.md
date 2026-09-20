# Decisions — what was tried and deliberately undone

**Read this before adding anything visual or product-shaped.** Most entries here look like
obvious missing features. They were built, judged, and removed. Re-adding one is the most
likely way to waste a day.

If you think an entry should be reversed, say so and ask — don't just do it.

## Product

| Decision | Why | Do not |
|---|---|---|
| **No leaderboard, ranking or percentiles** | An account exists to keep one person's own data safe, not to compare them to others. Rejected outright. | Add ranking, percentiles, public profiles, shared scores, or any cross-user visibility |
| **No feature moves behind the login** | Everything free stays free; an account adds durability, never access | Gate an existing feature on sign-in |
| **Merge on signup is mandatory** | Signing up must never cost someone their anonymous history | Ship auth without the import path |
| **Mock exams are server-held for *resume*, not anti-cheat** | With nothing to rank there is nobody to cheat. The real problem is losing 90 minutes to a closed tab | Justify the exam session API with integrity arguments — it won't survive scrutiny |

## Home page

| Removed | Why | Do not |
|---|---|---|
| **`HeroBadge` pill component** | Sat above every heading, including both heroes, where it just restated the headline | Reintroduce pills above headings — section labels are plain uppercase text |
| **Tilted product showcase in the hero** | Said the same thing as the band right below it, in the same shape (text left, art right) | Put a product showcase back in the hero |
| **Six-tile feature grid in the pitch band** | Too much to take in | Expand the pitch band past two ideas |
| **Per-domain cards on Home** | Home shows only `ExamBlueprint`; About owns the detail | Duplicate the domain detail onto Home |
| **Full-bleed red closing band** | Changed to a floating red card to match About's | Make it full-bleed again |
| Three different darks + a cream band | Read as a patchwork | Add a third band tone |

## Practice / Progress

| Removed | Why | Do not |
|---|---|---|
| **Sticky Practice header card** | A frozen 126px card under the nav took too much of the screen for a page title | Make it sticky again |
| **Stat pills in the Practice header** | That is Progress's job | Put stats back on the Practice header |
| **Source links gathered at the page foot** | Each source belongs underneath the claim it backs | Collect `SourceLink`s into a list |
| **Mock scores on the practice trend line** | A 10-question quiz on the same line as a 90-question mock made a bad quiz look like a failed exam | Merge `getScoreTrend`'s `practice` and `mock` series |

## Unsourced or misleading copy

| Removed | Why |
|---|---|
| **"130% higher salary potential"** | Could not be sourced |
| **"7 in 10 companies"** | Could not be sourced |
| **DoD 8140 reference link** | `cyber.mil` redirects to a military SSO login |

Still on the page and needing care:

- The Home hero's **$129,180 median / 21% growth** figures are BLS data for *information
  security analysts*, **not** Security+ holders. The copy must keep that distinction.
- Home's How It Works says questions are **"weighted to match the real SY0-701 exam"**. This
  is **untrue today** — `MockExam` draws a flat random 90. Phase 4 makes it true. Don't build
  more copy on top of it until then.

## Stack

| Abandoned | In favour of |
|---|---|
| AWS Lambda + API Gateway | Docker → ECR → App Runner |
| AWS Cognito | Own bcrypt + JWT with rotating refresh tokens |
| AWS Amplify | S3 + CloudFront |
| MySQL | PostgreSQL |
| TypeScript | Plain JSX (the original README claimed TS; it never was) |
| React Query | Plain fetch through the accessor modules |
| Spring Boot 3.x | 4.1 — Initializr no longer offers 3.x at all |
| Java 21 | Java 25 — the installed LTS; pinning to 21 forces a second toolchain download |
| `citext` extension | A `lower(email)` unique index, so the schema runs on stock RDS |

## Deliberately deferred

Not bugs. Known, chosen, and waiting.

| Deferred | Why | Blocks / blocked by |
|---|---|---|
| **Moving the 147 misfiled questions** | Changes what each domain quiz asks | Do it with the Phase 1 import, not piecemeal |
| **Blueprint-weighted mock draw** | Needs the server-side draw | Phase 4 |
| **The lesson-reading flow** | Orphaned: wrong route, wrong param reader, unreachable writer | A known gap, not something to work around |
| **A production image for `secapp/`** | Phase 6 serves `dist/` from S3 + CloudFront | May never be needed |
| **Front-end test framework** | None configured | Considered after Phase 1 |
| **Fixing the 6 lint problems** | Baseline-tracked instead, so they can't grow | `npm run lint:check` |

## Naming oddities that are not mistakes

- **`/lessons` is the Practice page.** The route stays for existing links; the nav and page
  both say "Practice".
- **Both `/quiz` and `/TakeQuiz` are registered.** `createPageUrl('TakeQuiz')` generates the
  capitalized form.
- **`AdminContentManager.jsx` is a Study Resources page**, not an admin panel. It is linked
  in the nav as "Resources". Rename it before building a real admin panel.
- **`MockExamSetup.jsx` is imported by nothing.** The Practice page uses the simpler
  `MockExam`.
