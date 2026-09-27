# The front end, built and hosted by Amplify: a push to `main` goes live with
# no deploy script. The API is not here — it stays on App Runner and ships with
# scripts/deploy.sh.
#
# The one property this must keep is ONE HOST. The refresh token is a
# SameSite=Strict cookie, so the SPA and /api/* have to be served from the same
# site or every session dies after 15 minutes (see main.tf). The /api rewrite
# below does that: a 200 rewrite to another URL is a reverse proxy, so the
# browser only ever talks to this app's own domain.
#
# Being brought up alongside the CloudFront distribution in web.tf, not instead
# of it. Until the domain moves, this serves only its amplifyapp.com address,
# which is where it is tested.

resource "aws_amplify_app" "web" {
  name       = local.name
  repository = var.github_repository
  platform   = "WEB"

  # Used once, to connect Amplify to the repository; after that Amplify goes
  # through its GitHub App. Ignored afterwards, so later applies neither need
  # the token nor try to "change" it to empty. null, not "", when unset: the
  # provider rejects an empty string even in a plan.
  access_token = var.github_access_token != "" ? var.github_access_token : null

  # A monorepo: the app is secapp/, and Amplify needs both the appRoot below
  # and this variable, set to the same path, to find it.
  environment_variables = {
    AMPLIFY_MONOREPO_APP_ROOT = "secapp"
  }

  # Lint and objective coverage run here, not only in GitHub CI, because
  # Amplify builds on push without waiting for CI. A build that fails them
  # never replaces the live site. `npm ci` with a local cache directory, since
  # npm ci deletes node_modules and caching that would buy nothing.
  build_spec = <<-EOT
    version: 1
    applications:
      - appRoot: secapp
        frontend:
          phases:
            preBuild:
              commands:
                - nvm install 22
                - nvm use 22
                - npm ci --cache .npm --prefer-offline
            build:
              commands:
                - npm run lint:check
                - npm run objectives
                - npm run build
          artifacts:
            baseDirectory: dist
            files:
              - '**/*'
          cache:
            paths:
              - .npm/**/*
  EOT

  # Order matters: the first rule that matches wins.

  # www only ever redirects, so cookies have one host — signing in on www and
  # later opening the apex would otherwise look like being signed out. Inert
  # until www is attached to this app. Email links are built from APP_BASE_URL,
  # the apex, so they never pass through this redirect.
  custom_rule {
    source = "https://www.${var.domain_name}/<*>"
    target = "https://${var.domain_name}/<*>"
    status = "301"
  }

  # The API, proxied rather than redirected: a redirect would send the browser
  # to App Runner's own domain, where the SameSite=Strict cookie is never sent.
  # App Runner answers every API response with Spring Security's no-store
  # Cache-Control, which is what keeps one account's response from being
  # cached and served to another.
  custom_rule {
    source = "/api/<*>"
    target = "https://${aws_apprunner_service.api.service_url}/api/<*>"
    status = "200"
  }

  # Client-side routing: /progress is a React route, not a file. Anything
  # without a static-asset extension gets the app shell, or a refresh on any
  # deep link would 404.
  custom_rule {
    source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|jpeg|js|png|txt|svg|woff|woff2|ttf|map|json|webp|webmanifest)$)([^.]+$)/>"
    target = "/index.html"
    status = "200"
  }

  lifecycle {
    ignore_changes = [access_token]
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.web.id
  branch_name = "main"
  stage       = "PRODUCTION"
  framework   = "React"

  enable_auto_build = true

  # Baked into the bundle at build time, and must be absolute (apiClient.js).
  # Until the domain moves it is this branch's own amplifyapp.com address, so
  # the test exercises the /api proxy above rather than calling the live site.
  environment_variables = {
    VITE_API_URL = var.amplify_api_url != "" ? var.amplify_api_url : "https://main.${aws_amplify_app.web.default_domain}"
  }
}
