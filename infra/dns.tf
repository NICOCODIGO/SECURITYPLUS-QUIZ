# DNS, the TLS certificate and the SES domain identity for var.domain_name.
#
# The hosted zone is READ, not created. Route 53 makes one automatically when a
# domain is registered through it, so creating another here would produce a
# second zone with different nameservers — one the registrar does not delegate
# to, and which therefore silently resolves nothing.
#
# Ordering note, because it is the one thing that can waste an hour here: every
# wait in this file polls PUBLIC DNS, not AWS. Until the registry delegates the
# domain to the nameservers in that zone, certificate validation and SES
# verification cannot succeed no matter how correct the records are. Records
# first, waiting second — see docs/devops.md.

data "aws_route53_zone" "main" {
  name         = "${var.domain_name}."
  private_zone = false
}

# -------------------------------------------------------------- SES identity --

# A DOMAIN identity, not an address one. Verifying the domain authorises every
# address on it, so noreply@ needs no click-through of its own — and AWS only
# grants production access (leaving the sandbox) on a verified domain.
resource "aws_ses_domain_identity" "main" {
  domain = var.domain_name
}

resource "aws_route53_record" "ses_verification" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = 600
  records = [aws_ses_domain_identity.main.verification_token]
}

# Easy DKIM: AWS holds the private keys and publishes the public halves at these
# three names. Signing is what stops a receiver treating the mail as forged, so
# without these records the codes and reset links land in spam if they arrive.
resource "aws_ses_domain_dkim" "main" {
  domain = aws_ses_domain_identity.main.domain
}

resource "aws_route53_record" "ses_dkim" {
  count = 3

  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${aws_ses_domain_dkim.main.dkim_tokens[count.index]}._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 600
  records = ["${aws_ses_domain_dkim.main.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

# --------------------------------------------------------- custom MAIL FROM --

# Without this, the *envelope* sender stays amazonses.com even though the visible
# From: header is ours. DKIM still passes, but SPF then aligns to the Amazon
# domain rather than to ours, so only one of the two authentication checks
# actually vouches for us. Receivers weigh both.
resource "aws_ses_domain_mail_from" "main" {
  domain           = aws_ses_domain_identity.main.domain
  mail_from_domain = "mail.${var.domain_name}"

  # If mail.<domain> ever stops resolving, fall back to the Amazon envelope
  # domain instead of refusing to send. Mail should degrade, never stop: a
  # password reset that cannot be delivered locks someone out of their account.
  behavior_on_mx_failure = "UseDefaultValue"
}

# Bounces and complaints come back here. The region must match where SES sends.
resource "aws_route53_record" "mail_from_mx" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  type    = "MX"
  ttl     = 600
  records = ["10 feedback-smtp.${var.region}.amazonses.com"]
}

resource "aws_route53_record" "mail_from_spf" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  type    = "TXT"
  ttl     = 600
  records = ["v=spf1 include:amazonses.com ~all"]
}

# ------------------------------------------------------------ deliverability --

# SPF on the apex as well. Redundant for alignment now that MAIL FROM is custom,
# but some receivers check the visible From: domain too, and a missing record
# reads worse than a permissive one.
resource "aws_route53_record" "spf" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "TXT"
  ttl     = 600
  records = ["v=spf1 include:amazonses.com ~all"]
}

# p=none: publish the policy, ask nobody to reject anything yet. Tightening to
# quarantine before watching real traffic is how legitimate mail disappears.
#
# No rua=. Reports sent to a Gmail address would need an authorisation record on
# the Google side of the fence, which we cannot add, so receivers would ignore
# the address — an empty policy is honest where a broken report target is not.
resource "aws_route53_record" "dmarc" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "_dmarc.${var.domain_name}"
  type    = "TXT"
  ttl     = 600
  records = ["v=DMARC1; p=none; sp=none; adkim=r; aspf=r"]
}

# --------------------------------------------------------------- certificate --

# us-east-1 only. CloudFront reads certificates from that region regardless of
# where the distribution serves, and var.region is already us-east-1, so no
# aliased provider is needed here. Changing var.region would need one.
resource "aws_acm_certificate" "site" {
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method         = "DNS"

  # A certificate in use by CloudFront cannot be deleted, so any change that
  # forces replacement has to mint the new one first.
  lifecycle {
    create_before_destroy = true
  }
}

# allow_overwrite because apex and www can be issued the SAME validation record.
# Without it the second write collides with the first and the apply fails on a
# record that is already exactly right.
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for option in aws_acm_certificate.site.domain_validation_options :
    option.domain_name => {
      name  = option.resource_record_name
      type  = option.resource_record_type
      value = option.resource_record_value
    }
  }

  zone_id         = data.aws_route53_zone.main.zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 60
  records         = [each.value.value]
  allow_overwrite = true
}

# THIS is the resource that waits, and the reason the first apply is narrowed
# with -target to skip it. It polls until ACM sees the records above through
# public DNS; while the registry is still delegating the domain, that cannot
# happen.
#
# 20 minutes rather than the 75-minute default: failing fast and rerunning beats
# a terminal that looks hung, and rerunning costs nothing because the records
# are already in place.
resource "aws_acm_certificate_validation" "site" {
  certificate_arn         = aws_acm_certificate.site.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  timeouts {
    create = "20m"
  }
}

# -------------------------------------------------------------- site records --

# The apex and www records now point at Amplify, and live in amplify.tf beside
# the domain association they depend on.
