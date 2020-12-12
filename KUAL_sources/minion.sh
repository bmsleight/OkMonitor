#!/usr/bin/env sh

# run gmplay depending upon config

NUM_SCREENS="$1"
SERVERIP="$2"
SERVERPORT="$3"


if [ "$NUM_SCREENS" -eq "4" ]
then
	lipc-set-prop com.lab126.powerd preventScreenSaver 1 
	nc $SERVERIP $SERVERPORT | /mnt/us/extensions/OkMonitor/gmplay 
else
	lipc-set-prop com.lab126.powerd preventScreenSaver 1
	nc $SERVERIP $SERVERPORT | /mnt/us/extensions/OkMonitor/gmplay2single

fi

lipc-set-prop com.lab126.powerd preventScreenSaver 0
eips -p
