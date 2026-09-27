# Sending mail through SES, for account verification and password reset.
#
# SMTP rather than the SES API, so the app needs `spring-boot-starter-mail`
# (managed by the Boot BOM) and no AWS SDK at all — the same reasoning that has
# kept the SDK out of this project so far.
#
# The credentials are created here rather than clicked together in the console.
# The console route for this now leads into Mail Manager, whose wizard builds an
# *inbound* ingress endpoint that bills by the hour and has nothing to do with
# sending. Terraform makes the right thing, reproducibly, and the password never
# has to be copied out of a "shown once" dialog.

resource "aws_iam_user" "smtp" {
  name = "${local.name}-smtp"
}

# Only sending. This user cannot read identities, change the account out of
# sandbox, or touch anything else in SES.
data "aws_iam_policy_document" "smtp_send" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "smtp_send" {
  name   = "${local.name}-smtp-send"
  user   = aws_iam_user.smtp.name
  policy = data.aws_iam_policy_document.smtp_send.json
}

resource "aws_iam_access_key" "smtp" {
  user = aws_iam_user.smtp.name
}

resource "aws_ssm_parameter" "mail_username" {
  name  = "/${local.name}/mail/username"
  type  = "SecureString"
  value = aws_iam_access_key.smtp.id
}

# An SES SMTP password is not the IAM secret key: it is that key put through a
# documented HMAC derivation. The provider does it, so the raw secret is never
# handled by hand or pasted anywhere.
resource "aws_ssm_parameter" "mail_password" {
  name  = "/${local.name}/mail/password"
  type  = "SecureString"
  value = aws_iam_access_key.smtp.ses_smtp_password_v4
}

# The sender address itself is NOT stored here. It is not a secret, and App
# Runner takes it as a plain environment variable (MAIL_FROM in api.tf) - a
# parameter nothing reads is just a thing to keep in sync. Which identity is
# allowed to send it is decided in dns.tf.
