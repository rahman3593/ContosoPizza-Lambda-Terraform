region         = "eu-central-1"
app_name       = "abdul-infra-test"
VPC_cidr_block = "10.0.0.0/16"
IGW_cidr_block = "0.0.0.0"
NAT_cidr_block = "0.0.0.0"

# RDS
RDS_allocated_storage       = 10
RDS_engine                  = "postgres"
RDS_engine_version          = "14.7"
RDS_instance_class          = "db.t3.micro"
RDS_identifier              = "postgres"
RDS_db_name                 = "postgres"
RDS_username                = "pgadmin"
RDS_password                = "qwertyqwerty"
RDS_parameter_group_name    = "default.postgres14"
RDS_multi_az                = "false"
RDS_storage_type            = "gp2"
RDS_backup_retention_period = 30
RDS_skip_final_snapshot     = true

# Lambda
Lambda_runtime  = "dotnet6"
Lambda_handler  = "ContosoPizza"
Lambda_filename = "../ContosoPizza/bin/net6.0/publish/Archive.zip"
