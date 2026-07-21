#!/usr/bin/env bash

set -euo pipefail

DOMAIN="${1:-}"

if [[ -z "$DOMAIN" ]]; then
    echo "Usage: dns.sh <domain>"
    exit 1
fi

echo "Installing BIND9..."

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y bind9 bind9-utils dnsutils

echo "Creating BIND zone directory..."

install -d -m 0755 /etc/bind/zones

echo "Copying BIND configuration files..."

# copy with permissions set to 0644

install -m 0644 \
    /vagrant/config/bind/named.conf.local \
    /etc/bind/named.conf.local

install -m 0644 \
    /vagrant/config/bind/named.conf.options \
    /etc/bind/named.conf.options

install -m 0644 \
    /vagrant/config/bind/db.test.com \
    /etc/bind/zones/db.test.com

echo "Checking BIND configuration..."

named-checkconf
named-checkzone "$DOMAIN" /etc/bind/zones/db.test.com

echo "Starting BIND9..."

systemctl enable named
systemctl restart named

echo "BIND9 provisioning completed."