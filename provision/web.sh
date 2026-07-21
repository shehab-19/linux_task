#!/usr/bin/env bash

set -euo pipefail

SERVER_NAME="$1"
KEEPALIVED_ROLE="$2"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y nginx keepalived

# Create website directory
mkdir -p /var/www/lab

# Remove default NGINX site
rm -f /etc/nginx/sites-enabled/default

# Copy NGINX config and HTML page
cp "/vagrant/config/nginx/${SERVER_NAME}.conf" \
   "/etc/nginx/sites-available/${SERVER_NAME}.conf"

ln -sf "/etc/nginx/sites-available/${SERVER_NAME}.conf" \
       "/etc/nginx/sites-enabled/${SERVER_NAME}.conf"

cp "/vagrant/config/nginx/${SERVER_NAME}-index.html" \
   /var/www/lab/index.html

# Copy Keepalived config
mkdir -p /etc/keepalived

if [[ "$KEEPALIVED_ROLE" == "MASTER" ]]; then
    cp /vagrant/config/nginx/master.conf \
       /etc/keepalived/keepalived.conf
else
    cp /vagrant/config/nginx/backup.conf \
       /etc/keepalived/keepalived.conf
fi

# Test and restart services
nginx -t

systemctl enable nginx keepalived
systemctl restart nginx keepalived

echo "$SERVER_NAME configured successfully."