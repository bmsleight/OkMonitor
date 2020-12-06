#!/usr/bin/env sh

rm  /tmp/screen1.pipe
rm  /tmp/screen2.pipe
rm  /tmp/screen3.pipe
rm  /tmp/screen4.pipe

mkfifo /tmp/screen1.pipe
mkfifo /tmp/screen2.pipe
mkfifo /tmp/screen3.pipe
mkfifo /tmp/screen4.pipe


cat /tmp/screen1.pipe  | /root/raw2gmv  | netcat -l -p  5001 &
cat /tmp/screen2.pipe  | /root/raw2gmv  | netcat -l -p  5002 &
cat /tmp/screen3.pipe  | /root/raw2gmv  | netcat -l -p  5003 &
cat /tmp/screen4.pipe  | /root/raw2gmv  | netcat -l -p  5004 &


sleep 1

echo "Getting monitor IPs"

IP_1=$(nc -l -p 4001 2>&1)
# Need to check at this point if 1 or four monitors
echo "IP 1: $IP_1"

IP_2=$(nc -l -p 4002 2>&1)
echo "IP 2: $IP_2"

IP_3=$(nc -l -p 4003 2>&1)
echo "IP 3: $IP_3"

IP_4=$(nc -l -p 4004 2>&1)
echo "IP 4: $IP_4"


screen -dmS screen_1 -t screen_1 
screen -S screen_1 -p screen_1  -X stuff 'ssh  '$IP_1' "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5001 | /mnt/us/extensions/OkMonitor/gmplay" \r'


screen -dmS screen_2 -t screen_2 
screen -S screen_2 -p screen_2  -X stuff 'ssh  '$IP_2' "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5002 | /mnt/us/extensions/OkMonitor/gmplay" \r'

screen -dmS screen_3 -t screen_3 
screen -S screen_3 -p screen_3  -X stuff 'ssh  '$IP_3' "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5003 | /mnt/us/extensions/OkMonitor/gmplay" \r'

screen -dmS screen_4 -t screen_4 
screen -S screen_4 -p screen_4  -X stuff 'ssh  '$IP_4' "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5004 | /mnt/us/extensions/OkMonitor/gmplay" \r'

sleep 2


ffmpeg -re -f v4l2 -input_format yuyv422  -y -video_size 1024x768  -i /dev/video0  \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:0:0,scale=512:379,transpose=2,transpose=2" /tmp/screen1.pipe \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:512:0,scale=512:379" /tmp/screen2.pipe \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:0:379,scale=512:379,transpose=2,transpose=2" /tmp/screen3.pipe \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:512:379,scale=512:379" /tmp/screen4.pipe

screen -S screen_1 -p screen_1  -X kill
screen -S screen_2 -p screen_2  -X kill
screen -S screen_3 -p screen_3  -X kill
screen -S screen_4 -p screen_4  -X kill

killall netcat	

nc -w 6 -l -c -p 6001
nc -w 6 -l -c -p 6002
nc -w 6 -l -c -p 6003
nc -w 6 -l -c -p 6004
