#!/usr/bin/env sh

# run gmplay depending upon config

/sbin/stop lab126_gui

fbink -f -i /mnt/us/extensions/OkMonitor/info_monitor_close.png

/mnt/us/extensions/OkMonitor/oktouch

# Exited out of above by press bottom left
# Kill process
killall nc

/sbin/start lab126_gui
