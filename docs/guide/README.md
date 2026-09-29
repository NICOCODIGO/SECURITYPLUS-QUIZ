# Start here

Plain-English guides to how this project fits together. They are useful when returning after a
break, setting up a new computer, or checking what a file is for. No programming background is
assumed. When you need the exact technical detail, each guide links to the doc in `docs/` that
owns it.

Read them in this order the first time:

| Guide | Answers |
|---|---|
| [The big picture](big-picture.md) | What happens when someone opens certucation.click? What runs on AWS, what runs on my laptop, and what is Docker actually for? How does a change go live? |
| [Where the data lives](where-the-data-lives.md) | Where are the questions and correct answers? Where are accounts and quiz history? How do I look at that data? |
| [Every file, explained](files.md) | What is `verify.sh`? `gradlew`? `settings.gradle`? `components.json`? Every file and folder, one line each. |
| [Everyday tasks](everyday-tasks.md) | The commands for running it, checking it, shipping it, switching computers — and what to do when something fails. |
| [Glossary](glossary.md) | What do API, container, migration, JWT, CORS, App Runner, Terraform… mean? |

Each main folder also has its own README describing what it contains:
[secapp/](../../secapp/README.md) (the website), [server/](../../server/README.md) (the API),
[infra/](../../infra/README.md) (the AWS setup) and [scripts/](../../scripts/README.md)
(helper scripts).

The technical docs, for when you are changing something:

| Working on | Read |
|---|---|
| Anything visual or product-shaped | [decisions.md](../decisions.md) — what was built and deliberately removed |
| Orientation, roadmap | [architecture.md](../architecture.md) |
| Pages, routing, browser storage | [frontend.md](../frontend.md) |
| Styling and layout | [components.md](../components.md) |
| The API, auth, rate limits | [backend.md](../backend.md) |
| Tables and migrations | [database.md](../database.md) |
| Docker, CI, deploying, AWS | [devops.md](../devops.md) and [infra/README.md](../../infra/README.md) |
| The question bank | [content.md](../content.md) |
