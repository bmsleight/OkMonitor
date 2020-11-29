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

#192.168.1.65 = 1
#192.168.1.105 = 2
#192.168.1.106 = 3
#192.168.1.97 = 4
# need to confirm keys


screen -dmS screen_1 -t screen_1 
screen -S screen_1 -p screen_1  -X stuff 'ssh  root@192.168.1.65 "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5001 | /mnt/us/extensions/OkMonitor/gmplay" \r'

screen -dmS screen_2 -t screen_2 
screen -S screen_2 -p screen_2  -X stuff 'ssh  root@192.168.1.105 "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5002 | /mnt/us/extensions/OkMonitor/gmplay" \r'

screen -dmS screen_3 -t screen_3 
screen -S screen_3 -p screen_3  -X stuff 'ssh  root@192.168.1.106 "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5003 | /mnt/us/extensions/OkMonitor/gmplay" \r'

screen -dmS screen_4 -t screen_4 
screen -S screen_4 -p screen_4  -X stuff 'ssh  root@192.168.1.97 "lipc-set-prop com.lab126.powerd preventScreenSaver 1; nc 192.168.1.86 5004 | /mnt/us/extensions/OkMonitor/gmplay" \r'

sleep 2

#ffmpeg -re -f v4l2 -input_format mjpeg  -y -video_size 1600x1200  -i /dev/video0  \

# Input video size - makes huge difference on processing tiem for 4 streams

# Quality of 1600x1200 vs 1024x768 is a real difference 
# High quality - 1600x1200, four screens @ 3 fps max
# Medium quality - 1024x768, four screens @ 10 fps max


ffmpeg -re -f v4l2 -input_format yuyv422  -y -video_size 1024x768  -i /dev/video0  \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:0:0,scale=512:379,transpose=2,transpose=2" /tmp/screen1.pipe \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:512:0,scale=512:379" /tmp/screen2.pipe \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:0:379,scale=512:379,transpose=2,transpose=2" /tmp/screen3.pipe \
	-pix_fmt gray -r 6 -f rawvideo  -filter:v "crop=512:379:512:379,scale=512:379" /tmp/screen4.pipe

#ffmpeg -re -f v4l2 -input_format mjpeg  -y -video_size 1600x1200  -i /dev/video0  \
#	-pix_fmt gray -r 8 -f rawvideo  -filter:v "crop=800:600:0:0,scale=512:379,transpose=2,transpose=2" /tmp/screen1.pipe \
#	-pix_fmt gray -r 8 -f rawvideo  -filter:v "crop=800:600:800:0,scale=512:379" /tmp/screen2.pipe \
#	-pix_fmt gray -r 8 -f rawvideo  -filter:v "crop=800:600:0:600,scale=512:379,transpose=2,transpose=2" /tmp/screen3.pipe \
#	-pix_fmt gray -r 8 -f rawvideo  -filter:v "crop=800:600:800:600,scale=512:379" /tmp/screen4.pipe

#ffmpeg -re -f v4l2 -input_format mjpeg  -y -video_size 1024x768  -i /dev/video0  \
#	-pix_fmt gray -r 12 -f rawvideo  -filter:v "crop=512:379:0:0,scale=512:379,transpose=2,transpose=2" /tmp/screen1.pipe \
#	-pix_fmt gray -r 12 -f rawvideo  -filter:v "crop=512:379:512:0,scale=512:379" /tmp/screen2.pipe \
#	-pix_fmt gray -r 12 -f rawvideo  -filter:v "crop=512:379:0:379,scale=512:379,transpose=2,transpose=2" /tmp/screen3.pipe \
#	-pix_fmt gray -r 12 -f rawvideo  -filter:v "crop=512:379:512:379,scale=512:379" /tmp/screen4.pipe


screen -S screen_1 -p screen_1  -X kill
screen -S screen_2 -p screen_2  -X kill
screen -S screen_3 -p screen_3  -X kill
screen -S screen_4 -p screen_4  -X kill

killall netcat	
