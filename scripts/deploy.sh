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

TF="${TERRAFORM:-terraform}"
AWS="${AWS_CLI:-aws}"

command -v "$TF"  >/dev/null || { echo "terraform not found. Set TERRAFORM=/path/to/terraform" >&2; exit 1; }
command -v "$AWS" >/dev/null || { echo "aws cli not found" >&2; exit 1; }

"$AWS" sts get-caller-identity >/dev/null 2>&1 || {
  echo "No AWS credentials. Run 'aws configure' (or 'aws sso login') first." >&2
  exit 1
}

step() { printf '\n\033[1m── %s\033[0m\n' "$1"; }

# --------------------------------------------------------------------- infra --

REGION=$("$AWS" configure get region || echo us-east-1)

"$TF" -chdir=infra init -input=false

# The registry has to exist AND hold an image before App Runner is created:
# creating the service points it at <repo>:latest and it fails outright if it
# cannot pull. So the repository is targeted first, filled, and only then does
# the rest of the stack come up. On later runs this is a no-op.
step "1/6  Creating the image repository"
"$TF" -chdir=infra apply -input=false -auto-approve -target=aws_ecr_repository.api
ECR_URL=$("$TF" -chdir=infra output -raw ecr_repository_url)

step "2/6  Building and pushing the API image"
"$AWS" ecr get-login-password --region "$REGION" \
  | docker login --username AWS --password-stdin "${ECR_URL%%/*}"

# Built from server/, matching how CI builds it, so a green CI run means this
# image builds too.
docker build -t "$ECR_URL:latest" ./server
docker push "$ECR_URL:latest"

step "3/6  Provisioning the rest of the stack"
"$TF" -chdir=infra apply -input=false -auto-approve

SITE_URL=$("$TF" -chdir=infra output -raw site_url)
BUCKET=$("$TF" -chdir=infra output -raw site_bucket)
DIST_ID=$("$TF" -chdir=infra output -raw distribution_id)
SERVICE_ARN=$("$TF" -chdir=infra output -raw apprunner_service_arn)

echo "site:   $SITE_URL"
echo "bucket: $BUCKET"

# ------------------------------------------------------------------ cors fix --

step "4/6  Pointing the API's CORS origin at the real domain"
# Cheap no-op on every run after the first.
"$TF" -chdir=infra apply -input=false -auto-approve -var="site_url=$SITE_URL"

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
