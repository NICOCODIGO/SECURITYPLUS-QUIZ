# The big picture

## Two halves

The project is two programs that talk to each other:

- **The front end** (`secapp/`) — the website itself: every page, button and quiz. It is
  React, and it runs **in the visitor's browser**.
- **The back end, or API** (`server/`) — a Java program (Spring Boot) that runs **on a server**.
  It keeps the things the browser cannot be trusted with or cannot keep on its own: accounts,
  passwords, quiz history, email.

The front end asks the API for things over HTTP — "sign me in", "save this quiz" — at addresses
that start with `/api/…`. Everything else the front end does by itself.

## What happens when someone opens certucation.click

```
visitor's browser
      │  https://certucation.click
      ▼
Route 53 (DNS) ──► "that name lives at Amplify"
      │
      ▼
AWS Amplify ─────┬── /           → the website files (HTML, JavaScript, CSS, images)
                 │
                 └── /api/...    → passed straight through (a "proxy") to ▼
                                                                        │
                                       App Runner — runs the Java API in a container
                                         │                │                │
                                         ▼                ▼                ▼
                                   RDS PostgreSQL     SES (email)     SSM (secrets:
                                   accounts, quiz     verification,   database password,
                                   history, the       reset, 2FA      signing key)
                                   question bank      codes
```

The database sits in a **private network** on AWS. It cannot be reached from the internet at
all — only the API can talk to it. That is why there is no "dashboard" for it; see
[Where the data lives](where-the-data-lives.md). (App Runner itself does have an address of its
own. Visitors never use it, and the limits that protect accounts are per account, so they hold
whichever address a request arrives through.)

**Why the API hides behind the website's own address.** Signing in sets a cookie that browsers
only send back to the *same site* that set it (`SameSite=Strict`). If the API had its own
address, the browser would never send the cookie there, and everyone would be signed out after
15 minutes. So Amplify serves the pages *and* quietly forwards `/api/...` to App Runner — to the
browser it is all certucation.click.

## The life of two requests

**Opening a quiz.** The browser downloads the website from Amplify, then asks
`/api/v1/questions` for the question bank. If the API is down or not configured, the website
falls back to a copy of the questions built into it, so studying never breaks. The quiz is
graded **in the browser**, instantly. If you are signed in, the finished result is sent to
`/api/v1/me/attempts` and saved in the database; signed out, it is shown but not kept.

**Signing in.** The browser sends your email and password to `/api/v1/auth/login`. The API
compares the password against a scrambled version (a BCrypt hash) — it never stores the real
password. If it matches, the API sends back:

- a **short pass** (an "access token", valid 15 minutes) that the website keeps in memory and
  shows on every request, and
- a **long pass** (a "refresh token", valid 30 days) in a cookie the website's own code cannot
  even read.

When the short pass runs out, the website quietly trades the long pass for a new short one. Close
the tab and come back tomorrow, and the long pass signs you straight back in.

## What runs where

| | On your computer (developing) | Live (certucation.click) |
|---|---|---|
| Website | `npm run dev` — Vite, at http://localhost:5173 | Amplify |
| API | `./gradlew bootRun` — at http://localhost:8080 | App Runner |
| Database | PostgreSQL in Docker (started by `bootRun`) | RDS PostgreSQL |
| Email | Not sent — printed in the API's output instead | SES |

Your computer and the live site never share data. A local account is not a live account, and
testing locally cannot touch real users.

## How a change goes live

- **Website changes: push to `main`.** Amplify notices, builds the site (after running the lint
  and question-bank checks — a failing build never replaces the live site) and publishes it in
  about three minutes.
- **API or infrastructure changes: `./scripts/deploy.sh`.** It builds the API into a Docker
  image, uploads it, tells App Runner to switch to it, and applies any infrastructure changes.
- **A change that needs both:** run `deploy.sh` first, then push. Otherwise the new website can
  call an API feature that isn't live yet.

Every push to `main`, and every pull request, also runs **CI** (GitHub Actions,
`.github/workflows/ci.yml`): the same checks as `./verify.sh`, on GitHub's computers, so a broken
commit shows a red ✗ on GitHub.

## So what is Docker actually for?

`doctor.sh` and Docker do different jobs. `doctor.sh` **installs** things — it stocks the
kitchen. Docker **runs** things — it is the oven.

Docker runs a program inside a sealed box (a *container*) that has everything it needs, so it
works the same on any computer. This project uses it for four jobs:

1. **A database on your laptop.** `./gradlew bootRun` starts PostgreSQL (and DynamoDB Local) in
   containers described by `server/compose.yaml`. When the health check said `UP`, that was the
   API talking to that Docker database. Without Docker, no local API.
2. **The back-end tests.** They start a real, throwaway PostgreSQL in Docker for each run
   (Testcontainers), so they test against the real thing rather than a fake.
3. **Packaging the API for AWS.** `server/Dockerfile` is the recipe for the image App Runner
   runs. `deploy.sh` builds it, and CI builds it on every push to prove it still builds.
4. **Terraform, if you don't have it.** `deploy.sh` runs Terraform inside Docker when it isn't
   installed.

And `docker compose up` in the repo root runs *everything* — database, API and website — in
containers, without installing Node or Java. Handy for a quick look; for day-to-day work, the
two-terminal setup in [Everyday tasks](everyday-tasks.md) is faster.

## Where everything is defined

The AWS side is not clicked together in the AWS console: it is written down as code in
`infra/` (Terraform), so it can be rebuilt, reviewed and changed like any other file. The one
exception is the Amplify app, which was created in the console once and then brought under
Terraform — [infra/README.md](../../infra/README.md) explains why.

**Going deeper:** [devops.md](../devops.md) (deploying, the domain, email, Docker),
[backend.md](../backend.md) (the API and sign-in), [architecture.md](../architecture.md)
(the roadmap).
