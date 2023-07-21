/*
resource "null_resource" "remote"{
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("ssh-key/id_rsa")
    host  = aws_eip.ip-test-env.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo docker run --name hastebin -d -p 7777:80 -e STORAGE_TYPE=file -v /data:/app/data rlister/hastebin"
    ]
  }
}*/
