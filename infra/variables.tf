variable "project" {
  description = "Name prefix for every resource, so one account can host more than one environment."
  type        = string
  default     = "secplus"
}

variable "region" {
  description = "Everything lives in one region. CloudFront is global, and its ACM certificate MUST be in us-east-1 - which is why dns.tf needs no second provider alias."
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = <<-EOT
    The registered domain the app is served from. Route 53 created its hosted
    zone at registration, so dns.tf reads that zone rather than creating one.

    Everything else is derived: www.<domain> redirects to the apex, mail.<domain>
    is the SES custom MAIL FROM, and the ACM certificate covers apex + www.
  EOT
  type        = string
  default     = "certucation.click"
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

variable "mail_from" {
  description = <<-EOT
    The sender address. Verifying the DOMAIN authorises every address on it, so
    this one needs no separate verification - which is the main reason dns.tf
    creates a domain identity instead of another single-address one.

    Do not point this at the domain before SES reports it verified: sending would
    fail for every recipient, including the one verified address.
  EOT
  type        = string
  default     = "noreply@certucation.click"
}

variable "image_tag" {
  description = "ECR tag App Runner deploys. scripts/deploy.sh pushes and passes this."
  type        = string
  default     = "latest"
}

# ------------------------------------------------------------------ amplify --

variable "github_repository" {
  description = "The repository Amplify builds the front end from."
  type        = string
  default     = "https://github.com/NICOCODIGO/SECURITYPLUS-QUIZ"
}

variable "amplify_default_host" {
  description = "The main branch's amplifyapp.com address, which every Amplify app has and cannot remove; it is redirected to the domain. A variable because the app cannot reference its own default_domain in its rules. Changes only if the app is recreated."
  type        = string
  default     = "main.ddd6s3rqnsf8m.amplifyapp.com"
}

variable "extra_cors_origins" {
  description = "Comma-separated origins allowed alongside the site, e.g. a test address during a future move. Pass as TF_VAR_extra_cors_origins. A variable rather than a reference to the Amplify app, because the app already references App Runner and that would be a cycle."
  type        = string
  default     = ""
}
