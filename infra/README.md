# infra

Terraform for the deployed stack. Applied with `./scripts/deploy.sh` from the repo root, which
also builds and ships the API and asks Amplify for a build. The front end itself ships by
**pushing to `main`**: Amplify builds it.

A bare `terraform -chdir=infra apply` is safe (no `-var` needed), but Amplify only picks up rule
and environment changes on its next deployment — see the comment in `amplify.tf`.

## What it creates

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

Standing up a **new** domain is the one case where `terraform apply -target=...` is correct, and
[docs/devops.md](../docs/devops.md) has the exact command. Everything in `dns.tf` that waits polls
public DNS, so certificate validation cannot pass until the registry has delegated the domain.

## Amplify

The front end is on Amplify: **a push to `main` goes live**, after Amplify's build runs the lint
baseline and objective check. The API stays on App Runner and ships with `deploy.sh`. **When a
change touches both, run `deploy.sh` before merging**, or Amplify ships a front end that calls
endpoints the running API does not have yet.

Four things about it that are not obvious, and each was learned the hard way:

- **Rule and environment changes take effect on the next deployment**, not on apply. `deploy.sh`
  starts one; after a bare `terraform apply`, run
  `aws amplify start-job --app-id <amplify_app_id> --branch-name main --job-type RELEASE`.
- **Host redirects take a bare host.** `https://www.example.com` → `https://example.com` works and
  keeps the path and query; a `https://www.example.com/<*>` source is stored but never matches.
- **Custom headers must be nested under `applications[].appRoot`** in a monorepo app, or every
  build fails at the deploy step. And they are written with `jsonencode`, because Amplify stores
  them as JSON and YAML shows as a change on every plan.
- **Amplify writes DNS records itself** when the Route 53 zone is in the same account, and gives
  `www` a CNAME. The records in `amplify.tf` use `allow_overwrite` to adopt them.

**Recreating the app.** It was made in the Amplify console (GitHub → this repo → `main`, "my app
is a monorepo" with root `secapp`, name `secplus`) and then imported, because Terraform can only
create one with a GitHub token. To do that again: create it the same way, then
`terraform -chdir=infra import aws_amplify_app.web <app-id>` and
`terraform -chdir=infra import aws_amplify_branch.main <app-id>/main`, update
`amplify_default_host` in `variables.tf`, and apply. `deploy.sh` refuses to run until the import
is done, rather than creating a second app.

To test a new front door on another address before moving the domain, that address has to be an
allowed origin: apply with `TF_VAR_extra_cors_origins=<address>`. Spring sees App Runner's host but
the site's `Origin`, so it treats every write as CORS (see the comment in `api.tf`).

## The three things that will bite you

**One domain, not two.** The refresh token is a `SameSite=Strict` cookie. Serve the API from its
own domain and browsers will never send it — refresh fails forever and every user is signed out
15 minutes after signing in. Local development cannot reveal this, because `localhost:5173` and
`localhost:8080` are the same site. That is why `/api/*` is a **200 rewrite** in `amplify.tf` — a
proxy, so the browser only ever talks to the site's own domain — and never a redirect to App
Runner's address.

`www` is attached only so a rule can 301 it to the apex — cookies are scoped per host, so two
serving hostnames would mean signing in on one and appearing signed out on the other. The
`amplifyapp.com` address every Amplify app has is redirected the same way.

**The `/api/*` proxy's two settings are load-bearing.** The app's cache config is
`AMPLIFY_MANAGED` ("Keep cookies in cache key" in the console): without it the refresh cookie may
never reach App Runner, and every session ends at the 15-minute mark. And nothing on Amplify stops
an API response being cached — that is Spring Security's `no-store` on every response, so never
turn it off. Both are checked by signing in and reloading: still signed in means both work.

**`AUTH_JWT_SECRET` must survive deploys.** It is generated once and held in SSM with
`ignore_changes` on its value. Rotating it signs every user out. `application-prod.properties`
gives it no default, so a container that cannot read it fails to start rather than quietly
minting a throwaway key.

## Cost

RDS `db.t4g.micro` is free-tier eligible for 12 months on a new account. Amplify hosting (about
$0.01 per build minute, a build takes about 3) and ECR are pennies at portfolio traffic. **App
Runner is the real cost** — it bills for provisioned memory even while idle, so this is not a
scale-to-zero stack.

There is deliberately **no NAT gateway** (~$32/month, usually the largest avoidable line item).
A VPC connector sends all of App Runner's outbound traffic into the VPC, so without a NAT the app
has no internet. It needs exactly two destinations: RDS, which is inside the VPC, and SES for
mail, which is reached through an **SES SMTP interface endpoint** (~$7.30/month, one AZ) in
`network.tf`. Add a NAT only when something needs the wider internet.

That endpoint is not optional. Without it the SMTP connection simply never opens, and because
`Mailer` logs failures and carries on, sign-up and password reset appear to work while no email is
ever sent.

**Set a billing alarm before the first apply, not after.**

## State

In S3, at `s3://secplus-tfstate-<account-id>/infra/terraform.tfstate`, so every machine this is
deployed from shares one copy. It contains the generated RDS password and the JWT signing key **in
plaintext**, so it must never be in git or copied around. The bucket is private,
encrypted and versioned. `.terraform.lock.hcl` is committed on purpose; it pins provider versions.

`deploy.sh` creates the bucket (with the AWS CLI, not Terraform, so the bucket itself needs no
state file) and passes its name at `init`, because a backend block cannot compute the account id.
Locking is S3-native (`use_lockfile`, Terraform ≥ 1.10), so two machines cannot apply at once and
no DynamoDB lock table is needed.

**Migrating from local state.** If `infra/terraform.tfstate` exists when `deploy.sh` runs, it is
copied to S3 once and renamed to `terraform.tfstate.migrated-backup`. Delete that backup after
`plan` shows no changes. If S3 already holds state, the script refuses to overwrite it with a
local copy, since that local copy is probably stale.

To run Terraform by hand, initialise against the same bucket first:

```bash
terraform -chdir=infra init -backend-config="bucket=secplus-tfstate-$(aws sts get-caller-identity --query Account --output text)"
```

**Terraform does not have to be installed.** Without it, `deploy.sh` runs the pinned
`hashicorp/terraform` image through Docker, so a new machine needs only Docker and `aws configure`.

## Teardown

```bash
terraform -chdir=infra destroy
```

`deletion_protection` and `skip_final_snapshot = false` on the database are intentional: destroy
will refuse until you disable protection, and will take a final snapshot when it does go. The
data is users' study history and there is no other copy.
