data "aws_availability_zones" "az" {
  state = "available"
}

data "aws_security_group" "default-sg" {
  vpc_id = module.vpc.vpc_id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}