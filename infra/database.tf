# Postgres 17 to match server/compose.yaml and the Testcontainers image — a
# schema that passes tests on 17 and runs on something else in production is
# the kind of difference that only shows up under load.

resource "random_password" "db" {
  length = 32
  # RDS rejects '/', '@', '"' and spaces in a master password.
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "main" {
  identifier     = "${local.name}-db"
  engine         = "postgres"
  engine_version = "17"
  instance_class = var.db_instance_class

  db_name  = "secplus"
  username = var.db_username
  password = random_password.db.result

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false

  # Single-AZ: this is a study app, and Multi-AZ doubles the bill.
  multi_az = false

  backup_retention_period = 7
  # Flyway owns the schema, but the *data* is users' study history and there is
  # no other copy of it. Seven days of automated backups is the cheapest
  # insurance available.
  skip_final_snapshot       = false
  final_snapshot_identifier = "${local.name}-db-final"
  deletion_protection       = true

  auto_minor_version_upgrade = true
  apply_immediately          = false

  tags = { Name = "${local.name}-db" }
}

# Secrets live in SSM rather than being passed to App Runner as plain
# environment values, so they are not readable from the service's configuration
# page or a describe-service call.
resource "aws_ssm_parameter" "db_url" {
  name  = "/${local.name}/db/url"
  type  = "SecureString"
  value = "jdbc:postgresql://${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
}

resource "aws_ssm_parameter" "db_user" {
  name  = "/${local.name}/db/user"
  type  = "SecureString"
  value = var.db_username
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${local.name}/db/password"
  type  = "SecureString"
  value = random_password.db.result
}

# The signing key for access tokens.
#
# This must be stable across deploys. TokenConfig generates a random key when
# the secret is blank, which is fine locally but in production means every
# container restart invalidates every session — users are silently signed out
# on each deploy and it reads as a bug rather than a setting.
# application-prod.properties has no default for it, so a container starting
# without this fails loudly instead.
resource "random_password" "jwt_secret" {
  length  = 64
  special = false
}

resource "aws_ssm_parameter" "jwt_secret" {
  name  = "/${local.name}/auth/jwt-secret"
  type  = "SecureString"
  value = random_password.jwt_secret.result

  lifecycle {
    # Rotating this signs everyone out. It should be a deliberate act, not a
    # side effect of an unrelated apply.
    ignore_changes = [value]
  }
}
