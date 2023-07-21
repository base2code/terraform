data "cloudflare_ip_ranges" "cloudflare" {}

resource "aws_security_group" "haste-server-sg" {
  name = "haste-server-sg"
  vpc_id = "${aws_vpc.haste_server-env.id}"
  ingress {
    cidr_blocks = concat(
      data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks
    )
    ipv6_cidr_blocks = concat(
      data.cloudflare_ip_ranges.cloudflare.ipv6_cidr_blocks
    )
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}