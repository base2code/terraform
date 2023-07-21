resource "aws_instance" "haste_server" {
  ami           = "ami-07ce6ac5ac8a0ee6f"
  instance_type = "t2.nano"
  key_name = "terraform-key"
  security_groups = [aws_security_group.haste-server-sg.id]
  subnet_id = aws_subnet.haste_server-subnet.id
#  user_data_replace_on_change = true
  user_data = templatefile("ec2-provision-haste.sh", {
    aws_access_key_id = aws_iam_access_key.s3_user_key.id,
    aws_secret_access_key = aws_iam_access_key.s3_user_key.secret,
    cloudflare_origin_ca_root_certificate_base2code_dev = file("creds/cf-certificate/haste.base2code.dev.pem")
    cloudflare_origin_priv_key_base2code_dev = file("creds/cf-certificate/haste.base2code.dev.priv.pem")
  })

  tags = {
    Name = "Haste-Server"
  }
}