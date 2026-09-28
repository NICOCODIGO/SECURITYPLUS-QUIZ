output "site_url" {
  description = "The public URL. Both the app and /api/* are served from here."

  # The custom domain. scripts/deploy.sh reads this and feeds it to
  # CORS_ALLOWED_ORIGINS and APP_BASE_URL on App Runner, so this single line is
  # what puts the real domain in email links. (The front end's VITE_API_URL is
  # set on the Amplify branch, from the same variable.)
  value = "https://${var.domain_name}"
}

output "cloudfront_domain" {
  description = "The distribution hostname. Still serves the app; useful for checking the origin when the custom domain misbehaves."
  value       = aws_cloudfront_distribution.site.domain_name
}

output "distribution_id" {
  description = "Needed to invalidate the cache after uploading a new build."
  value       = aws_cloudfront_distribution.site.id
}

output "site_bucket" {
  description = "Where secapp/dist is synced."
  value       = aws_s3_bucket.site.bucket
}

output "ecr_repository_url" {
  description = "Push the API image here."
  value       = aws_ecr_repository.api.repository_url
}

output "apprunner_service_arn" {
  description = "Used to trigger a deployment after pushing a new image."
  value       = aws_apprunner_service.api.arn
}

output "amplify_app_id" {
  description = "For `aws amplify start-job` and the Amplify console."
  value       = aws_amplify_app.web.id
}

output "amplify_branch_url" {
  description = "The front end on Amplify's own address. Where it is tested before the domain moves; pass it as extra_cors_origins while it is."
  value       = "https://main.${aws_amplify_app.web.default_domain}"
}

output "apprunner_service_url" {
  description = "The API's direct domain. Reaching it bypasses CloudFront, so the SameSite=Strict cookie will not be sent — useful for health checks, not for signing in."
  value       = aws_apprunner_service.api.service_url
}
