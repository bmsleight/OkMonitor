#!/usr/bin/env sh

# Set Monitor $1

PRIMARY="192.168.1.86"
EXT_LOC=/mnt/us/extensions/OkMonitor/
WLANIP=$(ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

eips -g  ${EXT_LOC}info_monitor*$1*wait.png
sleep 5
eips -g  ${EXT_LOC}info_monitor*$1*wait.png

# okmonitor-okmonitor-listen-commands listens on port 10001 for commands
echo "IP_$1=$WLANIP" | nc $PRIMARY 10001

# Set as Monitor
eips -g  ${EXT_LOC}info_monitor$1.png
