variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "cidr_block" {
  type    = string
}

variable "private_subnets" {
  type    = list(string)
}