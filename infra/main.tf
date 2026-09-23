terraform {
  required_version = ">= 1.9"

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

  # State is local on purpose. A remote S3 backend is the right answer for a
  # team, but it needs a bucket and a lock table that themselves have to be
  # created first — and this stack has exactly one operator. If a second person
  # ever applies this, move the state to S3 before they do, not after.
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
}

# The SPA and the API are served from ONE CloudFront domain. This is not a
# preference: the refresh token is a SameSite=Strict cookie, so an API on a
# different domain would never receive it and every session would die after 15
# minutes. Local dev cannot reveal that, because localhost:5173 and
# localhost:8080 are the same site. See docs/decisions.md before splitting them.

data "aws_availability_zones" "available" {
  state = "available"
}
