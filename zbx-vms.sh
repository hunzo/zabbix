#!/bin/bash
docker run --name zabbix-server-mysql -t \
    -e DB_SERVER_HOST="mysql-server" \
    -e MYSQL_DATABASE="zabbix" \
    -e MYSQL_USER="zabbix" \
    -e MYSQL_PASSWORD="zabbix_pwd" \
    -e MYSQL_ROOT_PASSWORD="root_pwd" \
    -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
    -e ZBX_STARTREPORTWRITERS="2" \
    -e ZBX_WEBSERVICEURL="http://zabbix-web-service:10053/report" \
    -e ZBX_STARTVMWARECOLLECTORS="8" \
    -e ZBX_VMWAREFREQUENCY="60" \
    -e ZBX_VMWAREPERFFREQUENCY="60" \
    -e ZBX_VMWARECACHESIZE="256M" \
    -e ZBX_VMWARETIMEOUT="120" \
    -e ZBX_CACHESIZE="256M" \
    --network=zabbix-net \
    -p 10051:10051 \
    --restart unless-stopped \
    -d zabbix/zabbix-server-mysql:alpine-6.2-latest