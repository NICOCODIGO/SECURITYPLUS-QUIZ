# server — the API

This folder is the API: the program the website talks to for accounts, sign-in, saved study
history and email. It also serves the question bank. It is built with Java 25 and Spring Boot 4.1,
and stores its data in a PostgreSQL database.

The website works without the API; it only needs it for accounts and saved results. The website
is in [`../secapp`](../secapp), and the project overview is in the [root README](../README.md).
Terms such as Spring Boot, Gradle, migration and Testcontainers are explained in the
[glossary](../docs/guide/glossary.md#api-tools).

## Running it

You need **Java 25** and **Docker**. Gradle does not need to be installed: the `gradlew` script
(the Gradle Wrapper) downloads the correct version the first time it runs.

Run these from this folder:

```bash
./gradlew bootRun   # starts the API on http://localhost:8080
./gradlew test      # runs the tests (Docker must be running)
```

**`bootRun` starts its own database.** It reads `compose.yaml` and starts PostgreSQL and
DynamoDB Local in Docker, so there is nothing else to set up. On Windows, use `gradlew.bat`.

To point the website at this API, set `VITE_API_URL=http://localhost:8080`.
`./scripts/doctor.sh` creates `secapp/.env.local` with that value.

## What's inside

| Path | What it is |
|---|---|
| `src/main/java/com/secplus/auth/` | Accounts: sign-up, sign-in, tokens, two-factor sign-in (2FA), email, rate limits |
| `src/main/java/com/secplus/me/` | The signed-in user's own study data |
| `src/main/java/com/secplus/questions/` | Serves the question bank |
| `src/main/java/com/secplus/common/` | Security rules, error responses, request IDs |
| `src/main/resources/application.properties` | Settings, with defaults that work on a laptop. On AWS, environment variables override them |
| `src/main/resources/application-prod.properties` | Settings used only by the live API, such as JSON logs and refusing to start without the signing key |
| `src/main/resources/db/migration/` | **Migrations**: numbered SQL files that build the database, one change each |
| `src/test/java/com/secplus/` | The tests. They run against a real PostgreSQL database in Docker |
| `compose.yaml` | The local PostgreSQL and DynamoDB that `bootRun` starts |
| `Dockerfile` | How the API is packaged into the image that runs on AWS App Runner |
| `build.gradle` | The API's dependencies and build settings |

## Endpoints

All endpoints are under `/api/v1`.

| Path | Access | Purpose |
|---|---|---|
| `/questions`, `/objectives`, `/domains` | Public | The question bank, the 28 exam objectives, and per-domain counts |
| `/auth/*` | Public, except account settings | Sign-up, sign-in, sign-out, email verification, password reset and 2FA |
| `/me/*` | Signed in | The user's own quiz attempts, flagged questions and Question of the Day results |

Any endpoint not listed as public requires sign-in, and the `/me/*` endpoints only read or write
the signed-in user's own data. The full reference, including request parameters and error
responses, is in [docs/backend.md](../docs/backend.md).

## Rules

- **Flyway owns the database structure.** To change it, add a new `V<n>__*.sql` file in
  `src/main/resources/db/migration/`. Never edit a migration that has already been applied.
- **Never edit `R__seed_content.sql` by hand.** It is the question bank, generated from the
  website's copy by `node scripts/generate-seed.mjs` (run from the repository root).
- **The API is not published by pushing to `main`.** It ships with `./scripts/deploy.sh`. When a
  change affects both the website and the API, run `deploy.sh` before merging.

## Further reading

- [docs/backend.md](../docs/backend.md): endpoints, authentication and rate limits
- [docs/database.md](../docs/database.md): tables, migrations and DynamoDB
- [docs/devops.md](../docs/devops.md): Docker, environment variables and deploying
- [infra/README.md](../infra/README.md): the AWS services the API runs on
