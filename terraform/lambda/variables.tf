variable "name" {
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
variable "subnet_ids" {
  type = list(string)
}
