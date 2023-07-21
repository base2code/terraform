resource "aws_vpc" "haste_server-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.haste_server.id}"
  vpc      = true
}
output "instance_public_ip" {
  description = "Public IP address of the haste server instance"
  value       = aws_eip.ip-test-env.public_ip
}