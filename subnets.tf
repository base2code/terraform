resource "aws_subnet" "haste_server-subnet" {
  cidr_block = "${cidrsubnet(aws_vpc.haste_server-env.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.haste_server-env.id}"
  availability_zone = "eu-central-1a"
}

resource "aws_route_table" "route-table-haste_server-env" {
  vpc_id = "${aws_vpc.haste_server-env.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.haste_server-env-gw.id}"
  }
  tags = {
    Name = "test-env-route-table"
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.haste_server-subnet.id}"
  route_table_id = "${aws_route_table.route-table-haste_server-env.id}"
}