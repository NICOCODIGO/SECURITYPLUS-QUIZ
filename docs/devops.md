# DevOps

Containers, CI, environment, and the verification harness.

## Setting up another machine

Git carries the code. It deliberately does not carry installed tools or credentials:

| Need | For | Notes |
|---|---|---|
| Git, Docker Desktop (**running**) | everything | Docker provides Postgres, DynamoDB Local, and Terraform for deploys |
| Node 22+, Java 25 | `npm run dev`, `./gradlew bootRun`, `./verify.sh` | optional if you only use `docker compose up` from the root |
| `aws configure` | deploying | credentials live in `~/.aws`, never in the repo |

After cloning, run `./scripts/doctor.sh`. It checks the tools above, installs the front-end
packages, and creates `secapp/.env.local` (`VITE_API_URL=http://localhost:8080`) if it is missing —
git ignores that file, and without it the dev server silently runs with no API and no sign-in.
Don't copy `node_modules` between machines: some packages ship OS-specific binaries. Terraform
state is in S3 (see [infra/README.md](../infra/README.md)), so there is no state file to carry over.

Everything else git ignores rebuilds itself: `node_modules` (doctor.sh), Gradle's caches and
`server/build/` (the first `./gradlew` run), `infra/.terraform` (`deploy.sh` runs `init`).

**On a Mac:** the same tools, from Homebrew or their installers; the scripts run in the normal
Terminal. On Apple Silicon, `deploy.sh` builds the API image for `linux/amd64` on purpose —
App Runner runs x86, and an arm64 image would push fine and then fail to start. That build runs
under emulation, so it is slower there; that is expected.

### Switching machines

- **Leaving:** commit, then **Sync Changes** in VS Code's Source Control panel (push and pull
  in one click) — or **Push origin** in GitHub Desktop.
- **Arriving:** **Sync Changes** (or **Fetch/Pull origin** in GitHub Desktop), then
  `./scripts/doctor.sh` (Git Bash on Windows, Terminal on a Mac). It fails if GitHub has commits
  you haven't pulled or Docker isn't running, and reinstalls front-end packages when a pull
  changed `package-lock.json`.

**History was rewritten on 2026-09-27** to take personal email addresses out of commit metadata,
because the repository is public. A clone made before that date must **not** use Sync Changes or
GitHub Desktop's Pull: it would merge the old history, addresses included, straight back in.
Re-clone it, or run `git fetch` then `git reset --hard origin/<branch>` for each branch (after
saving any local work). Commit as `NICOCODIGO <153687367+NICOCODIGO@users.noreply.github.com>` —
set it per clone with `git config user.email`, or in GitHub Desktop under Settings → Git.

Not carried by git, on purpose: editor settings and extensions (VS Code's project settings
folder is gitignored; turn on VS Code **Settings Sync** instead), and Claude Code's memory, which is per machine. Project
knowledge lives in `CLAUDE.md` and `docs/` so it travels with the code.

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

`secapp/` has no production image, and needs none: Amplify builds `dist/` from `main` and serves
it (`infra/amplify.tf`).

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
| `CORS_ALLOWED_ORIGINS` | `http://localhost:5173` | the site origin, from the `site_url` output |
| `MAIL_HOST` | empty | `email-smtp.us-east-1.amazonaws.com` |
| `MAIL_PORT` | `587` | `587` (STARTTLS, which is what JavaMailSender expects) |
| `MAIL_USERNAME` | empty | SSM; the SES SMTP user, created in `mail.tf` |
| `MAIL_PASSWORD` | empty | SSM; **derived from** the IAM secret, not the secret itself |
| `MAIL_FROM` | `no-reply@localhost` | `noreply@certucation.click` (plain env var, not a secret) |
| `APP_BASE_URL` | `http://localhost:5173` | the site origin — email links point here, not at the API |
| `PORT` | `8080` | App Runner |
| `AUTH_JWT_SECRET` | empty → random per start | SSM; **must** be set, see below |
| `AUTH_COOKIE_SAME_SITE` | `Strict` | `Strict` once the API is same-domain |
| `AUTH_COOKIE_SECURE` | `false` | `true` |
| `AUTH_TRUST_FORWARDED_FOR` | `false` | `true`: App Runner's proxy is the socket peer for everyone |
| `AUTH_FORWARDED_FOR_HOPS` | `1` | `2` behind Amplify's `/api` proxy (observed, see `infra/api.tf`) |

Three of those have failure modes worth knowing, because none of them look like a bug:

- **`AUTH_JWT_SECRET` unset** makes the app generate a key at startup and log a WARN. Sessions
  then die on every restart and deploy — everyone silently signed out. Under 32 bytes fails
  startup deliberately, rather than signing tokens with a weak key.
- **`AUTH_FORWARDED_FOR_HOPS` wrong** breaks the per-IP limits in one of two silent ways.
  Proxies *append* to `X-Forwarded-For` (none of ours overwrite it), so the caller is the entry
  this many from the right and everything further left is whatever the caller sent. Too high
  reads a forged entry, so a script picks a fresh bucket per request; too low reads a proxy's
  address, so strangers share one. It changes whenever the chain in front of App Runner does:
  it was 1 straight through CloudFront and is 2 through Amplify's `/api` proxy. **Read it off,
  don't guess it:** set `LOGGING_LEVEL_COM_SECPLUS_AUTH=DEBUG` on App Runner (package level —
  Boot lowercases logging env vars, so a class name never matches), send a request through
  the site with `X-Forwarded-For: 6.6.6.6`, and `AuthController` logs the whole header and the
  entry it chose. The chosen one must be your own public IP (`curl checkip.amazonaws.com`),
  never `6.6.6.6`. Turn the logging off afterwards: it records addresses.
  Per-IP limits stay best-effort even when right, because App Runner can be called directly;
  that is why every limit protecting a person is also per account or global
  (`LoginRateLimiter`).
- **`AUTH_COOKIE_SAME_SITE=Strict` across two domains** means the refresh cookie is never sent,
  so refresh 401s forever and users are signed out every 15 minutes. Dev can't reveal this —
  `localhost:5173` and `localhost:8080` are same-site. See [decisions.md](decisions.md).
- **`MAIL_HOST` empty** is the local default and not a failure: `Mailer` logs the message it
  would have sent, tokens included, so the whole auth flow is walkable with no SES account and no
  network. It logs a WARN saying so. In production an empty host means every verification and
  reset email silently goes nowhere.
- **`APP_BASE_URL` pointing at the API** rather than the site produces emails whose links 404.
  Terraform sets both this and `CORS_ALLOWED_ORIGINS` from `local.site_url` (`infra/main.tf`),
  derived from the domain, so they cannot drift apart — and cannot fall back to a placeholder,
  which the old `-var site_url` could.

Locally, `spring-boot-docker-compose` overrides the datasource values with the real container
host and port, so the defaults above are only a fallback.

The front end reads one: **`VITE_API_URL`**, and it is baked in at **build** time, not read at
runtime. Leave it unset and the app falls back to the bundled question bank, so the domain
quizzes and mock exam still run — but nothing is recorded, because no API means no account (and
so Weakest Subject and Build Your Own stay locked). It does **not** fall back to
browser storage; that was removed deliberately. See [decisions.md](decisions.md).

Because the value is compiled into the bundle, changing it means **rebuilding the front end**, not
just updating a variable. It is set on the Amplify branch (`infra/amplify.tf`), and Amplify does
not rebuild when an environment variable changes — `deploy.sh` starts a build for that reason.

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

An inbound `X-Request-Id` is reused — so if a proxy in front ever sets one, a CloudWatch entry and
its access log line can be joined up — otherwise one is generated. It is always echoed back on the
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

## Domain, DNS and email

Live at **https://certucation.click**, served by Amplify, and that is the only address that serves
the site. `www.` and Amplify's own `main.<app-id>.amplifyapp.com` (the `amplify_branch_url`
output — every Amplify app has one and it cannot be removed) both 301 to it. That redirect is also
the quickest DNS-versus-Amplify check: if the amplifyapp address redirects but the domain fails,
the problem is DNS.

`certucation.click` was registered through Route 53, which creates the hosted zone itself. So
`infra/dns.tf` **reads** that zone with a `data` block. Creating one would make a second zone
with different nameservers, which the registrar does not delegate to, and which therefore
resolves nothing while looking entirely correct in the console.

### Everything is Terraform, including the SMTP credentials

Nothing here is clicked together. `infra/mail.tf` creates the IAM user and derives the SES SMTP
password from its access key — that derivation is an HMAC of the secret key, not the secret key
itself, which is why pasting the IAM secret into `MAIL_PASSWORD` fails with a 535.

**The API reaches SES through a VPC endpoint, not the internet.** App Runner's outbound traffic
all goes into the VPC (it needs that for RDS), and the VPC has no NAT. `infra/network.tf` adds an
SES SMTP interface endpoint with private DNS, so `MAIL_HOST` resolves to it unchanged. Remove it
and mail stops with nothing visibly failing: see [infra/README.md](../infra/README.md#cost).

Avoid the console route for this. It now leads into **Mail Manager**, whose wizard builds an
*inbound* ingress endpoint that bills by the hour, has nothing to do with sending, and issues
`inp-` prefixed credentials that do not work for SMTP auth.

### The records, and what each one is for

| Record | Purpose |
|---|---|
| `_amazonses` TXT | Domain ownership, which is what SES actually verifies |
| 3 × `_domainkey` CNAME | Easy DKIM. Without these, mail arrives unsigned and gets filtered |
| `mail.` MX + TXT | Custom MAIL FROM, so **SPF** aligns to our domain and not to `amazonses.com` |
| apex TXT (SPF), `_dmarc` TXT | Policy. `p=none` — publish, do not ask anyone to reject yet |
| 2 × validation CNAME | ACM DNS validation |
| apex A/AAAA alias | Point at Amplify's CloudFront. **Alias, not CNAME** — a zone apex cannot hold a CNAME |
| `www` CNAME | Same target. A CNAME because that is what Amplify writes for it itself |

The apex and `www` records live in `infra/amplify.tf`, beside the domain association they come
from; the rest are in `infra/dns.tf`. Amplify writes records into a zone in its own account the
moment the domain is associated, so the Terraform ones use `allow_overwrite` to adopt them — and
`www` has to be a CNAME, because a name holding a CNAME can hold nothing else.

AAAA is not optional padding: the distribution has IPv6 on, and an IPv6-only client with no AAAA
record simply cannot reach the site.

A **domain** identity, not an address one, for two reasons: verifying the domain authorises every
address on it, so `noreply@` needs no click-through of its own; and AWS only grants production
access on a verified domain.

### www redirects to the apex, and why that is a correctness fix

A rule in `infra/amplify.tf` (`https://www.certucation.click` → `https://certucation.click`,
301). Cookies are scoped **per host**, so if both names served the app, signing in on `www` and
later opening the apex would look like being randomly signed out — and because study data is keyed
by account, like the data had vanished.

Details that are load-bearing:

- **The source is a bare host.** Amplify stores a `https://www.certucation.click/<*>` rule but never
  matches it; the bare host is what it treats as a whole-domain redirect.
- **It keeps the path and the query string** (checked). Verification and reset links carry
  `?token=…`, and dropping it would turn a working link into an invalid-token page with nothing
  to debug from. Email links use `APP_BASE_URL`, the apex, so they never need the redirect anyway.
- It covers `www/api/*` too. A 301 makes the browser reissue the request, and a reissued POST
  drops its body — harmless here only because the app on `www` is redirected before it runs, so
  its API calls always come from the apex.
- **Rule changes take effect on Amplify's next deployment**, not on apply.

### Sequencing: why the first apply is narrowed with `-target`

Every wait in `dns.tf` polls **public DNS**, not AWS. While a registry is still delegating a new
domain, `aws_acm_certificate_validation` cannot succeed no matter how correct the records are —
it just sits there, and its default timeout is 75 minutes. Worse inside `deploy.sh`, which would
already have pushed an image before reaching it.

So: create the records first with one narrowed apply, confirm delegation, then apply the rest.

```bash
terraform -chdir=infra apply \
  -target=aws_ses_domain_identity.main -target=aws_ses_domain_dkim.main \
  -target=aws_route53_record.ses_verification -target=aws_route53_record.ses_dkim \
  -target=aws_ses_domain_mail_from.main -target=aws_route53_record.mail_from_mx \
  -target=aws_route53_record.mail_from_spf -target=aws_route53_record.spf \
  -target=aws_route53_record.dmarc \
  -target=aws_acm_certificate.site -target=aws_route53_record.cert_validation
```

`-target` is right here precisely because it is temporary — one command, once, rather than a
feature flag left in the code forever. This is a one-off for standing a domain up; it is not part
of a normal deploy.

The four checks that say delegation has landed:

```bash
aws route53domains list-operations --region us-east-1 \
  --query "Operations[?DomainName=='certucation.click'].[Type,Status]" --output text
nslookup certucation.click 8.8.8.8            # the zone nameservers, not NXDOMAIN
aws ses get-identity-verification-attributes --identities certucation.click --region us-east-1
aws acm list-certificates --region us-east-1
```

**A failure in any of these is propagation, not a broken config.** That distinction is the whole
reason the step exists: the two look identical from a terminal, and only one of them is worth
debugging.

### Changing the domain

`var.domain_name` is the single source. `www.`, `mail.`, the certificate SANs, the Amplify domain
association and `local.site_url` (so CORS, email links and `VITE_API_URL`) all derive from it. Two
things do not move automatically:

- **`var.mail_from`** is a full address, so it needs editing too. Never point it at a domain SES
  has not verified — sending then fails for every recipient, including the one verified address.
- **The ACM certificate must be in us-east-1**, because Amplify's CloudFront reads certificates
  only from there. `var.region` is already us-east-1, so `dns.tf` needs no aliased provider;
  changing `var.region` would require one.

Changing the domain also changes `VITE_API_URL`, which only takes effect on Amplify's next build.

### Still in the SES sandbox

Until production access is granted, SES delivers **only to verified addresses** —
one personal address, verified by hand in the SES console. Everything else is accepted and silently dropped. Request it from SES →
Account dashboard once the domain shows Verified; AWS gates the request on exactly that.

`Mailer` is built for this: it logs failures and never throws, so a send that the sandbox refuses
cannot fail the registration that triggered it.

## Deployment target

Live at **https://certucation.click** — see the section above for the domain, DNS and mail.

**Front end on Amplify, which builds and ships it on every push to `main`** — after its build runs
the lint baseline and the objective check, so a failing commit never replaces the live site. API
as Docker → ECR → App Runner, shipped by `./scripts/deploy.sh`. RDS `t4g.micro` on the 12-month
free tier. Secrets in SSM Parameter Store. Terraform in `infra/`. CloudWatch logs; no alarms yet.

**When a change touches both the front end and the API, run `deploy.sh` before merging to
`main`**, or Amplify ships a front end that calls endpoints the running API does not have yet.

Terraform state is in a private, encrypted, versioned S3 bucket that `scripts/deploy.sh` creates,
so any machine with AWS credentials can deploy. `deploy.sh` runs Terraform through Docker when it
isn't installed. Details — including how the Amplify app was created and imported — in
[infra/README.md](../infra/README.md).

**One host for the site and the API.** Amplify serves the pages and proxies `/api/*` to App Runner
with a 200 rewrite. Not a preference: the refresh cookie is `SameSite=Strict`, so an API on a
separate domain would never receive it and every session would die after 15 minutes. Local dev
cannot reveal this because `localhost:5173` and `localhost:8080` are the same site. The `www` and
amplifyapp.com redirects exist to keep it a *single* host.

The proxy must forward cookies — the app's cache config is `AMPLIFY_MANAGED`, "keep cookies in
cache key" — and API responses must never be cached, which rests on Spring Security's `no-store`
header on every response. Sign in and reload the page: still signed in means both hold.

(Until 2026-09-27 the front end was S3 + one CloudFront distribution with an `/api/*` behaviour.
It moved so that a push to `main` goes live without a script; see [decisions.md](decisions.md).)

No DynamoDB yet — nothing reads `app.dynamodb.endpoint` and there is no AWS SDK on the
classpath. It arrives with Phase 4.
