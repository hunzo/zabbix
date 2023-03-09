# Zabbix Install
## zabbix-proxy
```bash
docker run --name some-zabbix-proxy-sqlite3 -e ZBX_HOSTNAME=PROXY-01 -e ZBX_SERVER_HOST=20.100.200.101 -d zabbix/zabbix-proxy-sqlite3:6.4.0-alpine
```