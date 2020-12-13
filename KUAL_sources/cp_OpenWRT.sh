#!/usr/bin/env sh

scp ../openwrt/etc/config/*  root@okmonitor.lan:/etc/config/
scp ../openwrt/etc/init.d/* root@okmonitor.lan:/etc/init.d/
scp ../openwrt/usr/bin/* root@okmonitor.lan:/usr/bin/
scp ../gmvideo/raw2* root@okmonitor.lan:/tmp/


#On openwrt
#/etc/init.d/myservice enable
# Actually don want to enable - best to let kindle start/stop it. 

ssh root@okmonitor.lan "chmod +x /etc/init.d/okmonitor-listen-commands"
ssh root@okmonitor.lan "chmod +x /etc/init.d//okmonitor-broadcast"
ssh root@okmonitor.lan "cd /tmp ; gcc raw2gmv.c -o raw2gmv ; mv raw2gmv /usr/bin/raw2gmv"
ssh root@okmonitor.lan "cd /tmp ; gcc raw2gmv2single.c -o raw2gmv2single ; mv raw2gmv2single /usr/bin/raw2gmv2single"


# Tmp config

#scp ./tmp-config  root@okmonitor.lan:/etc/config/okmonitor
