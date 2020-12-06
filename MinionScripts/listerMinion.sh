#!/usr/bin/env sh

PRIMARY="192.168.1.86"
EXT_LOC=/mnt/us/extensions/OkMonitor/
WLANIP=$(ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

lipc-set-prop com.lab126.powerd preventScreenSaver 1
eips -g  ${EXT_LOC}info_monitor*$1*wait.png

NC="nc: can't connect to remote host"
until [ -z "$NC" ]; do
    eips -g  ${EXT_LOC}info_monitor*$1*wait.png
    sleep 2
    NC=$(echo "$WLANIP"  | nc 192.168.1.86 400$1 2>&1)
done

# We have sent the IP Address to OpenWRT
eips -g  ${EXT_LOC}info_monitor$1.png


# Wait until finished then show checker board
# Finished is signaled by openWRT - nc -w 6 -l -c -p 600$1
NC="nc: can't connect to remote host"
until [ -z "$NC" ]; do
    sleep 3
    NC=$(echo "$WLANIP"  | nc 192.168.1.86 600$1 2>&1)
done
eips -q 
lipc-set-prop com.lab126.powerd preventScreenSaver 0
