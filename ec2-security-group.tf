module "haste_server" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "haste_server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = aws_vpc.haste_server-env.id

  ingress_cidr_blocks = ["10.10.0.0/16"]
}