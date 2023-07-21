#!/bin/bash
# shellcheck disable=SC2154
export AWS_ACCESS_KEY_ID=${aws_access_key_id}
export AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}
# cloudflare_origin_ca_root_certificate_base2code_dev
# cloudflare_origin_priv_key_base2code_dev
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo docker run --name hastebin -d -p 127.0.0.1:7777:7777 \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e STORAGE_TYPE=amazon-s3 \
  -e STORAGE_AWS_BUCKET=haste-s3-bucket \
  -e STORAGE_AWS_REGION=eu-central-1 \
  niklasnikki/haste-server-s3
sudo yum install nginx -y
mkdir /ssl
echo "${cloudflare_origin_ca_root_certificate_base2code_dev}" > /ssl/base2code.dev.pem
echo "${cloudflare_origin_priv_key_base2code_dev}" > /ssl/base2code.dev.priv.pem
cat >/etc/nginx/conf.d/haste.base2code.dev.conf <<EOL
server {
        server_name haste.base2code.dev;
        location / {
                 proxy_set_header  Host \$host;
                 proxy_set_header  X-Real-IP \$remote_addr;
                 proxy_set_header  X-Forwarded-Proto https;
                 proxy_set_header  X-Forwarded-For \$remote_addr;
                 proxy_set_header  X-Forwarded-Host \$remote_addr;
                 proxy_pass http://localhost:7777;
        }
        listen 443 ssl;
        ssl_certificate /ssl/base2code.dev.pem;
        ssl_certificate_key /ssl/base2code.dev.priv.pem;


        ssl_session_cache shared:le_nginx_SSL:10m;
        ssl_session_timeout 1440m;
        ssl_session_tickets off;

        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_prefer_server_ciphers off;
}

server {
    if (\$host = haste.base2code.dev) {
        return 301 https://\$host\$request_uri;
    }

    server_name haste.base2code.dev;
    listen 80;
    return 404;


}
EOL

sudo systemctl start nginx
sudo systemctl reload nginx

touch deployed