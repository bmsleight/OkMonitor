# Set Up PI 4 OpenWRT

## Download Image

From
`https://downloads.openwrt.org/snapshots/targets/bcm27xx/bcm2711/openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img.gz`

## Resize partition


## Set IP Address

```
uci set network.lan.proto='dhcp'
uci commit 
service network restart
```

## Install Packages 
```
opkg update
opkg install kmod-video-uvc ffmpeg gcc netcat screen
```

From dev machine
`#scp ./gmvideo/raw2gmv.c root@192.168.1.86:./`
`#scp ./MinionScripts/masterStream.sh root@192.168.1.86:./`

```
gcc raw2gmv.c -o raw2gmv

mkdir .ssh
dropbearkey  -t rsa -f .ssh/id_rsa
cp .ssh/id_rsa .ssh/id_dropbear
dropbearkey -y -f ".ssh/id_rsa" | grep "^ssh-rsa " > ".ssh/id_rsa.pub"
cat "${KEY_DIR}/id_rsa.pub"
```

##  Copy key to each of the kindles
`#/mnt/us/usbnet/etc/authorized_keys`
