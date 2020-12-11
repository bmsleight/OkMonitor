#!/usr/bin/env sh

# Add OpenWRT ssh key to kindle

#PRIMARY=$(nslookup okmonitor.lan | tail -n 1 | cut -d\  -f 3)
EXT_LOC=/mnt/us/extensions/OkMonitor/
WLANIP=$(ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

echo "restart=$WLANIP" | nc okmonitor.lan 10001
sleep 1 
fbink -pmhc -y -5 "Restarted OkMonitor Server"
