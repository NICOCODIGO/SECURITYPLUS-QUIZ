# Everyday tasks

The commands you actually use, and what to do when one fails. Run them in a terminal from the
project folder (the one containing `README.md`) unless a step says otherwise. On Windows, use
**Git Bash**; on a Mac, **Terminal**.

## Set up a computer

1. Install **Git** (or GitHub Desktop), **Node 22+**, **JDK 25** (Temurin), and **Docker
   Desktop** — and start Docker.
2. Clone the repository.
3. Run:
   ```bash
   ./scripts/doctor.sh
   ```
   It installs the website's packages, creates `secapp/.env.local`, and tells you exactly what
   is still missing. When it says **Ready to work.**, you are.

## Run it on your computer

Two terminal tabs:

```bash
# Tab 1 — the API (and, automatically, its database in Docker)
cd server
./gradlew bootRun
```

It's ready when you see `Started ServerApplication`. The progress bar sitting at
`80% EXECUTING` forever is **normal** — the server is running, and a running server never
"finishes".

```bash
# Tab 2 — the website
cd secapp
npm run dev
```

Open **http://localhost:5173**. Changes to the website appear as you save.

**To stop:** click into each tab and press **Ctrl+C**.

Locally, emails are not sent — they are printed in Tab 1, so copy verification links from there.
Your local accounts are separate from the live site's.

**Other ways to run it:**

- **Website only, no Docker:** just Tab 2. Quizzes work from the built-in question bank; signing
  in won't, because there is no API.
- **Everything in Docker:** `docker compose up` from the project folder. Slower to change,
  nothing to install but Docker.

## Check your work

```bash
./verify.sh          # everything — needs Docker for the API tests
./verify.sh --web    # the website only, no Docker needed
```

It prints PASS / FAIL / SKIP for each check. Run it before pushing — GitHub runs the same checks
(CI) and shows a red ✗ if one fails.

## Look at the local data

See [Where the data lives](where-the-data-lives.md#looking-at-the-data-on-your-computer).

## Ship a change

**Website:** commit and push to `main` — in GitHub Desktop, *Commit to main*, then *Push origin*.
Amplify builds and publishes it in about three minutes. To watch: AWS console → Amplify →
`secplus` → `main`.

**API or AWS setup:** once per computer, run `aws configure` (with an AWS access key). Then:

```bash
./scripts/deploy.sh
```

It takes about 10–15 minutes and says **Deployed and live** when done. Docker must be running.

**Both at once:** run `deploy.sh` first, *then* push the website, so the site never calls an API
feature that isn't live yet.

## Change the questions

1. Edit `secapp/src/components/data/quizData.js` (read [content.md](../content.md) first —
   rewording a question has side effects).
2. Regenerate the database copy: `node scripts/generate-seed.mjs`
3. Check coverage: `cd secapp && npm run objectives`
4. `./verify.sh`, then commit and push.

## Switch computers

- **Leaving:** commit and push.
- **Arriving:** Fetch / Pull (GitHub Desktop) or Sync Changes (VS Code), then
  `./scripts/doctor.sh` — it catches anything that changed, like new packages.

## When something fails

| You see | Why | Fix |
|---|---|---|
| `Docker installed but not running`, or `bootRun` errors about Docker | Docker Desktop isn't started | Open Docker Desktop, wait for it to say it's running, try again |
| `bootRun` fails: port `8000` already in use | Another copy of the local database is running — usually `docker compose up` from the project folder | `docker compose down` in the project folder, then `bootRun` again |
| `permission denied` running a script | The file isn't marked runnable on this computer | `bash scripts/doctor.sh` (any script works this way), or pull the latest — the repo's scripts are marked runnable |
| The site loads, but signing in says it can't reach the server | The API isn't running, or `secapp/.env.local` is missing | Start Tab 1; run `./scripts/doctor.sh`; then restart `npm run dev`, which only reads that file when it starts |
| `./gradlew` can't find Java 25 | No JDK 25 installed | Install Temurin 25, open a new terminal |
| Stuck at `80% EXECUTING` | Nothing's wrong — the API is running | Check it: `curl http://localhost:8080/actuator/health` should say `UP` |
| Red ✗ on GitHub | A CI check failed | GitHub → Actions → the failed run → the failed step. Reproduce with `./verify.sh` |
| An Amplify build failed | Usually lint or the question check | AWS console → Amplify → `secplus` → `main` → the failed build's log. Reproduce with `./verify.sh --web`. The live site keeps the last good build meanwhile |
| `deploy.sh` stops with a message | It says why — most often no AWS login (`aws configure`), Docker not running (it fails at "Building and pushing the API image"), or App Runner still busy with a previous deploy | Do what it says and run it again — it's safe to rerun |

Still stuck? The technical detail is in [devops.md](../devops.md).
