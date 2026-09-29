# scripts — helper scripts

This folder holds small programs for setting up a computer, publishing the API and the AWS
setup, and checking that the question bank and docs are up to date. Run them from the
repository root.

## The scripts

| Script | When to use it | What it does |
|---|---|---|
| `./scripts/doctor.sh` | After cloning the project or switching computers | Checks that Node, Java and Docker are ready, installs the website's packages, creates `secapp/.env.local`, and reports anything missing with the fix |
| `./scripts/deploy.sh` | To publish the API or change the AWS setup | Builds the API image and uploads it, applies the Terraform in `infra/`, updates App Runner, and starts an Amplify build |
| `node scripts/generate-seed.mjs` | After editing questions | Turns the website's question bank into the SQL file the database loads (`R__seed_content.sql`) |
| `node scripts/check-doc-links.mjs` | Run automatically by `./verify.sh` and CI | Fails if a doc or README names a file that no longer exists |

## Notes

**`deploy.sh` needs Docker and AWS credentials** (`aws configure`). Terraform does not need to
be installed; the script runs it through Docker if it is missing. It does not publish the
website, which ships when changes are pushed to `main`. When a change affects both the website
and the API, run `deploy.sh` before merging.

**Keep the seed file current.** `node scripts/generate-seed.mjs --check` compares the seed file
with the question bank without changing anything. `./verify.sh` and CI both run it, so a
question edited without regenerating the seed fails the check.

**`./verify.sh`**, in the repository root, runs every check at once and prints PASS, FAIL or
SKIP for each.

Step-by-step instructions for these tasks are in
[docs/guide/everyday-tasks.md](../docs/guide/everyday-tasks.md). Deployment details are in
[docs/devops.md](../docs/devops.md).
