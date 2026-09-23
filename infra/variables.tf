variable "project" {
  description = "Name prefix for every resource, so one account can host more than one environment."
  type        = string
  default     = "secplus"
}

variable "region" {
  description = "Everything lives in one region. CloudFront is global but its ACM cert, if a custom domain is ever added, must be in us-east-1."
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "RDS master username. The password is generated, never written here."
  type        = string
  default     = "secplus"
}

variable "db_instance_class" {
  description = "db.t4g.micro is free-tier eligible for 12 months on a new account."
  type        = string
  default     = "db.t4g.micro"
}

variable "api_cpu" {
  description = "App Runner vCPU. 0.25 is the floor and is enough for a study app; this is the main cost lever."
  type        = string
  default     = "0.25 vCPU"
}

variable "api_memory" {
  description = "App Runner memory. The JVM is told to use 75% of it via MaxRAMPercentage in the Dockerfile."
  type        = string
  default     = "0.5 GB"
}

variable "site_url" {
  description = <<-EOT
    The public origin, e.g. https://d111111abcdef8.cloudfront.net.

    This exists to break a dependency cycle, not because it is good. CloudFront
    needs App Runner as an origin, and App Runner wants the CloudFront domain
    for CORS_ALLOWED_ORIGINS — each needs the other's output. So the first
    apply runs with the placeholder, and scripts/deploy.sh applies a second time
    with the real domain once the distribution exists.

    Functionally this value is inert in the normal topology: /api/* is served
    from the site's own domain, so the browser never issues a cross-origin
    request and Spring never consults the CORS configuration. It has to be a
    parseable origin, not a correct one.
  EOT
  type        = string
  default     = "https://placeholder.invalid"
}

variable "image_tag" {
  description = "ECR tag App Runner deploys. scripts/deploy.sh pushes and passes this."
  type        = string
  default     = "latest"
}
