resource "aws_ecr_repository" "api" {
  name                 = local.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Without this, every deploy leaves an untagged layer set behind and the
# repository grows until it costs money.
resource "aws_ecr_lifecycle_policy" "api" {
  repository = aws_ecr_repository.api.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep the last 5 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 5
      }
      action = { type = "expire" }
    }]
  })
}

# ---------------------------------------------------------------------- IAM --

# App Runner needs two distinct roles and confusing them is a common failure:
# the *access* role is assumed by the build side to pull from ECR, the
# *instance* role is assumed by the running container to reach other services.

data "aws_iam_policy_document" "apprunner_build_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apprunner_access" {
  name               = "${local.name}-apprunner-access"
  assume_role_policy = data.aws_iam_policy_document.apprunner_build_assume.json
}

resource "aws_iam_role_policy_attachment" "apprunner_ecr" {
  role       = aws_iam_role.apprunner_access.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

data "aws_iam_policy_document" "apprunner_tasks_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["tasks.apprunner.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "apprunner_instance" {
  name               = "${local.name}-apprunner-instance"
  assume_role_policy = data.aws_iam_policy_document.apprunner_tasks_assume.json
}

# Only the four parameters this service owns, not ssm:* on everything.
data "aws_iam_policy_document" "read_secrets" {
  statement {
    actions = ["ssm:GetParameter", "ssm:GetParameters"]
    resources = [
      aws_ssm_parameter.db_url.arn,
      aws_ssm_parameter.db_user.arn,
      aws_ssm_parameter.db_password.arn,
      aws_ssm_parameter.jwt_secret.arn,
      aws_ssm_parameter.mail_username.arn,
      aws_ssm_parameter.mail_password.arn,
    ]
  }
}

resource "aws_iam_role_policy" "read_secrets" {
  name   = "${local.name}-read-secrets"
  role   = aws_iam_role.apprunner_instance.id
  policy = data.aws_iam_policy_document.read_secrets.json
}

# --------------------------------------------------------------- App Runner --

resource "aws_apprunner_service" "api" {
  service_name = local.name

  source_configuration {
    auto_deployments_enabled = false # scripts/deploy.sh triggers deploys explicitly

    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_access.arn
    }

    image_repository {
      image_identifier      = "${aws_ecr_repository.api.repository_url}:${var.image_tag}"
      image_repository_type = "ECR"

      image_configuration {
        port = "8080"

        runtime_environment_variables = {
          SPRING_PROFILES_ACTIVE = "prod"

          # Needed: App Runner's own proxy is the socket peer for every request,
          # so without the header every user would share one rate-limit bucket.
          # Proxies APPEND to X-Forwarded-For - CloudFront adds the viewer, then
          # App Runner adds CloudFront - so the caller is 2 from the right, and
          # anything further left is caller-supplied. App Runner can also be
          # called directly, which is why every limit that protects a person is
          # per account or global too. See AuthController.clientIp, and
          # docs/devops.md for how to check this value after a deploy.
          AUTH_TRUST_FORWARDED_FOR = "true"
          AUTH_FORWARDED_FOR_HOPS  = "2"

          # TEMPORARY, while the move to Amplify settles the proxy chain: logs
          # each X-Forwarded-For and the entry chosen (AuthController.clientIp),
          # so the hops value above can be read off rather than guessed. Logs
          # IP addresses - remove once the value is confirmed.
          LOGGING_LEVEL_COM_SECPLUS_AUTH_AUTHCONTROLLER = "DEBUG"

          AUTH_COOKIE_SECURE = "true"
          # Holds only because /api/* is served from the site's own domain.
          AUTH_COOKIE_SAME_SITE = "Strict"

          # Same-origin to the browser, but not to Spring: behind a proxy the
          # Host it sees is App Runner's while Origin is the site's, so every
          # write is checked as CORS and an origin missing here is refused.
          # That is why a site being tested on another address (Amplify's
          # amplifyapp.com, before the domain moves) needs extra_cors_origins.
          # Variables rather than references — see variables.tf for the cycle.
          CORS_ALLOWED_ORIGINS = join(",", compact([var.site_url, var.extra_cors_origins]))

          # SES SMTP in the same region. Port 587 with STARTTLS rather than 465
          # implicit TLS, because that is what JavaMailSender defaults to.
          MAIL_HOST = "email-smtp.${var.region}.amazonaws.com"
          MAIL_PORT = "587"
          MAIL_FROM = var.mail_from
          # Links in verification and reset emails have to point at the site,
          # not at App Runner directly.
          APP_BASE_URL = var.site_url
        }

        runtime_environment_secrets = {
          DB_URL          = aws_ssm_parameter.db_url.arn
          DB_USER         = aws_ssm_parameter.db_user.arn
          DB_PASSWORD     = aws_ssm_parameter.db_password.arn
          AUTH_JWT_SECRET = aws_ssm_parameter.jwt_secret.arn
          MAIL_USERNAME   = aws_ssm_parameter.mail_username.arn
          MAIL_PASSWORD   = aws_ssm_parameter.mail_password.arn
        }
      }
    }
  }

  instance_configuration {
    cpu               = var.api_cpu
    memory            = var.api_memory
    instance_role_arn = aws_iam_role.apprunner_instance.arn
  }

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.main.arn
    }
  }

  health_check_configuration {
    protocol = "HTTP"
    path     = "/actuator/health"

    # Generous on purpose. The first boot against an empty database runs Flyway,
    # including R__seed_content.sql — 865KB seeding 444 questions, 1,776 choices
    # and 1,332 rationales. A tight health check kills the container mid-
    # migration and the service loops without ever becoming healthy.
    interval            = 20
    timeout             = 10
    healthy_threshold   = 1
    unhealthy_threshold = 5
  }

  # The service reads its database URL from SSM, and that parameter only holds
  # a real endpoint once RDS exists.
  depends_on = [aws_ssm_parameter.db_url]
}
