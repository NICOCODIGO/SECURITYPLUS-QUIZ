# infra — the AWS setup

This folder describes the AWS services that run certucation.click: the website host, the API
server, the database, email and the domain. They are written as Terraform files, and running
`./scripts/deploy.sh` makes AWS match them. The website itself is not published from here:
pushing to `main` publishes it through Amplify.

Terms such as Amplify, App Runner, RDS and Terraform state are explained in the
[glossary](../docs/guide/glossary.md#aws).

## How changes are applied

`./scripts/deploy.sh`, run from the repository root, applies this Terraform. It also builds and
ships the API and asks Amplify for a new build. The front end is published separately, by
**pushing to `main`**; Amplify builds it.

Running `terraform -chdir=infra apply` directly is also safe and needs no `-var` flags. However,
Amplify applies rule and environment changes only on its next deployment. See the comment in
`amplify.tf`.

## What it creates

Visitors reach a single address. Amplify serves the website and forwards API requests
(`/api/*`) to the API on App Runner. The API stores data in a PostgreSQL database and sends email
through SES.

```
certucation.click ── Amplify ──┬── /*      → the React app (built from main)
    (www → apex)               └── /api/*  → 200 rewrite (a proxy) → App Runner (Spring Boot)
                                                    ├── VPC connector ── RDS Postgres 17
                                                    │                └── SES SMTP endpoint
                                                    └── SSM (secrets)

Route 53 ── ACM certificate (us-east-1) + SES domain identity, DKIM, custom MAIL FROM
```

| File | Holds |
|---|---|
| `main.tf` | Providers, the S3 state backend, shared locals (including `site_url`) |
| `network.tf` | VPC, subnets, the App Runner VPC connector, the SES SMTP endpoint |
| `database.tf` | RDS Postgres, its generated password, the SSM parameters |
| `api.tf` | ECR, the two App Runner IAM roles, the service itself |
| `amplify.tf` | The Amplify app, branch, rewrite rules, security headers, domain and its DNS records |
| `dns.tf` | The hosted zone lookup, the certificate, the SES identity and mail records |
| `mail.tf` | The SES SMTP user and its derived password |

**Setting up a new domain** is the one case where `terraform apply -target=...` is correct.
[docs/devops.md](../docs/devops.md) has the exact command. The resources in `dns.tf` that wait
for DNS check public DNS, so certificate validation cannot pass until the domain registry has
delegated the domain.

## Amplify

**A push to `main` publishes the front end**, after Amplify's build runs the lint baseline and
the objective check. The API stays on App Runner and ships with `deploy.sh`.

**When a change affects both the website and the API, run `deploy.sh` before merging.**
Otherwise Amplify publishes a front end that calls API endpoints the running API does not have
yet.

Things to know about Amplify:

- **Rule and environment changes take effect on the next deployment**, not when Terraform
  applies them. `deploy.sh` starts a deployment. After a direct `terraform apply`, start one
  with `aws amplify start-job --app-id <amplify_app_id> --branch-name main --job-type RELEASE`.
- **Host redirects must use a bare host.** `https://www.example.com` → `https://example.com`
  works and keeps the path and query. A source written as `https://www.example.com/<*>` is saved
  but never matches.
- **Custom headers must be nested under `applications[].appRoot`** in a monorepo app. Otherwise
  every build fails at the deploy step. They are written with `jsonencode` because Amplify stores
  them as JSON, and YAML would show as a change on every plan.
- **Amplify creates DNS records itself** when the Route 53 zone is in the same AWS account, and
  gives `www` a CNAME. The records in `amplify.tf` use `allow_overwrite` so Terraform can take
  them over.

**Recreating the Amplify app.** The app was created in the Amplify console (GitHub → this
repository → `main`, "my app is a monorepo" with root `secapp`, name `secplus`) and then
imported into Terraform, because Terraform can only create one with a GitHub token. To recreate
it:

1. Create it in the console the same way.
2. Run `terraform -chdir=infra import aws_amplify_app.web <app-id>`.
3. Run `terraform -chdir=infra import aws_amplify_branch.main <app-id>/main`.
4. Update `amplify_default_host` in `variables.tf`, then apply.

`deploy.sh` will not run until the import is done, so it cannot create a second app by mistake.

**Testing on another address.** To try a new front end address before moving the domain, add it
as an allowed origin by applying with `TF_VAR_extra_cors_origins=<address>`. Spring sees App
Runner's host but the site's `Origin` header, so it treats every write as a cross-origin (CORS)
request. See the comment in `api.tf`.

## Sign-in requirements

Three settings keep users signed in. If any of them changes, users are signed out, either
15 minutes after signing in or on every deploy.

**1. Serve the website and the API from one domain.** The refresh token is stored in a
`SameSite=Strict` cookie. If the API were served from a separate domain, browsers would never
send that cookie. Refreshing would always fail, and every user would be signed out 15 minutes
after signing in. Local development cannot show this problem, because `localhost:5173` and
`localhost:8080` count as the same site.

For this reason, `/api/*` is a **200 rewrite** in `amplify.tf`: a proxy, so the browser only
ever talks to the site's own domain. It must never be a redirect to App Runner's address.

`www` is attached only so that a rule can redirect it (301) to the main domain. Cookies are
scoped to a single host, so serving the site on two hostnames would mean a user signed in on one
appears signed out on the other. The `amplifyapp.com` address that every Amplify app has is
redirected in the same way.

**2. Keep both `/api/*` proxy settings.** Both are required:

- The app's cache setting is `AMPLIFY_MANAGED` ("Keep cookies in cache key" in the console).
  Without it, the refresh cookie may never reach App Runner, and every session ends after
  15 minutes.
- Nothing on Amplify prevents an API response from being cached. Spring Security's `no-store`
  header on every response does that, so it must never be turned off.

To check both, sign in and reload the page. If you are still signed in, both settings are
working.

**3. Keep `AUTH_JWT_SECRET` the same across deploys.** The key that signs sign-in tokens is
generated once and stored in SSM, with `ignore_changes` on its value so Terraform never replaces
it. Changing it signs every user out. `application-prod.properties` gives it no default, so if
the API cannot read it, the container fails to start instead of quietly creating a temporary
key.

## Cost

**App Runner is the main cost.** It bills for provisioned memory even while idle, so this setup
does not scale down to zero.

The RDS `db.t4g.micro` database is free-tier eligible for 12 months on a new AWS account.
Amplify hosting (about $0.01 per build minute; a build takes about 3 minutes) and ECR cost very
little at this site's traffic.

**There is deliberately no NAT gateway.** A NAT gateway costs about $32 a month and is usually
the largest avoidable charge. Because a VPC connector sends all of App Runner's outbound traffic
into the VPC, the API has no general internet access without one. It needs only two
destinations: RDS, which is inside the VPC, and SES for email, which it reaches through an
**SES SMTP interface endpoint** (about $7.30 a month, one availability zone) defined in
`network.tf`. Add a NAT gateway only if something needs wider internet access.

**The SES endpoint is required.** Without it, the email connection never opens. Because
`Mailer` logs failures and continues, sign-up and password reset appear to work while no email
is sent.

**Set up a billing alarm before the first apply.**

## State

Terraform keeps a record of everything it has created, called its state. It is stored in S3 at
`s3://secplus-tfstate-<account-id>/infra/terraform.tfstate`, so every computer that deploys
shares one copy.

**The state contains secrets in plain text**: the generated RDS password and the JWT signing
key. It must never be committed to git or copied elsewhere. The bucket is private, encrypted and
versioned. `.terraform.lock.hcl` is committed on purpose; it pins provider versions.

`deploy.sh` creates the bucket with the AWS CLI rather than Terraform, so the bucket itself
needs no state file. It passes the bucket name at `init`, because a backend block cannot look up
the account ID. Locking is built into S3 (`use_lockfile`, Terraform 1.10 or later), so two
computers cannot apply at the same time and no DynamoDB lock table is needed.

**Moving from local state.** If `infra/terraform.tfstate` exists when `deploy.sh` runs, the
script copies it to S3 once and renames the local file to `terraform.tfstate.migrated-backup`.
Delete that backup once `plan` shows no changes. If S3 already holds state, the script will not
overwrite it with a local copy, because the local copy is probably out of date.

To run Terraform by hand, first initialise it against the same bucket:

```bash
terraform -chdir=infra init -backend-config="bucket=secplus-tfstate-$(aws sts get-caller-identity --query Account --output text)"
```

**Terraform does not need to be installed.** If it is missing, `deploy.sh` runs the pinned
`hashicorp/terraform` image through Docker, so a new computer needs only Docker and
`aws configure`.

## Teardown

To delete everything this folder creates:

```bash
terraform -chdir=infra destroy
```

**The database is protected against accidental deletion.** `deletion_protection` and
`skip_final_snapshot = false` are set on purpose: `destroy` refuses to run until protection is
turned off, and takes a final snapshot when it does. The database holds users' study history,
and there is no other copy.
