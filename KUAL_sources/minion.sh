#!/usr/bin/env sh

# run gmplay depending upon config
# stop lab126_gui

NUM_SCREENS="$1"
SERVERIP="$2"
SERVERPORT="$3"
SCREENNUM="$4"


# Shutdown GUI and allow exit by bottom right-hand
/bin/ash /mnt/us/extensions/OkMonitor/oktouch-control.sh & 


if [ "$NUM_SCREENS" -eq "4" ]
then
	lipc-set-prop com.lab126.powerd preventScreenSaver 1 
	nc $SERVERIP $SERVERPORT | /mnt/us/extensions/OkMonitor/gmplay 
else
	lipc-set-prop com.lab126.powerd preventScreenSaver 1
	nc $SERVERIP $SERVERPORT | /mnt/us/extensions/OkMonitor/gmplay2singleHD $SCREENNUM

fi

lipc-set-prop com.lab126.powerd preventScreenSaver 0
eips -p
