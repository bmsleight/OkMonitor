#!/usr/bin/env sh

# Add OpenWRT ssh key to kindle

#PRIMARY=$(nslookup okmonitor.lan | tail -n 1 | cut -d\  -f 3)
EXT_LOC=/mnt/us/extensions/OkMonitor/
WLANIP=$(ifconfig wlan0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

COMMAND="$1"
MONITOR="$2"


set_reset() {
	echo "restart=$WLANIP" | nc okmonitor.lan 10001
	sleep 1 
	fbink -pmhc -y -5 "Restarted OkMonitor Server"
}

set_sshid() {
	eips -c
	echo "sshid=$WLANIP" | nc okmonitor.lan 10001
	sleep 1 
	wget http://okmonitor.lan:10002 -O /tmp/sshid 2>/dev/null

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
}

monitor() {
	eips -g  ${EXT_LOC}info_monitor*$MONITOR*wait.png
	sleep 5
	eips -g  ${EXT_LOC}info_monitor*$MONITOR*wait.png

	# okmonitor-okmonitor-listen-commands listens on port 10001 for commands
	echo "IP_$MONITOR=$WLANIP" | nc okmonitor.lan 10001

	# Set as Monitor
	eips -g  ${EXT_LOC}info_monitor$MONITOR.png
}

set_number() {
	echo "NUM_SCREENS=$MONITOR" | nc okmonitor.lan 10001
	sleep 1 
	fbink -pmhc -y -5 "Set number of monitors as $MONITOR"
	sleep 2
	set_reset
}

get_config() {
	echo "config=$WLANIP" | nc okmonitor.lan 10001
	sleep 1 
	wget http://okmonitor.lan:10002 -O /tmp/config 2>/dev/null
	CONFIG=$(cat /tmp/config)
	fbink -pmhc -M "$CONFIG"
}

screenoff() {
	sleep 2 	
	fbink -pmhc -M "Screensaver off"
	lipc-set-prop com.lab126.powerd preventScreenSaver 0
}

case "$1" in
	reset)
		set_reset
		;;
	sshid)
		set_sshid
		;;
	monitor)
		monitor $2
		;;
	number)
		set_number
		;;
	config)
		get_config
		;;
	screenoff)
		screenoff
		;;
	*)
		echo "Command not recognised"
esac

