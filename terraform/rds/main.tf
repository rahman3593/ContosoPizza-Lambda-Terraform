resource "aws_db_subnet_group" "rds-subnet-group" {
  name        = "${var.name}-rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = var.subnet_ids
}


resource "aws_db_instance" "postgres" {
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  identifier              = var.identifier
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.rds-subnet-group.name
  parameter_group_name    = var.parameter_group_name
  multi_az                = var.multi_az
  storage_type            = var.storage_type
  backup_retention_period = var.backup_retention_period 
  availability_zone       = var.availability_zone
  skip_final_snapshot     = true
  tags = {
    Name = "${var.name}-rds-instance"
  }
}
