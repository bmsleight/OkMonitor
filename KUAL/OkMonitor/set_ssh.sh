#!/usr/bin/env sh

# Add OpenWRT ssh key to kindle

PRIMARY="192.168.1.86"
EXT_LOC=/mnt/us/extensions/OkMonitor/
WLANIP=$(ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

eips -c

echo "sshid=$WLANIP" | nc $PRIMARY 10001
sleep 1 
wget http://192.168.1.86:10002 -O /tmp/sshid 2>/dev/null

SSHID=$(cat /tmp/sshid)

sleep 4 
if grep -F "$SSHID" /mnt/us/usbnet/etc/authorized_keys
then
    # code if found
    fbink -pmhc -y -5 "SSH Key already installed"
else
	fbink -pmhc -y -5 "Installing SSH Key - a reboot is also needed"
	cat /tmp/sshid >> /mnt/us/usbnet/etc/authorized_keys
	sleep 2
	reboot
fi
