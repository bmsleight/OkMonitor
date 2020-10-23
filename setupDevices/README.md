Reset Paper White

## 1 - Connect to Wifi

Connect to your home Wifi. Unless Wifi is set-up file structure is not set-up correctly on Kindle

At the registration connect Kindle via USB - no need to complete registration. 


### 2 - Jail Break


#### 2a - Downgrade version

Download
	https://s3.amazonaws.com/G7G_FirmwareUpdates_WebDownloads/update_kindle_5.3.3.bin


HOME -> MENU  > Settings  Disable wifi on your Paperwhite 1 (airplane mode).

Connect your Kindle Paperwhite 1 to your computer (DO NOT DISCONNECT UNTIL LAST STEP!).
Copy the bin file you downloaded in step 1 to root folder of PW1.
Sync USB storage but do not disconnect

Push and hold power button (about 30 seconds) until led power light goes from green to orange, then release power button. - but do not disconnect.
Kindle will now update


#### 2b - Jail Break 

Connect Kindle as USB storage

Visit Snapshot Storage - http://www.mobileread.mobi/forums/showthread.php?t=225030

Using K5 JailBreak (5.0.x - 5.4.4.2) 
Uncompress Kindle-Jailbreak,tar.gz
From within the Kindle-Jailbreak,tar.gz, unzip the contents of the kindle-5.4-jailbreak.zip archive to the root directory of your Kindle.

Now, eject & unplug your Kindle, and go to HOME -> MENU > Settings -> MENU > Update Your Kindle. The updater won't actually ever run, this is normal. After a few seconds, the words **** JAILBREAK **** will appear at the bottom of your screen to confirm that the device is jailbroken . You won't see this message again, it's simply a confirmation message.

HOME -> MENU > Settings -> MENU -> Restart


### 3 - Install KUAL, MR Installer and USB Network


#### 3a - Place packages on kindle

Connect Kindle as USB storage

Visit Snapshot Storage - http://www.mobileread.mobi/forums/showthread.php?t=225030
Download kual.tar.gz
Extract KUAL-KDK-2.0.azw2 and place in kindle/documents

Visit Snapshot Storage - http://www.mobileread.mobi/forums/showthread.php?t=225030
kual-mrinstaller
Extract all files and place in kindle/

Visit Snapshot Storage - http://www.mobileread.mobi/forums/showthread.php?t=225030
kindle-usbnet
Extract and place Update\_usbnet\_0.22.N\_install\_touch\_pw.bin" in kindle/mrpackages/ (Make sure not subfolder of mrpackages)

Eject Kindle

#### 3b - Run helper for USB Install

HOME ->  Kindle LAUNCHER -> Helper -> Install MR Packages 

Wait until complete the automatic reboot.

#### 3c - Install SSH keys from Pi/Dev machine

Connect Kindle as USB storage

Copy on kindle before enabling USB Networking /mnt/us/usbnet/etc/authorized_keys

    cat ~/.ssh/id_rsa.pub >> /media/USERNAME/Kindle/usbnet/etc/authorized_keys

Eject Kindle

Reconnect to WIFI network

Find IP Address by HOME -> Search icon -> ;711 
Then scroll to second page 
Then close

#### 3d - Enable OpenSSH 

HOME ->  Kindle LAUNCHER -> USBNetwork -> SSHD: Use OpenSSH
USBNetwork -> Allow SSH over Wifi
USBNetwork -> Enable SSH on boot

Quit

HOME -> MENU > Settings -> MENU -> Restart
(Long restart this time)


