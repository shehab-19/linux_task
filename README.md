# Tech Stack

- Ubuntu 22.04 LTS
- Vagrant
- VirtualBox
- NGINX
- Keepalived (VRRP)
- BIND9 DNS
- Bash

# Results

| Machine | Role | IP Address |
| --- | --- | --- |
| `dns1` | BIND9 DNS server | `192.168.56.10` |
| `web1` | NGINX master | `192.168.56.11` |
| `web2` | NGINX backup | `192.168.56.12` |
| Virtual IP | Keepalived service address | `192.168.56.20` |

- `test.com` and `www.test.com` resolve to the virtual IP `192.168.56.20`.
- NGINX is served by `web1` as the master node.
- Traffic automatically fails over to `web2` when `web1` is unavailable.

## DNS Lookup

![DNS lookup through BIND9](screenshots/dig_via_the_dns_server.png)

## Master Server

![Domain resolving to the master server](screenshots/resloving_the_master.png)

## Connectivity Test

![Connectivity test](screenshots/ping.png)

## Automatic Failover

![Failover after stopping web1](screenshots/after_halting_web1.png)
