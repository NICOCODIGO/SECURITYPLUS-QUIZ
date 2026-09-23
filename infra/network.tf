# The VPC exists for one reason: App Runner cannot reach a private RDS instance
# without a VPC connector, and RDS should not be public.
#
# There is deliberately NO NAT gateway. A VPC connector routes App Runner's
# outbound traffic through these subnets, which normally forces a NAT at roughly
# $32/month — often the largest line on a small account's bill. This app makes
# no outbound internet calls: no mailer, no third-party APIs, no webhooks. It
# talks to RDS and nothing else. If something here ever does need the internet,
# that is the moment to add a NAT, not before.

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
