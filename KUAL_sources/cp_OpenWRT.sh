#!/usr/bin/env sh

# Test OpenWRT 
#TIP="192.168.1.79"

scp ../openwrt/etc/config/okmonitor  root@okmonitor.lan:/etc/config/
scp ../openwrt/etc/init.d/* root@okmonitor.lan:/etc/init.d/
scp ../openwrt/usr/bin/* root@okmonitor.lan:/usr/bin/

#On openwrt
#/etc/init.d/myservice enable

ssh root@okmonitor.lan "chmod +x /etc/init.d/okmonitor-listen-commands"
ssh root@okmonitor.lan "chmod +x /etc/init.d//okmonitor-broadcast"


# Tmp config

scp ./tmp-config  root@okmonitor.lan:/etc/config/okmonitor
