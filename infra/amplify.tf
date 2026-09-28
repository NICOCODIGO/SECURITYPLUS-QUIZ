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
# Serves certucation.click (domain association at the bottom). The app itself
# was created in the console and imported, so it has no access token here.

# ------------------------------------------------------- security headers --

# One definition, served by whichever front door is live: Amplify below, and
# the CloudFront distribution in web.tf until the domain moves. Without them the
# login and 2FA pages can be framed by another site (clickjacking) and nothing
# limits where scripts may come from.
#
# The CSP was checked against the production build in a real browser: no page
# needs an inline script, styles need 'unsafe-inline' (component libraries set
# style attributes), and the only third-party resource is Unsplash imagery on
# Home. The API is same-origin (VITE_API_URL is the site itself), so
# connect-src 'self' covers it - on the amplifyapp.com test address too, since
# the build there points at that address. Adding a CDN, font host or analytics
# script means adding it here, or the browser will block it.
locals {
  content_security_policy = join("; ", [
    "default-src 'self'",
    "script-src 'self'",
    "style-src 'self' 'unsafe-inline'",
    "img-src 'self' data: https://images.unsplash.com",
    "font-src 'self'",
    "connect-src 'self'",
    "frame-ancestors 'none'",
    "base-uri 'self'",
    "form-action 'self'",
    "object-src 'none'",
  ])

  security_headers = {
    "Strict-Transport-Security" = "max-age=31536000; includeSubDomains"
    "X-Content-Type-Options"    = "nosniff"
    "X-Frame-Options"           = "DENY"
    "Referrer-Policy"           = "strict-origin-when-cross-origin"
    "Content-Security-Policy"   = local.content_security_policy
  }
}

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

  # Cookies in the cache key, which is also what gets them forwarded to the
  # /api proxy target. Without it the refresh cookie may never reach App
  # Runner, and every session ends at the 15-minute access-token expiry.
  # Costs no cache hits: that cookie is scoped to /api/v1/auth, so page and
  # asset requests never carry it. API responses are no-store regardless.
  cache_config {
    type = "AMPLIFY_MANAGED"
  }

  # Nested under `applications` with the appRoot, because this is a monorepo
  # app: the flat top-level `customHeaders` form fails every build at the
  # deploy step ("Monorepo spec provided without applications key").
  #
  # jsonencode, not yamlencode: Amplify accepts YAML but stores it back as
  # compact JSON with sorted keys, so YAML shows as a change on every plan.
  # JSON is valid YAML, and jsonencode produces exactly what Amplify returns.
  custom_headers = jsonencode({
    applications = [{
      appRoot = "secapp"
      customHeaders = [{
        pattern = "**"
        headers = [for key, value in local.security_headers : { key = key, value = value }]
      }]
    }]
  })

  # Order matters: the first rule that matches wins.

  # The amplifyapp.com address every Amplify app has cannot be removed, so it
  # sends people to the real one. First, so it wins over the /api proxy too:
  # nothing should use that host once the domain is attached.
  custom_rule {
    source = "https://${var.amplify_default_host}/<*>"
    target = "https://${var.domain_name}/<*>"
    status = "301"
  }

  # www only ever redirects, so cookies have one host — signing in on www and
  # later opening the apex would otherwise look like being signed out. Email
  # links are built from APP_BASE_URL, the apex, so they never pass through it.
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
  framework   = "Web"

  enable_auto_build = true

  # Baked into the bundle at build time, and must be absolute (apiClient.js).
  # The site's own domain, so API calls go through the /api proxy above and
  # stay same-origin. Changing it needs a rebuild: Amplify does not rebuild on
  # an environment change by itself.
  environment_variables = {
    VITE_API_URL = "https://${var.domain_name}"
  }
}

# ------------------------------------------------------------------ domain --

# certucation.click and www, on the main branch.
#
# The existing ACM certificate (dns.tf), not an Amplify-managed one: it is
# already issued and validated for exactly these two names, so there is no
# wait for a new certificate while the site is down.
resource "aws_amplify_domain_association" "site" {
  app_id                 = aws_amplify_app.web.id
  domain_name            = var.domain_name
  enable_auto_sub_domain = false

  # false, deliberately. Amplify may wait for the records below before it calls
  # the domain verified, and the records need this resource's output - so
  # waiting here can deadlock until the timeout. It reports the CloudFront
  # target as soon as the association exists; watch the status afterwards with
  # `aws amplify get-domain-association` until it reads AVAILABLE.
  wait_for_verification = false

  certificate_settings {
    type                   = "CUSTOM"
    custom_certificate_arn = aws_acm_certificate_validation.site.certificate_arn
  }

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = ""
  }

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = "www"
  }
}

locals {
  # Amplify reports each sub-domain as " CNAME dxxxx.cloudfront.net"; both
  # point at the same distribution.
  amplify_cloudfront = regex("[a-z0-9]+\\.cloudfront\\.net",
  one([for s in aws_amplify_domain_association.site.sub_domain : s.dns_record if s.prefix == ""]))
}

# A and AAAA aliases, not CNAMEs: a zone apex cannot hold a CNAME, and an alias
# costs nothing to resolve. AAAA so IPv6-only clients can reach the site.
#
# allow_overwrite because Amplify can write these same records itself when the
# zone is in the same account. Either way they end up identical, and owned
# here.
resource "aws_route53_record" "site" {
  for_each = {
    for pair in setproduct([var.domain_name, "www.${var.domain_name}"], ["A", "AAAA"]) :
    "${pair[0]} ${pair[1]}" => { name = pair[0], type = pair[1] }
  }

  zone_id         = data.aws_route53_zone.main.zone_id
  name            = each.value.name
  type            = each.value.type
  allow_overwrite = true

  alias {
    name                   = local.amplify_cloudfront
    zone_id                = "Z2FDTNDATAQYW2" # every CloudFront distribution
    evaluate_target_health = false
  }
}
