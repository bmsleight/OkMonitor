#!/usr/bin/env sh

PRIMARY="192.168.1.126"
EXT_LOC=/mnt/us/extensions/OkMonitor/

# Switch off screen saver
lipc-set-prop com.lab126.powerd preventScreenSaver 1

# Display symbol
eips -g  ${EXT_LOC}info_monitor*$1*wait.png

# Wait until OpenWRT is ready 
# Connect to 4000 + $1
# Wait until connection

#COMMAND="nc $PRIMARY 400$1"
#until $COMMAND; do 
#    echo "Nope" >>${EXT_LOC}/1.log
#    sleep 2
#done


# We are connected to OpenWRT
eips -g  ${EXT_LOC}info_monitor$1.png

sleep 2

COMMAND="nc $PRIMARY 500$1"


# Connect to ffmpeg via netcat
$COMMAND | ${EXT_LOC}gmplay 1>${EXT_LOC}/3.log 2>&1


eips -q 

lipc-set-prop com.lab126.powerd preventScreenSaver 0 
