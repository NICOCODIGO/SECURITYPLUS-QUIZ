# DevOps

Containers, CI, environment, and the verification harness.

## Three compose files — know which is which

This is the most confusing thing in the repo, so it is first.

| File | Runs | Use when |
|---|---|---|
| `docker-compose.yml` (repo root) | Postgres + DynamoDB Local + **API** + **web** | "show me the whole thing working" |
| `server/compose.yaml` | Postgres + DynamoDB Local **only** | day-to-day API work — `./gradlew bootRun` starts it automatically |
| `secapp/docker-compose.yml` | Vite **dev server** alone | front-end-only container work |

`server/compose.yaml` is picked up automatically by `spring-boot-docker-compose`: running
`./gradlew bootRun` from `server/` starts both containers, wires the datasource to Postgres,
and stops them when the app stops. Prefer this over the root file for API work — the app runs
on the host where a debugger can reach it.

**Port collision:** the root compose file and `server/compose.yaml` both bind host port
**8000** for DynamoDB. You cannot run both at once.

Postgres gets a random host port in `server/compose.yaml` (Boot injects it), but DynamoDB is
fixed at `8000:8000` because the app reads `app.dynamodb.endpoint` as a plain property rather
than having it injected — Boot has no connection-details support for DynamoDB, hence the
`org.springframework.boot.ignore: 'true'` label on that service.

## Dockerfiles

| File | Builds |
|---|---|
| `server/Dockerfile` | **Production.** Multi-stage, `eclipse-temurin:25-jdk-alpine` → `25-jre-alpine`, non-root user, `-XX:MaxRAMPercentage=75` |
| `secapp/Dockerfile` | **Dev server.** Runs `npm run dev`, not a production build |

`secapp/` has no production image yet. Phase 6 serves the built `dist/` from S3 + CloudFront
instead, so one may never be needed.

The server image resolves dependencies in their own layer (keyed only on the build files) so
editing source doesn't re-download everything.

## Environment variables

Read by `server/src/main/resources/application.properties`. All have local defaults, so
`./gradlew bootRun` needs no setup beyond Docker.

| Variable | Default | Production source |
|---|---|---|
| `DB_URL` | `jdbc:postgresql://localhost:5432/secplus` | SSM Parameter Store |
| `DB_USER` | `secplus` | SSM |
| `DB_PASSWORD` | `secplus` | SSM |
| `DYNAMODB_ENDPOINT` | `http://localhost:8000` | empty = real AWS endpoint |
| `DYNAMODB_EXAM_SESSIONS_TABLE` | `exam_sessions` | Terraform output |
| `AWS_REGION` | `us-east-1` | task definition |
| `CORS_ALLOWED_ORIGINS` | `http://localhost:5173` | the CloudFront origin |
| `PORT` | `8080` | App Runner |
| `AUTH_JWT_SECRET` | empty → random per start | SSM; **must** be set, see below |
| `AUTH_COOKIE_SAME_SITE` | `Strict` | `Strict` once the API is same-domain |
| `AUTH_COOKIE_SECURE` | `false` | `true` |
| `AUTH_TRUST_FORWARDED_FOR` | `false` | `true` behind CloudFront |

Three of those have failure modes worth knowing, because none of them look like a bug:

- **`AUTH_JWT_SECRET` unset** makes the app generate a key at startup and log a WARN. Sessions
  then die on every restart and deploy — everyone silently signed out. Under 32 bytes fails
  startup deliberately, rather than signing tokens with a weak key.
- **`AUTH_TRUST_FORWARDED_FOR=true` on a directly reachable origin** is worse than no rate
  limiting: the header is caller-supplied, so anyone can pick a fresh bucket per request. Only
  turn it on where every request arrives through a proxy that overwrites it.
- **`AUTH_COOKIE_SAME_SITE=Strict` across two domains** means the refresh cookie is never sent,
  so refresh 401s forever and users are signed out every 15 minutes. Dev can't reveal this —
  `localhost:5173` and `localhost:8080` are same-site. See [decisions.md](decisions.md).

Locally, `spring-boot-docker-compose` overrides the datasource values with the real container
host and port, so the defaults above are only a fallback.

The front end reads one: **`VITE_API_URL`**. Leave it unset and the app falls back to browser
storage and the bundled question bank — that fallback is load-bearing, see
[frontend.md](frontend.md).

## Ports

| Port | Service |
|---|---|
| 5173 | Vite dev server |
| 8080 | Spring Boot API |
| 5432 | Postgres |
| 8000 | DynamoDB Local |

## Verification: `./verify.sh`

```bash
./verify.sh          # everything
./verify.sh --web    # front end only — no Docker needed
./verify.sh --api    # back end only
```

Runs the doc-reference check, the seed-freshness check, the baseline lint, the objective
coverage check, the production build and the back-end build. It **keeps going after a failure** so one pass shows every problem, then prints a
PASS/FAIL/SKIP summary and exits non-zero if anything failed.

**Back-end tests report as SKIPPED, not passed, when no Docker daemon is running.**
Testcontainers can't start without one, and a check that silently does nothing is worse than
no check. It falls back to `compileTestJava` so you still learn whether the code builds.

### The lint baseline

**Never judge lint by `npm run lint` alone.** It always exits non-zero because of 6
pre-existing problems, so a regression looks identical to the status quo.

Use **`npm run lint:check`**, which compares against `secapp/.lint-baseline.json` — a
fingerprint of `file:rule` per known problem, so swapping one error for a different one is
still caught. When you genuinely fix one of the 6, re-record with
`npm run lint:check -- --update`.

The 6 (5 errors, 1 warning):

| File | Rule |
|---|---|
| `secapp/src/pages/TakeQuiz.jsx` | `no-unused-vars` |
| `secapp/src/pages/TakeQuiz.jsx` | `react-hooks/exhaustive-deps` |
| `secapp/src/pages/LessonDetail.jsx` | `react-hooks/set-state-in-effect` |
| `secapp/vite.config.js` | `no-undef` (`__dirname`) |
| `secapp/src/components/ui/badge.jsx` | `react-refresh/only-export-components` |
| `secapp/src/components/ui/button.jsx` | `react-refresh/only-export-components` |

**Gotcha:** `eslint.config.js` sets `varsIgnorePattern: '^[A-Z_]'` to stop components used
only in JSX being flagged unused (there is no eslint react plugin here). That exemption
covers **variables, not destructured parameters** — so `({ icon: Icon }) => <Icon/>` is
flagged, while `const Icon = rule.icon` is not.

### The edit hook

`.claude/settings.json` → `.claude/hooks/lint-changed-file.mjs` is a `PostToolUse` hook that
lints every `.js`/`.jsx` file written under `secapp/` and exits 2 on anything new, so lint
regressions surface at the edit rather than at review.

It is baseline-aware and silent for non-JS files, files outside `secapp/`, deleted files, and
pre-existing problems. A hook that cries wolf gets disabled, so keep it that way.

**Node, not bash, and deliberately so.** The first version was a shell script that used `jq`
to read the hook payload. Windows ships neither, and the script swallowed the failure — a
missing `jq` produced an empty path, which produced a silent `exit 0`. The guard would have
stopped guarding without saying a word. Node is guaranteed present in a Node project and
behaves identically on macOS, Linux and Windows.

It is wired with the exec form (`"command": "node"`, `"args": [...]`) rather than a shell
string, so no shell has to expand the path.

### Doc links

`node scripts/check-doc-links.mjs` asserts every repo path referenced in `CLAUDE.md`,
`docs/*.md` and `.claude/agents/*.md` actually exists. Wired into `verify.sh` and CI.

### Seed freshness

`node scripts/generate-seed.mjs --check` fails when the question bank has been edited
without regenerating `R__seed_content.sql`. A stale seed is invisible otherwise — the app
runs fine, it just serves yesterday's content. Wired into `verify.sh` and CI.

## CI

`.github/workflows/ci.yml`, three jobs, with concurrency cancellation on repeat pushes:

- **api** — JDK 25, `./gradlew build` (Testcontainers against the runner's Docker daemon),
  uploads the test report.
- **web** — Node 22, `npm ci`, `npm run lint:check`, `npm run objectives`, the doc-link and
  seed-freshness checks, then `npm run build`.
- **image** — builds `server/Dockerfile` to prove the deployable artifact still builds.
  Pushes nothing.

## Known local-dev gotchas

- **DynamoDB Local runs with `-inMemory`.** Exam sessions vanish on container restart. Fine
  for development, confusing when testing Phase 4's resume feature.
- **`-sharedDb` is required.** Without it each fake access key gets its own isolated
  database and tables appear to vanish between runs.
- **Docker must be running** for `./gradlew test`. If Docker Desktop's socket answers but
  `_ping` doesn't, the VM is wedged — quit and relaunch the app.
- The front end has **no test framework**. Front-end verification is `./verify.sh --web`
  plus loading pages against `npm run dev`.

## Logging and the request id

Every request carries a correlation id, put into the MDC by
`server/src/main/java/com/secplus/common/RequestIdFilter.java` and rendered into every log line
by `logging.pattern.level`:

```
WARN [secplus-api,traceme123] ... RefreshTokenService : Refresh token reuse detected for user ...
```

An inbound `X-Request-Id` is reused — CloudFront sets one, so a CloudWatch entry and an access
log line can be joined up — otherwise one is generated. It is always echoed back on the
response, so someone reporting a problem can quote the id of the exact request that failed.
Inbound values are stripped to `[A-Za-z0-9._-]` and truncated: the header is caller-supplied,
and a newline in it would let anyone forge a log entry.

The filter runs at `HIGHEST_PRECEDENCE`, because a request rejected by a later filter — expired
token, refused preflight — is exactly the one worth correlating. It clears the MDC in a
`finally`, since servlet threads are pooled and a leftover id would stamp the next unrelated
request.

**Deployed, logs are JSON.** `application-prod.properties` sets
`logging.structured.format.console=ecs`, so CloudWatch Logs Insights can query fields instead of
regexing a message. Boot emits ECS natively — no encoder dependency, no `logback-spring.xml`.
Locally the format stays plain text, because JSON in a terminal is unreadable.

`application-prod.properties` also sets `app.auth.secret=${AUTH_JWT_SECRET}` with no default, so
a deployed container **fails to start** rather than generating a throwaway key and signing every
user out on each deploy.

## Deployment target (Phase 6, in progress)

Front end to S3 + CloudFront. API as Docker → ECR → App Runner. RDS `t4g.micro` on the
12-month free tier. Secrets in SSM Parameter Store. Terraform in `infra/`. CloudWatch logs plus
a couple of alarms.

**One CloudFront distribution, two origins** — default to S3, `/api/*` to App Runner. Not a
preference: the refresh cookie is `SameSite=Strict`, so an API on a separate domain would never
receive it and every session would die after 15 minutes. Local dev cannot reveal this because
`localhost:5173` and `localhost:8080` are the same site.

The `/api/*` behaviour must disable caching and forward all headers, cookies and query strings.
CloudFront strips `Authorization` and `Cookie` by default, and a cached `/auth/me` would serve
one account's details to another.

No DynamoDB yet — nothing reads `app.dynamodb.endpoint` and there is no AWS SDK on the
classpath. It arrives with Phase 4.
