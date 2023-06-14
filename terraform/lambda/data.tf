data "aws_security_group" "default-sg" {
  vpc_id = var.vpc_id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}