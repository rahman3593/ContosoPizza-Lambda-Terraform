variable "function_name" {
  type = string
}
variable "handler" {
  type = string
}
variable "runtime" {
  type = string
}
variable "filename" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "default_sg_id" {
  type = string
}
variable "role_name" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "envVariables" {
  type = map(string)
}
