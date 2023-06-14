variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "app_name" {
  type = string
}

# VPC
variable "VPC_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

# IGW
variable "IGW_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

# NAT
variable "NAT_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

# RDS
variable "RDS_allocated_storage" {
  type = number
}
variable "RDS_engine" {
  type = string
}
variable "RDS_engine_version" {
  type = string
}
variable "RDS_instance_class" {
  type = string
}
variable "RDS_identifier" {
  type = string
}
variable "RDS_db_name" {
  type = string
}
variable "RDS_username" {
  type = string
}
variable "RDS_password" {
  type = string
}
variable "RDS_parameter_group_name" {
  type = string
}
variable "RDS_multi_az" {
  type = string
}
variable "RDS_storage_type" {
  type = string
}
variable "RDS_backup_retention_period" {
  type = string
}
variable "RDS_skip_final_snapshot" {
  type    = bool
  default = true
}

# Lambda
variable "Lambda_handler" {
  type = string
}
variable "Lambda_runtime" {
  type = string
}
variable "Lambda_filename" {
  type = string
}