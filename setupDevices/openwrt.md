# Set Up PI 4 OpenWRT

## Download Image

From
`https://downloads.openwrt.org/snapshots/targets/bcm27xx/bcm2711/openwrt-bcm27xx-bcm2711-rpi-4-ext4-factory.img.gz`

## Resize partition
mmcblk0p2 from 100 MiB from 104 to 208

## Set IP Address

```
uci set network.lan.proto='dhcp'
uci set system.@system[0].hostname='okmonitor'
uci commit 
reboot
```

## Install Packages 
```
opkg update
opkg install kmod-video-uvc ffmpeg gcc netcat screen procps-ng-pkill unzip
# Optional USB Networking
# Hint: No quicker...
# opkg install kmod-usb-net kmod-usb-net-cdc-ether
cd /tmp/
wget https://github.com/bmsleight/OkMonitor/archive/main.zip
unzip main
cp -r /tmp/OkMonitor-main/openwrt/*  /
cd /tmp/OkMonitor-main/gmvideo/
gcc /tmp/OkMonitor-main/gmvideo/raw2gmv.c -o /usr/bin/raw2gmv
gcc /tmp/OkMonitor-main/gmvideo/raw2gmv2single.c -o /usr/bin/raw2gmv2single
```


```
cd /root/
mkdir .ssh
dropbearkey  -t rsa -f .ssh/id_rsa
cp .ssh/id_rsa .ssh/id_dropbear
dropbearkey -y -f ".ssh/id_rsa" | grep "^ssh-rsa " > ".ssh/id_rsa.pub"
cat .ssh//id_rsa.pub
```

# Make image

```
$ sudo fdisk -lu /dev/mmcblk0
Disk /dev/mmcblk0: 14.9 GiB, 15980298240 bytes, 31211520 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xa9ec6a7b

Device         Boot  Start    End Sectors  Size Id Type
/dev/mmcblk0p1 *      8192 139263  131072   64M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      147456 598015  450560  220M 83 Linux

$ sudo dd bs=512 if=/dev/mmcblk0 of=okmonitor2.img count=598015
```

