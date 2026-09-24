#!/usr/bin/env bash
#
# Deploys the whole stack. Run from the repo root: ./scripts/deploy.sh
#
# The ordering is not arbitrary. VITE_API_URL is baked into the front end at
# BUILD time and apiClient.js needs it absolute — isConfigured() is false when
# it is empty, and new URL() rejects a relative base. So the SPA cannot be built
# until CloudFront exists and its domain is known. Hence: infrastructure first,
# read the domain, then build.
#
# The second apply exists for the same reason in the other direction: App Runner
# wants the CloudFront domain for CORS_ALLOWED_ORIGINS, and CloudFront needs App
# Runner as an origin. See infra/variables.tf.

set -euo pipefail

cd "$(dirname "$0")/.."

AWS="${AWS_CLI:-aws}"
TF_IMAGE="hashicorp/terraform:1.10.5"

command -v "$AWS" >/dev/null || { echo "aws cli not found" >&2; exit 1; }

# Terraform does not have to be installed: without it, the pinned image runs it
# instead, so a fresh machine needs only Docker and AWS credentials. The repo is
# mounted at the same relative layout, so -chdir=infra works unchanged. The
# MSYS_NO_PATHCONV and `pwd -W` dance stops Git Bash on Windows rewriting the
# container-side paths into C:/Program Files/Git/...
if [ -n "${TERRAFORM:-}" ] || command -v terraform >/dev/null; then
  tf() { "${TERRAFORM:-terraform}" "$@"; }
else
  docker info >/dev/null 2>&1 || {
    echo "Neither terraform nor a running Docker daemon found. Install terraform or start Docker Desktop." >&2
    exit 1
  }
  HOST_REPO=$(pwd -W 2>/dev/null || pwd)
  HOST_AWS=$(cd "$HOME/.aws" 2>/dev/null && (pwd -W 2>/dev/null || pwd) || echo "$HOME/.aws")
  tf() {
    MSYS_NO_PATHCONV=1 docker run --rm -i \
      -v "$HOST_REPO:/work" -w /work \
      -v "$HOST_AWS:/aws:ro" \
      -e AWS_CONFIG_FILE=/aws/config -e AWS_SHARED_CREDENTIALS_FILE=/aws/credentials \
      -e AWS_PROFILE -e AWS_REGION -e AWS_DEFAULT_REGION \
      -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN \
      "$TF_IMAGE" "$@"
  }
fi

ACCOUNT_ID=$("$AWS" sts get-caller-identity --query Account --output text 2>/dev/null) || {
  echo "No AWS credentials. Run 'aws configure' (or 'aws sso login') first." >&2
  exit 1
}

step() { printf '\n\033[1m── %s\033[0m\n' "$1"; }

# --------------------------------------------------------------------- state --

# Created here with the CLI rather than by Terraform: a Terraform-managed state
# bucket needs its own state file, which would be one more thing stuck on
# whichever machine created it. Idempotent — every step is a no-op on a bucket
# that already has it. Region is fixed to match the backend block in main.tf.
STATE_BUCKET="secplus-tfstate-$ACCOUNT_ID"
STATE_KEY="infra/terraform.tfstate"
STATE_REGION="us-east-1"

if ! "$AWS" s3api head-bucket --bucket "$STATE_BUCKET" >/dev/null 2>&1; then
  step "Creating the Terraform state bucket $STATE_BUCKET"
  "$AWS" s3api create-bucket --bucket "$STATE_BUCKET" --region "$STATE_REGION" >/dev/null
fi
# State holds the RDS password and JWT key in plaintext: never public, always
# encrypted, and versioned so a bad apply or a clobbered write can be rolled back.
"$AWS" s3api put-public-access-block --bucket "$STATE_BUCKET" --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
"$AWS" s3api put-bucket-encryption --bucket "$STATE_BUCKET" --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"},"BucketKeyEnabled":true}]}'
"$AWS" s3api put-bucket-versioning --bucket "$STATE_BUCKET" --versioning-configuration Status=Enabled

# --------------------------------------------------------------------- infra --

REGION=$("$AWS" configure get region || echo us-east-1)

# A local state file means this machine deployed before state moved to S3. Copy
# it up once — but never over a remote copy, because a second machine's stale
# local file would silently replace the real one and Terraform would then try
# to recreate everything the stale copy doesn't know about.
if [ -s infra/terraform.tfstate ]; then
  if "$AWS" s3api head-object --bucket "$STATE_BUCKET" --key "$STATE_KEY" >/dev/null 2>&1; then
    echo "infra/terraform.tfstate exists locally, but S3 already holds state." >&2
    echo "S3 is the source of truth now. Move the local file out of infra/ (don't delete it until" >&2
    echo "'terraform -chdir=infra plan' shows no changes), then rerun." >&2
    exit 1
  fi
  step "Moving local Terraform state to s3://$STATE_BUCKET/$STATE_KEY"
  tf -chdir=infra init -input=false -migrate-state -force-copy -backend-config="bucket=$STATE_BUCKET"
  mv infra/terraform.tfstate "infra/terraform.tfstate.migrated-backup"
  echo "Migrated. The old local copy is infra/terraform.tfstate.migrated-backup (gitignored) —"
  echo "it still holds the secrets in plaintext; delete it once a plan shows no changes."
else
  tf -chdir=infra init -input=false -reconfigure -backend-config="bucket=$STATE_BUCKET"
fi

# The registry has to exist AND hold an image before App Runner is created:
# creating the service points it at <repo>:latest and it fails outright if it
# cannot pull. So the repository is targeted first, filled, and only then does
# the rest of the stack come up. On later runs this is a no-op.
step "1/6  Creating the image repository"
tf -chdir=infra apply -input=false -auto-approve -target=aws_ecr_repository.api
ECR_URL=$(tf -chdir=infra output -raw ecr_repository_url)

step "2/6  Building and pushing the API image"
"$AWS" ecr get-login-password --region "$REGION" \
  | docker login --username AWS --password-stdin "${ECR_URL%%/*}"

# Built from server/, matching how CI builds it, so a green CI run means this
# image builds too.
docker build -t "$ECR_URL:latest" ./server
docker push "$ECR_URL:latest"

step "3/6  Provisioning the rest of the stack"
tf -chdir=infra apply -input=false -auto-approve

SITE_URL=$(tf -chdir=infra output -raw site_url)
BUCKET=$(tf -chdir=infra output -raw site_bucket)
DIST_ID=$(tf -chdir=infra output -raw distribution_id)
SERVICE_ARN=$(tf -chdir=infra output -raw apprunner_service_arn)

echo "site:   $SITE_URL"
echo "bucket: $BUCKET"

# ------------------------------------------------------------------ cors fix --

step "4/6  Pointing the API's CORS origin at the real domain"
# Cheap no-op on every run after the first.
tf -chdir=infra apply -input=false -auto-approve -var="site_url=$SITE_URL"

# Pushing a new :latest changes no Terraform attribute, and auto-deploy is off,
# so without this a redeploy would upload an image the service never picks up —
# the build succeeds and nothing changes. Tolerated failure: on the very first
# run the service is already deploying, and asking again is rejected.
"$AWS" apprunner start-deployment --service-arn "$SERVICE_ARN" --region "$REGION" >/dev/null 2>&1 \
  && echo "rollout triggered" \
  || echo "already deploying — skipping"

# ---------------------------------------------------------------------- web --

step "5/6  Building and uploading the front end"
(
  cd secapp
  npm ci
  VITE_API_URL="$SITE_URL" npm run build
)

# Hashed assets get a long cache; index.html must not, or a deploy ships new
# assets that nobody is told about until their cache expires.
"$AWS" s3 sync secapp/dist "s3://$BUCKET" --delete \
  --exclude index.html --cache-control "public,max-age=31536000,immutable"
"$AWS" s3 cp secapp/dist/index.html "s3://$BUCKET/index.html" \
  --cache-control "no-cache,must-revalidate"

step "6/6  Invalidating the CDN"
"$AWS" cloudfront create-invalidation --distribution-id "$DIST_ID" --paths "/*" >/dev/null

printf '\n\033[32mDeployed:\033[0m %s\n' "$SITE_URL"
echo
echo "The API rolls out in the background — check with:"
echo "  aws apprunner describe-service --service-arn $SERVICE_ARN --query 'Service.Status'"
