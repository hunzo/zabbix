# Zabbix Install
## zabbix-proxy
```bash
docker run \
    --name some-zabbix-proxy-sqlite3 \
    --restart always \
    -e ZBX_HOSTNAME=ZBX-PROXY-DMZ1 \
    -e ZBX_SERVER_HOST=10.100.100.145 \
    -d \
    zabbix/zabbix-proxy-sqlite3:6.4.0-alpine
```
## Line webhook
### create line Messaging Api
- Your user ID ex. `U8a80cc40b32xxxxxx`
- Channel access token ex. `UNr74ZHIYnqbf5GOSy+GTxLX2coF5HrdHE4qmr9f1Gw7Kc6wDprOiHPrtykieJOb3b3WB6wFi0tC`
- setting Alerts > Media Types,  Line webhook , bot_token=Chanel access token, send_to=ling user ID, zabbix_url=http://x.x.x.x
- setting Alerts > Actions > create action
    - Action conditions trigger sererity equal Not Classified
    - Operation 3 
        ```
        subject: {HOST.NAME}
        Message: 
        Timestamp: {EVENT.TIME}
        Problem: {EVENT.NAME}
        Status: {EVENT.STATUS}
        RecoveryTime: {EVENT.RECOVERY.TIME}
        ```
- Users > Users > Media (Line webhoook)
## zabbix generate report
- set fontend https://xxx.domain
##
```
ZBX_TLSACCEPT=unencrypted
ZBX_IGNOREURLCERTERRORS=0
```


