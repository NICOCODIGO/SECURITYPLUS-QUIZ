# Every file, explained

One line per file or folder — what it is and whether you'll ever touch it. For how the pieces
work together, read [The big picture](big-picture.md) first.

## The top level

| | What it is |
|---|---|
| `secapp/` | **The website** (React). Everything a visitor sees. |
| `server/` | **The API** (Java, Spring Boot). Accounts, quiz history, email. |
| `infra/` | **The AWS setup, written as code** (Terraform). |
| `docs/` | Technical docs, plus these guides in `docs/guide/`. |
| `scripts/` | Helper scripts — setting up a machine, deploying, doc checks. |
| `verify.sh` | **Runs every check** and prints PASS / FAIL / SKIP for each: doc links, the question bank, lint, the website build, the API build and tests. Run it before pushing. |
| `docker-compose.yml` | Runs the *whole* app — database, API, website — in Docker with one `docker compose up`. |
| `README.md` | The front page on GitHub. |
| `CLAUDE.md` | Instructions and an index for Claude Code (and handy for humans): the rules that hold everywhere, and which doc to read for what. |
| `.gitignore` | What git deliberately doesn't keep — see [the table below](#what-git-ignores-and-how-each-comes-back). |
| `.gitattributes` | Line endings. Shell scripts must keep Unix line endings or they break on Mac/Linux; Windows `.bat` files keep Windows ones. |
| `.github/workflows/ci.yml` | **CI**: on every push to `main` and every pull request, GitHub builds and tests everything and shows ✓ or ✗. |
| `.claude/` | Claude Code setup: `.claude/agents/` (three specialist helpers), `.claude/hooks/lint-changed-file.mjs` (lints every JavaScript file Claude edits), `settings.json` (switches that hook on). |

## `scripts/`

| | What it is |
|---|---|
| `scripts/doctor.sh` | **Run after cloning or switching computers.** Checks Node, Java and Docker, installs the website's packages, creates `secapp/.env.local`, and says what's missing. |
| `scripts/deploy.sh` | **Ships the API and infrastructure** to AWS: builds the API image, uploads it, applies Terraform, rolls App Runner over, starts an Amplify build. |
| `scripts/generate-seed.mjs` | Turns the question bank into the SQL file the database loads. Run it after editing questions (`verify.sh` reminds you). |
| `scripts/check-doc-links.mjs` | Fails if any doc names a file that no longer exists, so docs can't silently rot. |
| `scripts/README.md` | What each script is for and when to run it. |

## `secapp/` — the website

| | What it is |
|---|---|
| `secapp/package.json` | The **shopping list**: every package the website uses, plus the commands (`npm run dev`, `build`, `lint:check`, `objectives`). |
| `secapp/package-lock.json` | The exact version of every package, so every computer installs the same thing. Never edit by hand; `npm install` updates it. |
| `secapp/index.html` | The one HTML page. React fills it in. |
| `secapp/vite.config.js` | Settings for Vite, the tool that runs the dev server and builds the site. |
| `secapp/jsconfig.json` | Tells your editor that `@/` in an import means `secapp/src/`. |
| `secapp/eslint.config.js` | The lint rules — automatic checks for likely mistakes. |
| `secapp/.lint-baseline.json` | The 6 known, old lint problems, so `npm run lint:check` only fails on *new* ones. |
| `secapp/tailwind.config.cjs`, `secapp/postcss.config.cjs` | Styling setup for Tailwind CSS. |
| `secapp/components.json` | Settings for shadcn/ui, the source of the basic building blocks in `secapp/src/components/ui/`. |
| `secapp/public/` | Files served exactly as they are — the logo. |
| `secapp/scripts/` | `lint-baseline.mjs` (behind `lint:check`) and `objective-coverage.mjs` (behind `objectives`: how many questions each exam objective has). |
| `secapp/Dockerfile`, `secapp/docker-compose.yml`, `secapp/.dockerignore` | Run the *dev server* in Docker. Not used for the live site — Amplify builds that. |
| `secapp/README.md` | Notes for working on the website alone. |

### `secapp/src/`

| | What it is |
|---|---|
| `main.jsx` | Starts React. |
| `App.jsx` | **The map of URLs to pages** — which page shows for `/lessons`, `/progress`, `/login`… |
| `Layout.jsx` | The navigation bar and frame around every page. |
| `index.css` | Site-wide styles. |
| `pages/` | One file per screen: `Home.jsx`, `Lessons.jsx` (the Practice page), `TakeQuiz.jsx`, `Progress.jsx`, `Account.jsx`, `Login.jsx`, `SignUp.jsx`… Oddity: `AdminContentManager.jsx` is the public **Study Resources** page, not an admin tool — see [decisions.md](../decisions.md). |
| `components/quiz/` | The quizzes: domain quizzes, the mock exam, Build Your Own, Weakest Subject, Question of the Day, results. `accountOnly.js` is the one list of what needs an account. |
| `components/progress/` | The panels on the Progress dashboard. |
| `components/data/` | **The question bank** (`quizData.js`, `components/data/rationales/`), and the code that loads it (`questionBank.js`) and saves your history (`persistence.js`, `source.js`, `quizHistoryData.js`). |
| `components/ui/` | Basic building blocks from shadcn/ui — buttons, cards, dialogs, tabs. |
| `components/auth/`, `components/domains/`, `components/lessons/`, `components/previews/` | The sign-in form, the per-domain breakdowns, lesson cards, and the signed-out previews. |
| `api/` | Talking to the API: `apiClient.js` sends every request; `authSession.js` holds the short-lived sign-in pass in memory. |
| `auth/` | Who is signed in (`AuthProvider.jsx`, `AuthContext.js`), the sign-in calls (`authApi.js`), and `safeNext.js` — which only lets "after sign-in, go to…" point at this site. |
| `lib/` | Small shared helpers. |
| `assets/` | Images. |

## `server/` — the API

| | What it is |
|---|---|
| `server/build.gradle` | The API's **shopping list and build settings**: Java 25, Spring Boot and its parts (web, security, database, Flyway, email, validation), the PostgreSQL driver, and the test libraries. |
| `server/settings.gradle` | One line: the project's name (`server`). Gradle reads it first. |
| `server/gradlew`, `server/gradlew.bat` | **The Gradle Wrapper** — you run these instead of installing Gradle. The first time, they download exactly the right Gradle version; after that they just run it. `gradlew` is for Mac/Linux/Git Bash, `gradlew.bat` for Windows. |
| `server/gradle/wrapper/gradle-wrapper.properties` | Which Gradle version the wrapper downloads (9.7.1) and from where. |
| `server/gradle/wrapper/gradle-wrapper.jar` | The tiny program that does that downloading. Committed on purpose, so a fresh clone can build with nothing but Java installed. |
| `server/compose.yaml` | The local PostgreSQL and DynamoDB that `./gradlew bootRun` starts in Docker. |
| `server/Dockerfile` | How the API is packaged into the image App Runner runs on AWS. |
| `server/src/main/java/com/secplus/` | The code, in four packages. `ServerApplication.java` starts it. **auth** — accounts, sign-in, tokens, 2FA, email, rate limits. **me** — your own study data. **questions** — serves the question bank. **common** — security rules, error responses, request ids. |
| `server/src/main/resources/application.properties` | Settings, with defaults that work on your laptop. On AWS, environment variables override them. |
| `server/src/main/resources/application-prod.properties` | Settings only the live API uses (JSON logs; refusing to start without the signing key). |
| `server/src/main/resources/db/migration/` | **Migrations** — numbered SQL files that build the database, one change each, never edited once applied. `R__seed_content.sql` is the question bank. |
| `server/src/test/java/com/secplus/` | The tests. `./gradlew test` runs them; they need Docker. |
| `server/README.md` | How to run the API, what each folder holds, and the rules for changing it. |

## `infra/` — the AWS setup

Terraform files. Each describes some AWS resources; `terraform apply` makes AWS match them.

| | What it describes |
|---|---|
| `infra/main.tf` | Settings shared by everything, and where Terraform keeps its notes (an S3 bucket). |
| `infra/variables.tf` | The adjustable values: the domain, sizes, the sender address. |
| `infra/outputs.tf` | Values it prints after applying, like the site URL. |
| `infra/amplify.tf` | **The website on Amplify**: the build steps, the `/api` proxy, redirects, security headers, the domain. |
| `infra/api.tf` | **The API on App Runner**, its image repository (ECR) and its settings. |
| `infra/database.tf` | The PostgreSQL database (RDS) and its generated password. |
| `infra/network.tf` | The private network the API and database live in, and the private route to email. |
| `infra/dns.tf` | The domain's DNS records, the HTTPS certificate, and email authentication (SES). |
| `infra/mail.tf` | The login the API uses to send email. |
| `infra/.terraform.lock.hcl` | Pins the Terraform plugin versions, like `package-lock.json` does. |
| `infra/README.md` | How to apply it, what it costs, and the settings that keep sign-in working. |

## What git ignores, and how each comes back

Git keeps *instructions* (the shopping lists above), not what they produce. On a new computer,
nothing needs copying:

| Ignored | What it is | Comes back from |
|---|---|---|
| `secapp/node_modules/` | The website's installed packages — thousands of files, some specific to each operating system | `./scripts/doctor.sh` (runs `npm install`) |
| `secapp/.env.local` | One line: where the local API is | `./scripts/doctor.sh` |
| `secapp/dist/` | A built copy of the website | `npm run build` — and you rarely need it; Amplify builds the live one |
| `server/.gradle/`, `server/build/` | Gradle's caches and build output | The first `./gradlew` run |
| `server/bin` | VS Code's own Java output | VS Code, automatically |
| `infra/.terraform` | Terraform's downloaded plugins | `./scripts/deploy.sh` (runs `terraform init`) |
| `.vscode`, `.idea` | Editor settings | Your editor; use VS Code Settings Sync to carry yours |
| `~/.aws` (outside the repo) | Your AWS login | `aws configure` — only needed to deploy |

Why ignore them at all: they are huge, some are different on Windows and Mac (copying them would
break things), some are secret, and some are rebuilt constantly and would cause conflicts.
