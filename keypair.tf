resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCbw5tOK1A1Yf2a5Zd78s6gNwwcWbMyGiGMOKFVTJaDRhXggYKDmUOo379HsvKTQVjaFQ1szqcg3FiadwrBWRTrmCjVKIIpeIO+1VkAeg0cS0jKQsCmAI7V56endWwjfvFqbpybuZXDlQwfn1MKSMXAV9CJNFmyA3lqER9Bp3xMLQw/6E1ROYWJo23TGtZRf3mGIBoBDPMwJsKamECn+ZFHUxww3AZuuzd4FZb0dNwVhtZzo2f6pS/G1Jxx5LSSBv4eSTdW7Sa98k1oJvAHO+p4x0WtIuONcdUcjLfhYSL/0tJmtiQuIiyMvwqPudMAWrf+zZqJjkX29J+yZmfiTMTvjxyJ69jHlM9V8FvI6nFkN2/wp4vLgK17HaC6W5qequOb42f+ABcJRSwKOM+F+7gs0eyU82gSv9wEcll86jSsUvbEIzCRkan0jNJadiHXktn0Ai9tmLzX/Y0jRuDZhIlzT4hAewRSLlEEUsPyigv3OV5kojIOHJer4JXYpZZZ40= niklasgrenningloh@MacBook-Pro-von-Niklas.local"
}

/*
resource "tls_private_key" "terraform-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}*/
