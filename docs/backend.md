# Back end

Java 25, Spring Boot 4.1, Gradle wrapper. Lives in `server/`. Schema detail is in
[database.md](database.md); containers and env vars in [devops.md](devops.md).

**Status:** the public read-only question API and **auth** are live and tested. Attempts and
exam sessions are still design only — each endpoint below is marked.

## Why these versions

- **Spring Boot 4.1**, not 3.x — Spring Initializr no longer offers any 3.x release. Boot 4
  splits the test starter into granular ones and renames `starter-web` to `starter-webmvc`,
  which is why `build.gradle` looks unfamiliar.
- **Java 25**, not 21 — it is the installed LTS. Pinning to 21 would make every build
  depend on Gradle downloading a second toolchain.

`gradlew` is the Gradle wrapper: it downloads the pinned Gradle (9.7.1, see
`server/gradle/wrapper/gradle-wrapper.properties`) on first run, so nobody needs Gradle
installed. Committed to git; regenerate with `./gradlew wrapper --gradle-version X`, never
by hand.

## Layout

```
server/src/main/java/com/secplus/
  ServerApplication.java
  auth/  questions/  common/
  attempts/  exams/                  ← planned
server/src/main/resources/
  application.properties
  db/migration/V1__init.sql          schema
  db/migration/R__seed_content.sql   the question bank — GENERATED, see database.md
server/src/test/java/com/secplus/
  ServerApplicationTests.java        context loads
  SchemaMigrationTests.java          the migration against real Postgres
  ContentSeedTests.java              the seeded question bank landed correctly
  QuestionApiTests.java              the public question API
  AuthApiTests.java                  register/login/refresh/logout/me
  auth/LoginRateLimiterTests.java    window logic — needs no Docker
  TestcontainersConfiguration.java   pinned postgres:17-alpine
  TestServerApplication.java         bootRun with containers
```

**52 tests, all passing** against a real Postgres container.

## Flyway owns the schema

`spring.jpa.hibernate.ddl-auto=validate` — Hibernate checks that entities match the
migrations and is **never** allowed to write DDL.

A schema change is a new `V<n>__*.sql` in `server/src/main/resources/db/migration`, never an
entity edit alone, and **never an edit to a migration that has already been applied**.

## API surface (`/api/v1`)

**Public — ✅ built.**

| Endpoint | Returns |
|---|---|
| `GET /questions` | practice questions **with** the answer key |
| `GET /objectives` | all 28, with a live question count each |
| `GET /domains` | per-domain counts, both by objective and by filing |

`/questions` filters: `objective` (`4.6`), `domain` (1–5, **by objective**), `filedDomain`
(1–5, the legacy quizData array), `difficulty`, `limit` (page size, 1–200, default 50) and
`page` (0-based). **The bank is 444 and one response is capped at 200**, so a client that
wants all of it walks pages until a short one comes back — reading only page 0 silently
gets less than half. Both domain filters are exposed on purpose — they disagree for 147 questions, and the front end should
switch from filing to objective as a deliberate decision, not a silent one.

Bad input returns **400** with an RFC 7807 ProblemDetail body naming the parameter.
Unauthenticated requests to anything else return **401**, not 403.

⬜ `GET /questions/daily?date=` — not built.

**Auth — ✅ built.** `POST /auth/register`, `/auth/login`, `/auth/refresh`, `/auth/logout`,
`GET /auth/me`. All under `/api/v1`. Everything but `/auth/me` is `permitAll` — you sign in
without a token by definition, and you sign out with an expired one more often than not.

The access token comes back in the body; the refresh token only ever leaves as an httpOnly
cookie scoped to `/api/v1/auth`, so it is not sent with every question request and script
cannot read it.

`/auth/refresh` and `/auth/logout` require an **`X-Secplus-Client`** header. That is this
API's CSRF defence: a cross-site form or `<img>` cannot set a custom header without a
preflight, and CORS only allows the configured origins. It is deliberately not Spring's CSRF
machinery, which would mean a readable CSRF cookie and a double-submit dance for two
endpoints on an otherwise stateless API. Omit the header and you get a 4xx, so the front end
sets it inside `apiClient` rather than at any call site.

**Exams (server session)** — `POST /exams` creates a DynamoDB session and returns questions
**without** `is_correct`; `PATCH /exams/{id}/answers` autosaves; `POST /exams/{id}/submit`
grades, writes the attempt to Postgres, and returns the full review payload (correct
answers, explanations, rationales).

**Me — ✅ built.** `GET/POST /me/attempts`, `GET/PUT /me/flags`, `GET/POST /me/daily`. All
authenticated, all filtered on the `sub` claim — which is the only ownership check there is,
so every statement in `MeStore` carries a `where user_id`.

`POST /me/attempts` is idempotent on a **client-minted** attempt id (`on conflict do nothing`)
and always returns 204, because the browser re-sends whatever it is unsure about and a 409
would turn a successful retry into an error it has to special-case.

There is no `POST /me/import`: with recording gated on an account there is no anonymous history
to merge. The browser instead sends up any attempt the server does not already have when it
hydrates. And no `/me/presets` — `CustomQuizBuilder` holds its configuration in `useState` and
never persists it, so that table maps to a key nothing writes.

**Ops** — `/actuator/health` and `/actuator/info`, both public. Metrics are deliberately **not**
exposed: "authenticated" means any account, and anyone can make one. No `/swagger-ui`:
`springdoc` is not a dependency.

**`/me` writes are size-limited** (`MeViews`): an attempt carries at most `MAX_ANSWERS` answers,
flags and daily uploads are capped per request, and a malformed date is a 400, not a 500. Every
answer is its own insert, so without the caps one signed-in request could make the server do
unbounded work.

### The one contract that must not drift

`GET /me/attempts` returns records in **exactly** the `quiz_history` shape the front end
already uses:

```js
{ date, type, score, questionsCount, durationSeconds, domainTitle,
  domainBreakdown: [...], answers: [{ id, ok }] }
```

That single choice is what lets every existing selector in
`secapp/src/components/data/quizHistoryData.js` work unchanged. **Do not reimplement the
progress analytics server-side** — with no cross-user comparison there is nothing the
browser can't work out from its own attempts array.

`domainBreakdown` is *not* stored; it is derived by joining `attempt_answers` →
`questions` → `objectives`, so it can never drift from the answers it summarises.

## Which data is withheld, and which isn't

| Mode | Answer key | Graded |
|---|---|---|
| `domain`, `weakest`, `custom` | sent inline | in the browser |
| `mock` | withheld | on the server |

Practice quizzes show feedback the instant you answer; a round trip per question would ruin
that, and a personal practice score isn't worth protecting.

**Mock exams run server-side for resume, not integrity.** With no leaderboard there is
nobody to cheat. A mock is 90 questions and ~90 minutes, and today closing the tab loses all
of it — the server holds the session (DynamoDB, keyed by session id, TTL-expired) so an
interrupted exam can be picked back up, on another device if need be. Grading happens there
simply because that is where the session already is. The key is withheld not as a security
measure but because a mock reveals nothing until submit, so the client has no use for it.

### Account security — ✅ built

| Endpoint | Does |
|---|---|
| `POST /auth/2fa/verify` | Challenge + code → a session |
| `POST /auth/verify-email` | Spends a verification link |
| `POST /auth/resend-verification` | Authenticated; rate limited per account |
| `POST /auth/forgot-password` | **Always 204** |
| `POST /auth/reset-password` | New password; kills every refresh token |
| `GET /auth/2fa` | Method in use, recovery codes left |
| `POST /auth/2fa/setup` | Begins setup; TOTP secret is returned here, once |
| `POST /auth/2fa/confirm` | Enables it; **the only response with recovery codes in the clear** |
| `POST /auth/2fa/disable` | Needs the password, not just a session |
| `POST /auth/2fa/recovery-codes` | Replaces the list; needs the password |

The first four are **public**, because they are reached by someone who cannot sign in — that
is the point of them. Each carries its own single-use, expiring token and its own rate limit.

`verify-email` and `reset-password` are **POST, not GET**, even though both are reached from a
link. The email links to the SPA, which then calls the API. A GET endpoint would be fetched by
the link scanners some mail providers run, spending the token before the person ever clicked.

## Two-step login

With 2FA on, `POST /auth/login` stops returning a session:

```jsonc
// 2FA off
{ "accessToken": "…", "expiresInSeconds": 900, "user": { … } }
// 2FA on — no token, and no Set-Cookie
{ "challenge": "…", "twoFactorMethod": "email" }
```

Three properties hold this together, and each fails silently if broken:

- **The challenge carries nothing.** No access token, no refresh cookie. Someone holding only
  the password gets a string that cannot read or write any study data.
- **Resolved without being spent.** `UserTokenService.resolve` finds the account without
  setting `used_at`, so one mistyped digit costs an attempt rather than sending the person back
  to the password screen. Only a correct code redeems it.
- **Rate limited per challenge, not only per IP.** Six digits is a million values. An attacker
  who already has the password can rotate source addresses, so a per-IP bucket alone would not
  stop them. `LoginRateLimiter.TWO_FACTOR_PER_CHALLENGE` is 5.

Recovery codes are accepted wherever a code is, in the same field. The server can tell them
apart by shape, and asking someone mid-lockout to first classify what they are holding is
friction that buys nothing.

**Verification gates password reset and nothing else.** An unverified address gets no reset
link — otherwise registering someone else's address would be a way to take over a mailbox you
never proved you owned. It must never gate *studying*: the domain quizzes and mock exam work
signed out, so gating anything signed in would be a strict downgrade for having made an
account.

## Auth design

Own implementation, not Cognito.

- Email + password, **BCrypt strength 12**. Emails stored lowercased; uniqueness enforced by
  a `lower(email)` unique index.
- Short-lived access JWT (~15 min).
- **Rotating** refresh token in an httpOnly `SameSite=Strict` cookie. Only the SHA-256 of a
  token is stored, so a database leak hands out no live sessions.
- Rate limiting on login, register, refresh, password reset and **per 2FA challenge**.
  In-memory and per-instance, deliberately — see [decisions.md](decisions.md).
- **Per-IP limits are best-effort; the ones that protect people are per account or global.**
  The IP comes from `X-Forwarded-For`, which is only as trustworthy as the proxies in front of
  the app, and App Runner can be called directly. So: logins are also capped per email; reset
  emails per account (`FORGOT_PER_ACCOUNT`); registrations and all auth mail globally
  (`REGISTER_GLOBAL`, `MAIL_GLOBAL`). The mail cap **skips** rather than refuses, and is checked
  *before* a token is issued, so it never surfaces as an error and never invalidates a link
  already in someone's inbox. Its job is keeping SES from suspending the account for abuse.
- Optional 2FA: emailed six-digit codes, or RFC 6238 TOTP written against the JDK. Ten
  single-use recovery codes, hashed, shown once. **Every TOTP code works once**:
  `users.totp_last_step` (V3) records the step spent, and anything at or below it is refused.
  Without it a code stayed valid for its whole ~90-second window after being used.
- **Known gap:** TOTP secrets are stored in plain text, and recovery codes as unsalted SHA-256.
  Both only matter after a database breach (RDS is private and encrypted at rest), and they have
  to be fixed together: with the TOTP secret in hand an attacker can simply generate codes, so
  peppering the recovery codes alone would add nothing. The fix is to encrypt the secret and
  HMAC the codes under one key held in SSM.
- Mail over SES SMTP. **Sending never fails the request that triggered it** — `Mailer` logs and
  swallows, because a registration that 500s over an SMTP hiccup is worse than a late email.
  With `MAIL_HOST` unset it logs what it would have sent, so the whole flow is walkable from a
  clean checkout with no SES account and no network.
- No JWT library. The Boot BOM's `spring-boot-starter-security-oauth2-resource-server`
  provides `JwtEncoder`/`JwtDecoder` and bearer authentication, so there is no hand-written
  filter and no version to track.

**Login cannot be used to enumerate users; register can.** Login returns a byte-identical 401
for an unknown email and a wrong password, *and* runs a BCrypt verify against a dummy hash
when the account is absent — without that, an unknown email returns in ~1ms against ~250ms for
a real one, and the timing is the oracle the shared message just closed. `AuthApiTests`
asserts the two response bodies are identical.

Register returns **409** on a duplicate, which does confirm an address is taken. That narrows
the rule knowingly: the only non-enumerable alternative is to accept the registration and
resolve it by email, and there is no mailer here, so that path ends with someone who believes
they created an account they can never sign into. Recorded in [decisions.md](decisions.md).

## Testing

New back-end code is expected to come with tests.

- **Unit** — JUnit 5 + AssertJ for grading, the weighted draw, streak calculation.
- **Integration** — `@SpringBootTest` + **Testcontainers** against a real Postgres, pinned
  to `postgres:17-alpine` to match the compose files. Never `latest` in a test — that makes
  the suite's result depend on when it was run.
- **Security** — expired tokens, refresh rotation and reuse detection, and that one user
  cannot reach another's attempts.
- **Integrity** — every question has a valid objective and every wrong choice has a
  rationale.

`SchemaMigrationTests` is the pattern to follow: it asserts the tables exist, that Flyway
recorded the baseline, and that the constraints actually **reject** bad data (two correct
choices, a score of 101, a duplicate email differing only in case) — not merely that the
tables are there.

`ContentSeedTests` does the same for content: exact counts, every question with a valid
objective and exactly one correct choice, every wrong choice carrying a rationale, and the
147 misfiled questions still recorded as misfiled. Those counts are deliberately **exact** —
if you add questions, update them in the same commit. A drifting "at least N" assertion
stops meaning anything.

> Note: `SchemaMigrationTests` uses objective `'9.9'` as a fixture rather than a real code,
> because the seed now populates every objective in the official outline (1.1–5.6).

Tests need a running Docker daemon. `./verify.sh` reports them as **SKIPPED**, not passed,
when there isn't one.
