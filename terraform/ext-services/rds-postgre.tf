resource "aws_security_group" "ptfe-pg" {
  name        = "ptfe-pg"
  description = "Allow incoming traffic for PTFE Postgre SQL instance."
  vpc_id      = var.vpc_id

  tags = var.common_tags
}

resource "aws_security_group_rule" "allow_pg_default" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ptfe-pg.id
}

resource "aws_db_subnet_group" "ptfe-pg" {
  name_prefix = "ptfe-"
  subnet_ids  = var.pg_subnet_ids
  description = "A subnet group for the PTFE PostgreSQL RDS instance."

  tags = var.common_tags
}

resource "aws_db_instance" "ptfe" {
  identifier_prefix       = var.pg_identifier_prefix
  allocated_storage       = var.pg_allocated_storage
  storage_type            = var.pg_storage_type
  max_allocated_storage   = 0
  engine                  = "postgres"
  engine_version          = var.pg_engine_version
  instance_class          = var.pg_instance_class
  name                    = var.pg_db_name
  username                = var.pg_username
  password                = var.pg_password
  parameter_group_name    = var.pg_parameter_group_name
  vpc_security_group_ids  = [aws_security_group.ptfe-pg.id]
  db_subnet_group_name    = aws_db_subnet_group.ptfe-pg.name
  multi_az                = var.pg_multi_az
  publicly_accessible     = false
  deletion_protection     = var.pg_deletion_protection
  backup_retention_period = var.pg_backup_retention_period
  skip_final_snapshot     = true

  tags = var.common_tags
}

