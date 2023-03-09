#!/bin/bash

docker network create --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20 zabbix-net

docker run --name mysql-server -t \
    -e MYSQL_DATABASE="zabbix" \
    -e MYSQL_USER="zabbix" \
    -e MYSQL_PASSWORD="zabbix_pwd" \
    -e MYSQL_ROOT_PASSWORD="root_pwd" \
    --network=zabbix-net \
    --restart unless-stopped \
    -d mysql:8.0 \
    --character-set-server=utf8 --collation-server=utf8_bin \
    --default-authentication-plugin=mysql_native_password

docker run --name zabbix-java-gateway -t \
    --network=zabbix-net \
    --restart unless-stopped \
    -d zabbix/zabbix-java-gateway:alpine-6.4-latest

docker run --name zabbix-server-mysql -t \
    -e DB_SERVER_HOST="mysql-server" \
    -e MYSQL_DATABASE="zabbix" \
    -e MYSQL_USER="zabbix" \
    -e MYSQL_PASSWORD="zabbix_pwd" \
    -e MYSQL_ROOT_PASSWORD="root_pwd" \
    -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
    -e ZBX_STARTREPORTWRITERS="2" \
    -e ZBX_WEBSERVICEURL="http://zabbix-web-service:10053/report" \
    --network=zabbix-net \
    -p 10051:10051 \
    --restart unless-stopped \
    -d zabbix/zabbix-server-mysql:alpine-6.4-latest

docker run \
    --name zabbix-web-service \
    -e ZBX_ALLOWEDIP="zabbix-server-mysql" \
    --cap-add=SYS_ADMIN \
    --network=zabbix-net \
    --restart unless-stopped \
    -d zabbix/zabbix-web-service:alpine-6.4-latest


docker run --name zabbix-web-nginx-mysql -t \
    -e ZBX_SERVER_HOST="zabbix-server-mysql" \
    -e DB_SERVER_HOST="mysql-server" \
    -e MYSQL_DATABASE="zabbix" \
    -e MYSQL_USER="zabbix" \
    -e MYSQL_PASSWORD="zabbix_pwd" \
    -e MYSQL_ROOT_PASSWORD="root_pwd" \
    --network=zabbix-net \
    -p 80:8080 \
    --restart unless-stopped \
    -d zabbix/zabbix-web-nginx-mysql:alpine-6.4-latest