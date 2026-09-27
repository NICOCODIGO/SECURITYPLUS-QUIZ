# infra

Terraform for the deployed stack. Applied with `./scripts/deploy.sh` from the repo root, which
also builds and uploads both halves of the app — don't run `terraform apply` on its own unless
you only mean to change infrastructure.

## What it creates

```
certucation.click ── CloudFront ──┬── /*      → S3 (the React app)
    (www → apex)                  └── /api/*  → App Runner (Spring Boot)
                                                    ├── VPC connector ── RDS Postgres 17
                                                    └── SSM (secrets)

Route 53 ── ACM certificate (us-east-1) + SES domain identity, DKIM, custom MAIL FROM
```

| File | Holds |
|---|---|
| `main.tf` | Providers, the S3 state backend, shared locals |
| `network.tf` | VPC, subnets, the App Runner VPC connector |
| `database.tf` | RDS Postgres, its generated password, the SSM parameters |
| `api.tf` | ECR, the two App Runner IAM roles, the service itself |
| `web.tf` | S3, the distribution, the `www` → apex function |
| `dns.tf` | The hosted zone lookup, every DNS record, the certificate, the SES identity |
| `mail.tf` | The SES SMTP user and its derived password |
| `functions/` | CloudFront Function source, rendered with `templatefile` |

Standing up a **new** domain is the one case where `terraform apply -target=...` is correct, and
[docs/devops.md](../docs/devops.md) has the exact command. Everything in `dns.tf` that waits polls
public DNS, so certificate validation cannot pass until the registry has delegated the domain.

## The three things that will bite you

**One domain, not two.** The refresh token is a `SameSite=Strict` cookie. Serve the API from its
own domain and browsers will never send it — refresh fails forever and every user is signed out
15 minutes after signing in. Local development cannot reveal this, because `localhost:5173` and
`localhost:8080` are the same site. That is why `/api/*` is a CloudFront behaviour rather than a
separate distribution.

The custom domain kept that property rather than breaking it. `www` is aliased on the distribution
only so a CloudFront Function can 301 it to the apex — cookies are scoped per host, so two
serving hostnames would mean signing in on one and appearing signed out on the other.

**The `/api/*` behaviour's policies are load-bearing.** It uses `Managed-CachingDisabled` and
`Managed-AllViewerExceptHostHeader`. Defaults would strip `Authorization` and `Cookie` (so every
authenticated request looks anonymous) and cache responses (so one account's data could be
served to another). `AllViewerExceptHostHeader` specifically, not `AllViewer` — App Runner
rejects a forwarded viewer `Host`.

**`AUTH_JWT_SECRET` must survive deploys.** It is generated once and held in SSM with
`ignore_changes` on its value. Rotating it signs every user out. `application-prod.properties`
gives it no default, so a container that cannot read it fails to start rather than quietly
minting a throwaway key.

## Cost

RDS `db.t4g.micro` is free-tier eligible for 12 months on a new account. S3, CloudFront and ECR
are pennies at portfolio traffic. **App Runner is the real cost** — it bills for provisioned
memory even while idle, so this is not a scale-to-zero stack.

There is deliberately **no NAT gateway** (~$32/month, usually the largest avoidable line item).
A VPC connector would normally require one, but this app makes no outbound internet calls — it
talks to RDS and nothing else. Add one only when something actually needs egress.

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
