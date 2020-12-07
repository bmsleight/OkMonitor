#!/usr/bin/env sh

# Add OpenWRT ssh key to kindle

PRIMARY="192.168.1.86"
EXT_LOC=/mnt/us/extensions/OkMonitor/
WLANIP=$(ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

echo "restart=$WLANIP" | nc $PRIMARY 10001
sleep 1 
fbink -pmhc -y -5 "Restarted OkMonitor Server"
