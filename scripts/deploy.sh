#!/usr/bin/env bash
#
# Deploys the infrastructure and the API. Run from the repo root: ./scripts/deploy.sh
#
# The FRONT END is not built here. Amplify builds and serves it, and a push to
# `main` is what ships it (infra/amplify.tf). This script only asks Amplify for
# a build at the end, because Amplify applies rule and environment changes
# (redirects, VITE_API_URL) only when it next deploys.
#
# When a change touches both halves, run this BEFORE merging to main: otherwise
# Amplify ships a front end that calls endpoints the running API does not have.

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
      -e TF_VAR_extra_cors_origins \
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

# The Amplify app (infra/amplify.tf) was created in the console and imported,
# and Terraform cannot create one without a GitHub token. So it must already be
# in state. Checked here, before anything ships, rather than failing at the
# apply after the image is pushed.
if ! tf -chdir=infra state list 2>/dev/null | grep -qx 'aws_amplify_app.web'; then
  EXISTING_APP=$("$AWS" amplify list-apps --region "$REGION" \
    --query "apps[?contains(repository, 'SECURITYPLUS-QUIZ')].appId | [0]" --output text 2>/dev/null || true)
  if [ -n "$EXISTING_APP" ] && [ "$EXISTING_APP" != "None" ]; then
    echo "Amplify app $EXISTING_APP exists but Terraform doesn't know about it. Import it once:" >&2
    echo "  terraform -chdir=infra import aws_amplify_app.web $EXISTING_APP" >&2
    echo "  terraform -chdir=infra import aws_amplify_branch.main $EXISTING_APP/main" >&2
  else
    echo "No Amplify app for this repo. Create it in the Amplify console, then import it" >&2
    echo "- see infra/README.md, 'Amplify'." >&2
  fi
  exit 1
fi

# App Runner rejects any update while a rollout is in flight
# (InvalidStateException: OPERATION_IN_PROGRESS), so a deploy started while the
# previous one is still settling fails partway, after the image is pushed.
# Wait it out rather than half-deploying.
wait_for_apprunner() {
  local arn status waited=0
  arn=$("$AWS" apprunner list-services --region "$REGION" \
    --query "ServiceSummaryList[?ServiceName=='secplus'].ServiceArn | [0]" --output text 2>/dev/null) || return 0
  [ -z "$arn" ] || [ "$arn" = "None" ] && return 0

  while [ "$waited" -lt 900 ]; do
    status=$("$AWS" apprunner describe-service --service-arn "$arn" --region "$REGION" \
      --query 'Service.Status' --output text 2>/dev/null) || return 0
    case "$status" in
      OPERATION_IN_PROGRESS)
        [ "$waited" -eq 0 ] && echo "App Runner is mid-rollout; waiting for it to settle..."
        sleep 15; waited=$((waited + 15)) ;;
      *) return 0 ;;
    esac
  done
  echo "App Runner still busy after 15 minutes. Check its status before retrying." >&2
  exit 1
}
wait_for_apprunner

# The registry has to exist AND hold an image before App Runner is created:
# creating the service points it at <repo>:latest and it fails outright if it
# cannot pull. So the repository is targeted first, filled, and only then does
# the rest of the stack come up. On later runs this is a no-op.
step "1/4  Creating the image repository"
tf -chdir=infra apply -input=false -auto-approve -target=aws_ecr_repository.api
ECR_URL=$(tf -chdir=infra output -raw ecr_repository_url)

step "2/4  Building and pushing the API image"
"$AWS" ecr get-login-password --region "$REGION" \
  | docker login --username AWS --password-stdin "${ECR_URL%%/*}"

# Built from server/, matching how CI builds it, so a green CI run means this
# image builds too.
#
# --platform linux/amd64 always: App Runner runs x86 containers, and Docker
# otherwise builds for the machine it is on. From an Apple Silicon Mac that is
# an arm64 image, which pushes fine and then fails to start on App Runner
# ("exec format error") - after the rest of the deploy has gone through. On an
# ARM Mac this builds under emulation, so it is slower; that is expected.
docker build --platform linux/amd64 -t "$ECR_URL:latest" ./server
docker push "$ECR_URL:latest"

step "3/4  Applying the rest of the stack"
tf -chdir=infra apply -input=false -auto-approve

SITE_URL=$(tf -chdir=infra output -raw site_url)
SERVICE_ARN=$(tf -chdir=infra output -raw apprunner_service_arn)

# Pushing a new :latest changes no Terraform attribute, and auto-deploy is off,
# so without this a redeploy would upload an image the service never picks up —
# the build succeeds and nothing changes. Tolerated failure: on the very first
# run the service is already deploying, and asking again is rejected.
"$AWS" apprunner start-deployment --service-arn "$SERVICE_ARN" --region "$REGION" >/dev/null 2>&1 \
  && echo "rollout triggered" \
  || echo "already deploying — skipping"

# A build of main's latest commit - never this machine's working tree - so any
# rule or VITE_API_URL change applied above takes effect. Tolerated failure: one
# is refused while another is already running - if a change here needs to go
# live, start a RELEASE by hand once that build finishes.
AMPLIFY_APP_ID=$(tf -chdir=infra output -raw amplify_app_id)
"$AWS" amplify start-job --app-id "$AMPLIFY_APP_ID" --branch-name main --job-type RELEASE \
  --region "$REGION" >/dev/null 2>&1 \
  && echo "Amplify build of main started" \
  || echo "Amplify is already building - skipping"

# App Runner rolls out asynchronously, so the script finishing does NOT mean
# the new image is serving. Waiting here matters more than it sounds: testing
# straight after a deploy otherwise hits the *old* container, and the result
# looks exactly like the change not working.
step "4/4  Waiting for the API rollout to finish"
wait_for_apprunner

printf '\n\033[32mDeployed and live:\033[0m %s\n' "$SITE_URL"
