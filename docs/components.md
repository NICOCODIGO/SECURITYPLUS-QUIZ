# Components & styling

Visual rules for `secapp/`. **Read [decisions.md](decisions.md) before changing anything
visual** — much of what looks missing from this UI was removed on purpose.

## Tailwind setup

Tailwind 3 + shadcn/ui with the `@/` alias, configured in **both** `secapp/vite.config.js`
and `secapp/jsconfig.json` — update both if it changes.

Brand colours are the `comptia-*` palette in `secapp/tailwind.config.cjs` (`charcoal`,
`cream`, `canvas`, …). Per-domain fills use each domain's `chartColor` hex through inline
`style`, because they're chosen at runtime.

### The brand red is an override, not a config value

`secapp/src/Layout.jsx` — note that it sits directly in the src folder, **not** under
`secapp/src/pages/` — carries an inline `<style>` block at lines 50–59 that overrides
Tailwind's red utilities with `!important`:

```
.text-red-600, .text-red-700  → #C8102E
.bg-red-600                   → #C8102E
.bg-red-700, .hover:bg-red-700 → #B01D2A
.bg-red-50                    → #FEF2F3
.border-red-200               → #FECDD3
.border-red-600, .hover:border-red-600 → #C8102E
```

So `bg-red-600` in any component renders the brand red, not Tailwind's default. Changing the
brand colour means editing that block — **not** the Tailwind config.

**But that block is not the only place the hex lives.** `#C8102E` is also hardcoded in six
other files, so a colour change means touching all seven:

| File | Use |
|---|---|
| `secapp/src/Layout.jsx` | the override block |
| `secapp/src/index.css` | focus outline |
| `secapp/src/components/Logo.jsx` | `const RED` |
| `secapp/src/components/progress/ScoreTrendChart.jsx` | `const SERIES` |
| `secapp/src/components/data/securityDomains.js` | Domain 2 `chartColor` |
| `secapp/src/lib/performanceStatus.js` | the "needs work" status colour |
| `secapp/src/pages/Progress.jsx` | a failing-score colour |

## Bands come in two tones

Full-width sections use `.band-dark` (`secapp/src/index.css`) or plain white. Home previously
mixed three different darks plus a cream band, which read as a patchwork.

Red stays an accent (buttons, rules, small labels), with one exception: Home and About both
close on a **floating red card** — a rounded island on the canvas, not a full-width band — as
the last thing above the footer. Home's used to be a full-bleed red band and was changed to
match About's.

**White bands that sit next to each other carry a `border-t border-slate-200` hairline** so
they don't merge.

`band-dark` is now only: the Home hero, Home's pitch band, and the About hero (the two heroes
add a photo layer on top of it).

- **Progress** opens with a white header band closed by `border-b border-slate-200`.
- **Practice** opens with a floating header card the width of the content below it, carrying
  only the page name. It scrolls away with the page — it was sticky for a while, and a frozen
  126px card under the nav took too much of the screen for a title. The stat pills that sat
  in it were removed as Progress's job.

### Section labels

Plain uppercase text: `text-xs font-bold uppercase tracking-[0.18em]`. **Not pills.** A
`HeroBadge` pill component used to sit above every heading, including in both heroes where it
just restated the headline. It was removed rather than restyled — don't reintroduce it.

### Status badges are not section labels

The account page's settings cards (`secapp/src/pages/Account.jsx`) carry a small badge beside
the card title — **On** / **Off**, **Confirmed** / **Not confirmed**. That is a status marker,
not the label pill ruled out above. It uses the emerald/amber pair from
`secapp/src/lib/performanceStatus.js` and always pairs the colour with a word, never colour
alone.

## Layout mechanics

- Pages build full-width bands with the `.full-bleed` utility (`secapp/src/index.css`),
  inside a `-mt-8` wrapper that escapes the `Layout` main padding. Home also uses `-mb-8`, so
  its closing card's section sets its own even gap above the footer.
- The nav is **sticky at 4.5rem**, so anchor targets need `scroll-mt-24`.
- `Layout` hides nav and footer and trims padding on the two full-screen pages —
  `currentPageName` of `"TakeQuiz"` or `"DailyQuestion"`, via `isFullScreen`
  (`secapp/src/Layout.jsx:27`).

### Grids need a base column count

A `grid` with only `lg:grid-cols-*` has **no column count below `lg`**, so its single implicit
column is sized by the widest card's max-content and overflows narrow screens. Always pair it
with `grid-cols-1`, which resolves to `repeat(1, minmax(0, 1fr))` and is capped by the
container.

The Progress dashboard pushed phones sideways by 113px until this was added.

## Home and About show the domains at different depths — on purpose

Each page has one job, so they must not repeat the same domain section:

- **Home** shows only `ExamBlueprint` — the weighted bar. Each segment links into that
  domain's quiz, and one link below goes to `/about#exam-domains`.
- **About** owns the detail. `DomainBreakdown` is the same bar in select mode (`onSelect`, no
  labels) over an expandable row per domain listing its objective headings.
  `DomainDetailModal` holds the full outline.

**Don't add per-domain cards back to Home.** `ScrollToTop` honours URL hashes, which is what
makes the `#exam-domains` link land on the section.

## Home shows the product once, low on the page

The hero is words only: one centred column, no artwork. It used to carry a tilted product
showcase, which said the same thing as the band right below it and in the same shape (text
left, art right).

The product now demonstrates itself further down, and each band owns one part:

- **"Practice Like It's Exam Day"** (`secapp/src/components/previews/PracticePreview.jsx`) — the real
  `QuizQuestion`, answered wrongly so the explanation shows, above the real
  `QuestionNavigator` part-way through a 90-question mock.
- **"See Your Growth in Real-Time"** (`secapp/src/components/previews/ProgressPreview.jsx`) — the real
  `ScoreTrendChart` and `DomainPerformancePanel`, each laid out at natural width then scaled
  from its corner into an overlapping showcase. At working size the two panels ran to ~950px
  and read as a second dashboard bolted onto Home. Phones get the chart alone, unscaled.

Both render the app's **own components** rather than drawings of them, so changing a
component changes the marketing picture with it.

Both stages are **`aria-hidden` + `inert` + `pointer-events-none`**: they are pictures of the
product holding live inputs, chart tooltips and links that must not react or be tabbable
inside a decoration. Keep all three if you touch them.

**Don't reintroduce a product showcase in the hero**, and keep the pitch band to two ideas —
an earlier six-tile feature grid there was judged too much to take in.

## shadcn primitives

`secapp/src/components/ui/` holds the generated shadcn wrappers: `alert-dialog`, `badge`,
`button`, `card`, `checkbox`, `dropdown-menu`, `input`, `label`, `progress`, `radio-group`,
`scroll-area`, `select`, `separator`, `slider`, `switch`, `tabs`.

**Known defect:** several forwardRef wrappers pass `ref__={ref}` instead of `ref={ref}` —
`alert-dialog.jsx` among them. Radix's own internals still work (focus trap, portals), so
these components function, but outer ref forwarding is broken. Don't rely on attaching a ref
to one of these from a parent.

`badge.jsx` and `button.jsx` are two of the six known lint problems (react-refresh
`only-export-components`). See [devops.md](devops.md) for the baseline.

## Assets

Asset imports are **case-sensitive in the Alpine-based Docker build** but not on the default
macOS/Windows filesystems — match the on-disk filename exactly. Several asset folders also
contain spaces, e.g. `secapp/src/assets/home page/`.
