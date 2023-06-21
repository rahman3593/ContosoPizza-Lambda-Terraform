region   = "eu-central-1"
app_name = "abdul-infra-test"

# VPC
VPC_name       = "infra-test-vpc"
VPC_cidr_block = "10.0.0.0/16"

# IGW
IGW_name = "infra-test-igw"
#IGW_cidr_block = "0.0.0.0"

# API Gateway
API_gateway_name       = "infra-test-api-gateway"
API_gateway_path_part  = "pizza"
API_gateway_stage_name = "dev"

# NAT
NAT_name = "infra-test-nat"
#NAT_cidr_block = "0.0.0.0"

# RDS
RDS_allocated_storage       = 10
RDS_engine                  = "postgres"
RDS_engine_version          = "14.7"
RDS_instance_class          = "db.t3.micro"
RDS_identifier              = "postgres"
RDS_db_name                 = "ContosoPizza"
RDS_username                = "pgadmin"
RDS_password                = "qwertyqwerty"
RDS_parameter_group_name    = "default.postgres14"
RDS_multi_az                = "false"
RDS_storage_type            = "gp2"
RDS_backup_retention_period = 30
RDS_skip_final_snapshot     = true
RDS_db_subnet_group_name    = "infra-test-rds-subnet-grp"

# Lambda
Lambda_function_name = "infra-test-lambda"
Lambda_runtime       = "dotnet6"
Lambda_handler       = "ContosoPizza"
Lambda_role_name     = "infra-test-lambda-role"
Lambda_filename      = "../ContosoPizza/bin/Release/net6.0/publish/ContosoPizza.zip"
