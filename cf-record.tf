resource "cloudflare_record" "haste-base2code-dev" {
  zone_id = "a612b8224bf198c00ca048ec42a15ecf"
  name    = "haste"
  value   = aws_eip.ip-test-env.public_ip
  type    = "A"
  proxied = true
}