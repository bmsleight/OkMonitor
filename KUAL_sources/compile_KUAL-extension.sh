#!/usr/bin/env sh

function cptestk {
	# push to test kindle
	IP_1=192.168.1.33
	IP_2=192.168.1.124
	IP_3=192.168.1.74
	IP_4=192.168.1.65

	ssh root@$IP_1 "rm -r /mnt/us/extensions/OkMonitor"
	ssh root@$IP_2 "rm -r /mnt/us/extensions/OkMonitor"
	ssh root@$IP_3 "rm -r /mnt/us/extensions/OkMonitor"
	ssh root@$IP_4 "rm -r /mnt/us/extensions/OkMonitor"

	scp -r ../KUAL/OkMonitor root@$IP_1:/mnt/us/extensions/
	scp -r ../KUAL/OkMonitor root@$IP_2:/mnt/us/extensions/
	scp -r ../KUAL/OkMonitor root@$IP_3:/mnt/us/extensions/
	scp -r ../KUAL/OkMonitor root@$IP_4:/mnt/us/extensions/
	
}

scp oktouch.c pi@picompile.lan:/home/pi/
scp ../gmvideo/gmplay*  pi@picompile.lan:/home/pi/
#ssh pi@picompile.lan 'gcc -Wl,--dynamic-linker -Wl,/lib/ld-linux.so.3 gmplay2single.c -o gmplay2single'
ssh pi@picompile.lan 'gcc -Wl,--dynamic-linker -Wl,/lib/ld-linux.so.3 gmplay2singleHD.c -o gmplay2singleHD'
ssh pi@picompile.lan 'gcc -Wl,--dynamic-linker -Wl,/lib/ld-linux.so.3 gmplay.c -o gmplay'
ssh pi@picompile.lan 'gcc -Wl,--dynamic-linker -Wl,/lib/ld-linux.so.3 oktouch.c -o oktouch'

scp pi@picompile.lan:/home/pi/gmplay2singleHD ./
scp pi@picompile.lan:/home/pi/gmplay ./
scp pi@picompile.lan:/home/pi/oktouch ./


/bin/bash images.sh
rm ../KUAL/OkMonitor/*
cp info_* ../KUAL/OkMonitor/
#cp ../MinionScripts/listerMinion.sh ../KUAL/OkMonitor/
#cp ./set_monitor.sh ../KUAL/OkMonitor/
#cp ./set_ssh.sh ../KUAL/OkMonitor/
#cp ./set_reset.sh ../KUAL/OkMonitor/
#cp ./set_reset.sh ../KUAL/OkMonitor/
cp okmonitor-control.sh ../KUAL/OkMonitor/
cp minion.sh  ../KUAL/OkMonitor/
cp config.xml ../KUAL/OkMonitor/
cp menu.json ../KUAL/OkMonitor/

# get gmplay from pi compler
#scp pi@picompile.lan:./gmplay ./
cp ./gmplay* ../KUAL/OkMonitor/
cp ./oktouch* ../KUAL/OkMonitor/



#cptestk 
