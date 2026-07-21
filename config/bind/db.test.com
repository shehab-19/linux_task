$TTL 3600

@   IN  SOA  ns1.test.com. admin.test.com. (
        2026072001
        3600
        1800
        604800
        86400
)

@       IN  NS      ns1.test.com.

ns1     IN  A       192.168.56.10

@       IN  A       192.168.56.20
www     IN  A       192.168.56.20
