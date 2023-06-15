module "vpc" {
  source             = "../terraform/vpc"
  name               = var.app_name
  availability_zones = data.aws_availability_zones.az.names
  cidr_block         = var.VPC_cidr_block
}

module "igw" {
  source         = "../terraform/igw"
  name           = var.app_name
  vpc_id         = module.vpc.vpc_id
  cidr_block     = var.IGW_cidr_block
  public_subnets = module.vpc.public_subnets[*].id
  depends_on     = [module.vpc]
}

module "nat" {
  source          = "../terraform/nat"
  name            = var.app_name
  vpc_id          = module.vpc.vpc_id
  cidr_block      = var.NAT_cidr_block
  subnet_id       = module.vpc.public_subnets[0].id
  private_subnets = concat(module.vpc.private_subnets[*].id, module.vpc.db_subnets[*].id)
  depends_on      = [module.vpc, module.igw]
}

module "rds" {
  source                  = "../terraform/rds"
  name                    = var.app_name
  subnet_ids              = module.vpc.db_subnets[*].id
  allocated_storage       = var.RDS_allocated_storage
  engine                  = var.RDS_engine
  engine_version          = var.RDS_engine_version
  instance_class          = var.RDS_instance_class
  identifier              = var.RDS_identifier
  db_name                 = var.RDS_db_name
  username                = var.RDS_username
  password                = var.RDS_password
  parameter_group_name    = var.RDS_parameter_group_name
  multi_az                = var.RDS_multi_az
  storage_type            = var.RDS_storage_type
  backup_retention_period = var.RDS_backup_retention_period
  availability_zone       = module.vpc.db_subnets[0].availability_zone
  skip_final_snapshot     = var.RDS_skip_final_snapshot
  depends_on              = [module.vpc]
}

module "lambda" {
  source     = "../terraform/lambda"
  name       = var.app_name
  vpc_id     = module.vpc.vpc_id
  handler    = var.Lambda_handler
  filename   = var.Lambda_filename
  runtime    = var.Lambda_runtime
  subnet_ids = module.vpc.private_subnets[*].id
  depends_on = [module.vpc]
}

module "api-gateway" {
  source        = "../terraform/api-gateway"
  name          = var.app_name
  function_name = module.lambda.function_name
  invoke_arn    = module.lambda.invoke_arn
  depends_on    = [module.lambda]
}