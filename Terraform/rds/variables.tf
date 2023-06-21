variable "subnet_ids" {
  type = list(string)
}
variable "allocated_storage" {
  type = number
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "identifier" {
  type = string
}
variable "db_name" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "parameter_group_name" {
  type = string
}
variable "multi_az" {
  type = string
}
variable "storage_type" {
  type = string
}
variable "backup_retention_period" {
  type = string
}
variable "availability_zone" {
  type = string
}
variable "skip_final_snapshot" {
  type = bool
  default = true
}
variable "db_subnet_group_name" {
  type = string
}