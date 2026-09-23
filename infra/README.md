# infra

Terraform for the deployed stack. Applied with `./scripts/deploy.sh` from the repo root, which
also builds and uploads both halves of the app — don't run `terraform apply` on its own unless
you only mean to change infrastructure.

## What it creates

```
CloudFront ──┬── /*      → S3 (the React app)
             └── /api/*  → App Runner (Spring Boot) ── VPC connector ── RDS Postgres 17
                                                                    └── SSM (secrets)
```

## The three things that will bite you

**One domain, not two.** The refresh token is a `SameSite=Strict` cookie. Serve the API from its
own domain and browsers will never send it — refresh fails forever and every user is signed out
15 minutes after signing in. Local development cannot reveal this, because `localhost:5173` and
`localhost:8080` are the same site. That is why `/api/*` is a CloudFront behaviour rather than a
separate distribution.

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

Local, and gitignored. It contains the generated RDS password and the JWT signing key **in
plaintext** — committing it would publish both. `.terraform.lock.hcl` is committed on purpose;
it pins provider versions.

One operator, so a remote backend would mean creating a bucket and a lock table to protect state
nobody else touches. If a second person ever applies this, move state to S3 *before* they do.

## Teardown

```bash
terraform -chdir=infra destroy
```

`deletion_protection` and `skip_final_snapshot = false` on the database are intentional: destroy
will refuse until you disable protection, and will take a final snapshot when it does go. The
data is users' study history and there is no other copy.
