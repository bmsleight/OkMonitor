#!/usr/bin/env sh

# Test OpenWRT 
TIP="192.168.1.86"

scp ../openwrt/etc/config/okmonitor  root@$TIP:/etc/config/
scp ../openwrt/etc/init.d/* root@$TIP:/etc/init.d/
scp ../openwrt/usr/bin/* root@$TIP:/usr/bin/

#On openwrt
#/etc/init.d/myservice enable

ssh root@$TIP "chmod +x /etc/init.d/okmonitor-listen-commands"
ssh root@$TIP "chmod +x /etc/init.d//okmonitor-broadcast"

# Install Test IPs
#echo "IP_1=192.168.1.65" | nc -N 192.168.1.86 10001 
#echo "IP_2=192.168.1.105" | nc -N 192.168.1.86 10001 
#echo "IP_3=192.168.1.106" | nc -N 192.168.1.86 10001 
#echo "IP_4=192.168.1.97" | nc -N 192.168.1.86 10001 

# Tmp config

scp ./tmp-config  root@$TIP:/etc/config/okmonitor
