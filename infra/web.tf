resource "aws_s3_bucket" "site" {
  bucket        = "${local.name}-site-${data.aws_caller_identity.current.account_id}"
  force_destroy = false
}

data "aws_caller_identity" "current" {}

# The bucket is never public. CloudFront reads it through an Origin Access
# Control, so the only way to the objects is through the distribution.
resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "site" {
  name                              = "${local.name}-s3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# ------------------------------------------------------------ cache policies --

# Managed policies, looked up rather than hardcoded by id.
data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

# Forwards every header EXCEPT Host. The exception matters: App Runner routes
# on the Host header it expects, and passing the viewer's Host through makes it
# reject the request.
data "aws_cloudfront_origin_request_policy" "all_viewer_except_host" {
  name = "Managed-AllViewerExceptHostHeader"
}

# ------------------------------------------------------------- distribution --

resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100" # NA + EU; the cheapest tier
  comment             = "${local.name} — SPA and API on one domain"

  origin {
    origin_id                = "s3"
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }

  origin {
    origin_id   = "api"
    domain_name = aws_apprunner_service.api.service_url

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # The SPA.
  default_cache_behavior {
    target_origin_id       = "s3"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_optimized.id
    compress               = true
  }

  # The API. Three things here are load-bearing and each fails silently if wrong.
  ordered_cache_behavior {
    path_pattern           = "/api/*"
    target_origin_id       = "api"
    viewer_protocol_policy = "https-only"

    # POST/PATCH/DELETE are not in the default set. Without them, every write —
    # sign-up, sign-in, refresh — returns 403 from CloudFront and never reaches
    # the API at all.
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    # Caching an authenticated response would serve one account's data to
    # another — the single worst failure available to an app whose stated
    # purpose is keeping one person's study data private.
    cache_policy_id = data.aws_cloudfront_cache_policy.caching_disabled.id

    # CloudFront strips Authorization and Cookie by default. Without this every
    # authenticated request looks anonymous and the refresh cookie never
    # arrives, which presents as "signed out after 15 minutes" rather than as a
    # routing problem.
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer_except_host.id

    compress = true
  }

  # Client-side routing: /progress is a React route, not an object in S3, so S3
  # answers 403 (it returns 403 rather than 404 when listing is denied). Both
  # map back to the app shell with a 200, or a refresh on any deep link 404s.
  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Only this distribution may read the bucket.
data "aws_iam_policy_document" "site_bucket" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.site.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.site_bucket.json
}
