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

**Ops** — `/actuator/health` (public), `/actuator/metrics`, `/actuator/prometheus`. No
`/swagger-ui`: `springdoc` is not a dependency.

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

## Auth design

Own implementation, not Cognito.

- Email + password, **BCrypt strength 12**. Emails stored lowercased; uniqueness enforced by
  a `lower(email)` unique index.
- Short-lived access JWT (~15 min).
- **Rotating** refresh token in an httpOnly `SameSite=Strict` cookie. Only the SHA-256 of a
  token is stored, so a database leak hands out no live sessions.
- Rate limiting on login, register and refresh. In-memory and per-instance, deliberately —
  see [decisions.md](decisions.md).
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
