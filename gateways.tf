resource "aws_internet_gateway" "haste_server-env-gw" {
  vpc_id = aws_vpc.haste_server-env.id
  tags = {
    Name = "haste_server-env-gw"
  }
}