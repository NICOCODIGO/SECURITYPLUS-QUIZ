output "site_url" {
  description = "The public URL. Both the app and /api/* are served from here."
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
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

output "apprunner_service_url" {
  description = "The API's direct domain. Reaching it bypasses CloudFront, so the SameSite=Strict cookie will not be sent — useful for health checks, not for signing in."
  value       = aws_apprunner_service.api.service_url
}
