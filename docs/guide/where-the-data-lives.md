# Where the data lives

There are two kinds of data here, and they live in different places for different reasons.

| Data | Written by | Lives in |
|---|---|---|
| The **question bank** — questions, choices, which one is correct, the explanations | You, in the code | The code, then copied into PostgreSQL |
| **Accounts and study history** — users, quiz results, flags, Question of the Day | The people using the site | PostgreSQL only |

## The question bank

The questions are written **in the code**, not typed into a database:

- `secapp/src/components/data/quizData.js` — all 444 questions, their choices, and which is
  correct.
- `secapp/src/components/data/rationales/` — why each *wrong* answer is wrong (1,332 of them).
- `secapp/src/components/data/examObjectives.js` and `securityDomains.js` — the SY0-701
  objectives and domains the questions are tagged with.

From there they travel two ways:

1. **Into the database.** `node scripts/generate-seed.mjs` turns those files into one big SQL
   file, `server/src/main/resources/db/migration/R__seed_content.sql`. When the API starts,
   **Flyway** (the migration tool) sees the file has changed and loads it into the `objectives`,
   `questions` and `choices` tables. Each choice row has `is_correct` and its `rationale`.
2. **Into the website itself.** The same files are built into the website, so if the API is down
   or not configured, every quiz still works from this built-in copy.

When both are available the website uses the API's copy. `./verify.sh` fails if you edit the
questions and forget to regenerate the SQL file, so the two cannot drift apart.

Editing a question's *wording* has a catch — it disconnects that question's history and
wrong-answer explanations. [content.md](../content.md) explains before you do it.

## Accounts and study history

All of it is in **PostgreSQL** — on AWS (RDS) for the live site, in Docker on your computer for
local development. One table at a time:

| Table | One row is… |
|---|---|
| `users` | An account: email, display name, when it was created and last signed in, whether the email is verified, and the 2FA settings. The password is stored only as a **BCrypt hash** — a one-way scramble, so nobody can read it back, even with full database access. |
| `attempts` | One finished quiz: its type, score, number of questions, how long it took, when. |
| `attempt_answers` | One question inside a quiz: which question, right or wrong. |
| `daily_answers` | One Question of the Day answer, per account per day (the streak comes from these). |
| `flagged_questions` | A question someone flagged to review later. |
| `refresh_tokens` | A signed-in device (the 30-day "long pass"). Stored as a hash. |
| `user_tokens` | A one-time email link or code — verify, reset, sign-in code. Stored as a hash, with an expiry. |
| `recovery_codes` | A 2FA backup code. Stored as a hash. |
| `custom_quiz_presets` | Nothing yet — the table exists, but nothing writes to it. |
| `flyway_schema_history` | Flyway's own record of which migrations have run. Don't edit it. |

The tables are created by the numbered files in `server/src/main/resources/db/migration/`
(`V1__init.sql`, `V2__account_security.sql`, …). They are never edited once applied — a
change is always a new file. [database.md](../database.md) has the full schema.

**Also:**

- **The browser** keeps a copy of your own history in local storage, labelled with your account,
  so pages load instantly. The database is the real copy. Signed out, nothing is kept at all.
- **DynamoDB** holds nothing yet. It is reserved for resuming an interrupted mock exam (phase 4).

## Looking at the data on your computer

The API has to have run at least once (`./gradlew bootRun`), since that is what creates the
database container. If it isn't running now, start just the database with
`docker start server-postgres-1`.

**From the terminal** — this opens a prompt connected to the local database:

```bash
docker exec -it server-postgres-1 psql -U secplus -d secplus
```

Then try:

```sql
\dt                                  -- list the tables
\d users                             -- the columns of one table

-- every account
select email, display_name, email_verified, created_at, last_login_at
  from users order by created_at;

-- how many quizzes each account has taken, and the average score
select u.email, count(a.id) as quizzes, round(avg(a.score)) as avg_score
  from users u left join attempts a on a.user_id = u.id
 group by u.email order by quizzes desc;

-- one question and its choices
select q.text, c.position, c.is_correct, c.text as choice
  from questions q join choices c on c.question_id = q.id
 where q.legacy_hash = (select legacy_hash from questions limit 1)
 order by c.position;
```

`\q` quits.

**In an app with tables and clicking** — TablePlus, DBeaver and Postico (Mac) are free or have
free tiers. Connect with:

| Setting | Value |
|---|---|
| Host | `localhost` |
| Port | run `docker port server-postgres-1 5432` — the number after the colon. It can change each time the database starts |
| User / password / database | `secplus` / `secplus` / `secplus` |

**Starting over.** Local data survives between runs — `bootRun` stops the database, it doesn't
delete it. To wipe it back to just the questions:

```bash
docker compose -f server/compose.yaml down -v
```

The next `./gradlew bootRun` creates a fresh database and reloads the question bank.

## Looking at the live site's data

**You can't, directly — on purpose.** The live database sits in a private network with no
internet address, and its firewall (an AWS *security group*) only lets the API in. There is no
password or console screen that opens it from outside. That is the main thing standing between
the internet and everyone's accounts.

**What you can see today**, in the AWS console:

- **CloudWatch Logs** → the log group starting `/aws/apprunner/secplus/…/application`: what the
  API is doing — errors, emails sent, rate limits hit.
- **App Runner** → the `secplus` service: request counts, response times, errors.
- **RDS** → the `secplus-db` database: health — CPU, storage, connections. Not the rows.

**If you want to see accounts later**, there are two sensible ways to open a window. Neither is
built yet; both are a real decision:

| Option | What it is | Trade-offs |
|---|---|---|
| An admin page | A page in the site, visible only to an account whose `role` is `ADMIN` (the column already exists; every account is `USER` today), showing accounts and totals. | The most convenient. It is a real feature that must never show one user's data to another — this project's first rule. Build it carefully, with tests. |
| On-demand SQL | A tiny temporary server inside the private network that you connect to through AWS (Session Manager), run your queries, then delete. | Full SQL, nothing added to the website. More AWS setup, and a small cost for as long as it exists. |

**Don't** make the database public to look at it, even briefly — that is exactly the door the
design keeps shut.
