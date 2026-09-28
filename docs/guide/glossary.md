# Glossary

Plain meanings for the terms used in these guides and around the repo, grouped so related ideas
sit together.

## The basics

- **Front end** — the part that runs in the visitor's browser: pages, buttons, quizzes. Here,
  `secapp/`.
- **Back end / API** — a program on a server that the front end asks for things. Here,
  `server/`. *API* means "application programming interface": a set of addresses
  (**endpoints**, like `/api/v1/auth/login`) that each do one job.
- **Request / response** — the front end sends a request to an endpoint; the API sends back a
  response, usually as **JSON** (text-shaped data, like `{"score": 80}`).
- **Repository (repo)** — the project folder plus its whole history, kept by **git** and
  stored on GitHub. A **commit** is one saved change; **push** sends commits to GitHub;
  **`main`** is the branch the live website is built from.
- **CI** (continuous integration) — GitHub automatically building and testing every push to
  `main` and every pull request, and showing ✓ or ✗.
- **Environment variable** — a setting handed to a program from outside it, so the same code can
  behave differently on a laptop and on AWS. `VITE_API_URL` tells the website where the API is.

## Website tools

- **React** — the library the website is built with; pages are made of reusable
  **components**. Files end in `.jsx` (JavaScript with HTML-like tags).
- **Node** — runs JavaScript outside a browser; needed for the tools below.
- **npm** — installs packages (other people's code) listed in `package.json`, into
  `node_modules/`. `package-lock.json` pins the exact versions.
- **Vite** — runs the dev server (`npm run dev`) and builds the finished website
  (`npm run build`).
- **Tailwind CSS** — styling written as short class names, like `text-lg font-bold`.
- **shadcn/ui** — ready-made building blocks (buttons, cards, dialogs) copied into
  `secapp/src/components/ui/`.
- **Lint / ESLint** — automatic checks for likely mistakes in code. `npm run lint:check` fails
  only on *new* problems.

## API tools

- **Java / JDK** — the language the API is written in, and the kit that runs it (version 25).
- **Spring Boot** — the framework the API is built on: web requests, security, database access.
- **Gradle** — builds and runs the Java code, and downloads the libraries in `build.gradle`.
- **Gradle Wrapper** — the `gradlew` script. It downloads the exact Gradle version the project
  needs, so nobody installs Gradle by hand.
- **PostgreSQL (Postgres)** — the database: data in **tables** of **rows** and **columns**,
  queried with **SQL**.
- **Migration** — a numbered SQL file that changes the database's structure (new table, new
  column). Applied once, in order, never edited afterwards.
- **Flyway** — the tool that applies migrations when the API starts.
- **DynamoDB** — a different kind of database (key → item, no tables to join). Reserved for
  resumable mock exams; unused so far.
- **JUnit / Testcontainers** — how the API is tested: JUnit runs the tests; Testcontainers starts
  a real throwaway database in Docker for them.

## Docker

- **Docker** — runs programs inside sealed boxes that carry everything they need, so they behave
  the same on any computer.
- **Image** — the recipe-made package ("everything needed to run the API"). **Container** — one
  running copy of an image.
- **Dockerfile** — the recipe for building an image.
- **Compose** (`docker compose`) — starts several containers together from a file like
  `server/compose.yaml`.
- **Port** — a numbered door on a computer. The website is on 5173, the API on 8080, the local
  database on a random one.

## Signing in and security

- **Password hash (BCrypt)** — a one-way scramble of a password. The API stores only this, and
  checks a login by scrambling what was typed the same way and comparing.
- **Access token (JWT)** — the short pass (15 minutes) the website shows the API on every
  request. A *JWT* is a signed piece of text that can't be forged without the server's key.
- **Refresh token** — the long pass (30 days), kept in a cookie, traded for new access tokens.
- **Cookie** — a small value the browser stores and sends back automatically. **httpOnly** means
  the page's own JavaScript can't read it. **SameSite=Strict** means the browser only sends it to
  the site that set it — why the API has to live under certucation.click.
- **CORS** — the browser rule that stops one website quietly calling another's API. The API
  lists which sites may call it.
- **CSP** (Content Security Policy) — a header telling the browser which sources the page may
  load scripts, styles and images from. Blocks injected scripts.
- **Clickjacking** — another site loading yours invisibly in a frame to trick clicks. Blocked by
  the `X-Frame-Options: DENY` header.
- **Rate limit** — a cap on attempts in a time window (e.g. 5 wrong passwords per 15 minutes).
- **X-Forwarded-For** — a header where each proxy adds the address it received a request from.
  The API reads it to know the visitor's IP for rate limits — carefully, because visitors can
  write fake entries into it.
- **2FA / TOTP** — two-factor sign-in: after the password, a 6-digit code — from an email, or
  from an authenticator app (**TOTP**, time-based codes). **Recovery codes** are one-time backups
  for when the phone is lost.
- **Open redirect** — a link that sends people from a trusted site to an untrusted one.
  `secapp/src/auth/safeNext.js` prevents it on the sign-in page.

## AWS

- **AWS console** — the website for managing AWS. Everything here lives in the **us-east-1**
  (N. Virginia) region.
- **Amplify** — builds and hosts the website; rebuilds it on every push to `main`.
- **App Runner** — runs the API's Docker image and keeps it running.
- **ECR** — the storage App Runner pulls the API image from.
- **RDS** — AWS-run PostgreSQL: the live database.
- **SES** — sends email. In **sandbox** mode (where this account still is) it only delivers to
  verified addresses; **production access** lifts that.
- **Route 53** — the domain's **DNS**: the internet's phone book, turning certucation.click into
  the address of the server behind it.
- **ACM** — issues the HTTPS **certificate** (the padlock) for the domain.
- **CloudFront** — AWS's content delivery network; Amplify uses it under the hood to serve the
  site quickly worldwide.
- **VPC / private subnet** — a private network on AWS. The database sits in one with no internet
  address.
- **Security group** — a firewall around a resource: the database's only lets the API in.
- **VPC endpoint** — a private door from the VPC straight to an AWS service. The API reaches
  email (SES) through one, instead of through the internet.
- **NAT gateway** — what would give the private network general internet access. Deliberately
  not used (about $32/month, and nothing needs it).
- **SSM Parameter Store** — where secrets live (database password, signing key); the API reads
  them at start-up. They are never in the repo.
- **CloudWatch** — logs and metrics. The API's log lines land here.
- **IAM** — AWS's users, roles and permissions.
- **S3** — file storage. Holds Terraform's state.

## Terraform

- **Terraform** — describes the AWS setup as code in `infra/`. **`plan`** shows what would
  change; **`apply`** makes AWS match the code.
- **State** — Terraform's notes on what it has created, kept in an S3 bucket so every computer
  shares one copy.
- **Import** — telling Terraform about something that was created by hand, so it manages it
  from then on. The Amplify app was imported this way.
