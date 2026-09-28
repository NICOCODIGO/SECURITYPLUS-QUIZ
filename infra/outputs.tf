output "site_url" {
  description = "The public URL. Both the app and /api/* are served from here."

  # local.site_url (main.tf) - the same value App Runner gets for
  # CORS_ALLOWED_ORIGINS and APP_BASE_URL (so email links) and the Amplify
  # branch gets for VITE_API_URL. Printed for reference; nothing reads it.
  value = local.site_url
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
  description = "Amplify's own address for main. It 301s to site_url; useful only for telling DNS problems from Amplify ones."
  value       = "https://main.${aws_amplify_app.web.default_domain}"
}

output "apprunner_service_url" {
  description = "The API's direct domain. Reaching it bypasses CloudFront, so the SameSite=Strict cookie will not be sent — useful for health checks, not for signing in."
  value       = aws_apprunner_service.api.service_url
}
