#!/usr/bin/env sh

rm ../KUAL/OkMonitor/*

/bin/bash images.sh
cp info_* ../KUAL/OkMonitor/
cp ../MinionScripts/listerMinion.sh ../KUAL/OkMonitor/
cp config.xml ../KUAL/OkMonitor/
cp menu.json ../KUAL/OkMonitor/

# get gmplay from pi compler
#scp pi@picompile.lan:./gmplay ./
cp ./gmplay ../KUAL/OkMonitor/


# push to test kindle
scp -r ../KUAL/OkMonitor root@192.168.1.65:/mnt/us/extensions/
scp -r ../KUAL/OkMonitor root@192.168.1.105:/mnt/us/extensions/
scp -r ../KUAL/OkMonitor root@192.168.1.106:/mnt/us/extensions/
scp -r ../KUAL/OkMonitor root@192.168.1.97:/mnt/us/extensions/


#192.168.1.65 = 1
#192.168.1.105 = 2
#192.168.1.106 = 3
#192.168.1.97 = 4

#cp_OpenWRT.sh
