# Set Up PI 4 OpenWRT

## Download Image

From
`https://downloads.openwrt.org/snapshots/targets/bcm27xx/bcm2711/openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img.gz`

## Resize partition


## Set IP Address

```
uci set network.lan.proto='dhcp'
uci set system.@system[0].hostname='okmonitor'
uci commit 
service network restart
```

## Install Packages 
```
opkg update
opkg install kmod-video-uvc ffmpeg gcc netcat screen procps-ng-pkill 
```


```
# From Dev machine
#ssh root@okmonitor.lan "cd /tmp ; gcc raw2gmv.c -o raw2gmv ; mv raw2gmv /usr/bin/raw2gmv"
#ssh root@okmonitor.lan "cd /tmp ; gcc raw2gmv2single.c -o raw2gmv2single ; mv raw2gmv2single /usr/bin/raw2gmv2single"


mkdir .ssh
dropbearkey  -t rsa -f .ssh/id_rsa
cp .ssh/id_rsa .ssh/id_dropbear
dropbearkey -y -f ".ssh/id_rsa" | grep "^ssh-rsa " > ".ssh/id_rsa.pub"
cat "${KEY_DIR}/id_rsa.pub"
```


