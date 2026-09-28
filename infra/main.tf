terraform {
  # 1.10 for S3-native state locking (use_lockfile below).
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # State lives in S3 so every machine this is deployed from sees the same
  # copy. It holds the RDS password and the JWT signing key in plaintext, so the
  # bucket is private, encrypted and versioned — scripts/deploy.sh creates it
  # that way. The bucket name carries the account id, which a backend block
  # cannot compute, so deploy.sh passes it at init:
  #   -backend-config=bucket=secplus-tfstate-<account-id>
  # use_lockfile stops two machines applying at once without a DynamoDB table.
  backend "s3" {
    key          = "infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = var.project
      ManagedBy = "terraform"
    }
  }
}

locals {
  name = var.project

  # The public origin. Derived, not a variable: it used to be passed in to break
  # a CloudFront <-> App Runner cycle, and a forgotten `-var` then silently put
  # a placeholder into CORS and every email link.
  site_url = "https://${var.domain_name}"
}

# The SPA and the API are served from ONE domain - Amplify serves the pages and
# proxies /api/* to App Runner (amplify.tf). This is not a preference: the
# refresh token is a SameSite=Strict cookie, so an API on a different domain
# would never receive it and every session would die after 15 minutes. Local
# dev cannot reveal that, because localhost:5173 and localhost:8080 are the same
# site. See docs/decisions.md before splitting them.

data "aws_availability_zones" "available" {
  state = "available"
}
