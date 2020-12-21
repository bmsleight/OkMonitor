#!/usr/bin/env sh

# run gmplay depending upon config

/sbin/stop lab126_gui

/mnt/us/extensions/OkMonitor/oktouch

# Exited out of above by press bottom right
# Kill process
killall nc

/sbin/start lab126_gui
