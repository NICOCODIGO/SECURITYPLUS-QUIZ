# The VPC exists for one reason: App Runner cannot reach a private RDS instance
# without a VPC connector, and RDS should not be public.
#
# There is deliberately NO NAT gateway. A VPC connector routes ALL of App
# Runner's outbound traffic through these subnets, so without one the app has
# no internet at all. It talks to exactly two things: RDS, and SES for mail.
# SES is reached through an interface endpoint below (about $7/month) rather
# than a NAT (about $32/month). No third-party APIs, no webhooks. If something
# here ever needs the wider internet, that is the moment to add a NAT.

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "${local.name}-vpc" }
}

# Two AZs because RDS requires a subnet group spanning at least two, even for a
# single-AZ instance.
resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = { Name = "${local.name}-private-${count.index}" }
}

resource "aws_db_subnet_group" "main" {
  name       = "${local.name}-db"
  subnet_ids = aws_subnet.private[*].id
}

# App Runner's side of the connector.
resource "aws_security_group" "api" {
  name        = "${local.name}-api"
  description = "App Runner tasks"
  vpc_id      = aws_vpc.main.id

  # No ingress rule at all: App Runner accepts traffic on its own managed
  # endpoint, not through this security group.
  egress {
    description = "Postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # A CIDR rather than the endpoint's security group: that group already names
  # this one, and two groups referencing each other inline is a cycle.
  egress {
    description = "SES SMTP via the VPC endpoint"
    from_port   = 587
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = { Name = "${local.name}-api" }
}

resource "aws_security_group" "db" {
  name        = "${local.name}-db"
  description = "RDS Postgres"
  vpc_id      = aws_vpc.main.id

  # Referencing the API's security group rather than a CIDR means nothing else
  # in the VPC can reach the database, even if a subnet is reused later.
  ingress {
    description     = "Postgres from the API only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.api.id]
  }

  tags = { Name = "${local.name}-db" }
}

resource "aws_apprunner_vpc_connector" "main" {
  vpc_connector_name = "${local.name}-connector"
  subnets            = aws_subnet.private[*].id
  security_groups    = [aws_security_group.api.id]
}

# ------------------------------------------------------------------ mail --

# Without this, every verification and reset email fails to connect, and
# Mailer logs the failure and carries on by design, so nothing visibly breaks.
# Private DNS makes email-smtp.<region>.amazonaws.com (MAIL_HOST, unchanged)
# resolve to the endpoint from inside the VPC.
data "aws_vpc_endpoint_service" "smtp" {
  service_name = "com.amazonaws.${var.region}.email-smtp"
}

resource "aws_security_group" "smtp_endpoint" {
  name        = "${local.name}-smtp-endpoint"
  description = "SES SMTP interface endpoint"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SMTP submission from the API only"
    from_port       = 587
    to_port         = 587
    protocol        = "tcp"
    security_groups = [aws_security_group.api.id]
  }

  tags = { Name = "${local.name}-smtp-endpoint" }
}

# Placed only in subnets whose AZ offers the service: email-smtp is not in
# every AZ (in us-east-1 today, a/c/d but not b), and naming an unsupported one
# fails the apply. One AZ, not two, because an interface endpoint bills per AZ
# and every subnet in the VPC can reach it; losing that AZ delays mail, which
# is already built to fail softly.
resource "aws_vpc_endpoint" "ses_smtp" {
  vpc_id              = aws_vpc.main.id
  service_name        = data.aws_vpc_endpoint_service.smtp.service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.smtp_endpoint.id]

  subnet_ids = slice([
    for subnet in aws_subnet.private : subnet.id
    if contains(data.aws_vpc_endpoint_service.smtp.availability_zones, subnet.availability_zone)
  ], 0, 1)

  tags = { Name = "${local.name}-ses-smtp" }
}
