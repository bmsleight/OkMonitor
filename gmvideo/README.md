# Geek Master Video Player

From [mobileread.com](mobileread.com) forum. First release as per post by [geekmaster](https://www.mobileread.com/forums/showthread.php?t=177455)

Apparently geek master [past way during 2018](https://www.mobileread.com/forums/showpost.php?p=3789452&postcount=372). Well code lives on. Wish I can thank Geek Master for their work. 

## gmplay

geekmaster's video player accepts raw video piped into STDIN.
[First version](https://www.mobileread.com/forums/showpost.php?p=2069342&postcount=1)

## raw2gmv

geekmaster's simple, efficient and elegant video transcoder that takes 800x600 grayscale raw video piped from ffmpeg (or any other source of raw video), then does rotate right, "no dither table" ordered dither, and 8-pixel-per-byte packing.
[First version](https://www.mobileread.com/forums/showpost.php?p=2074379&postcount=60)

## Compile

Can be compiled on a Raspberry PI, as same chip set, but libraries are not exectly same - but littel libraries used
[Ben log](https://a.bramble.ninja/cross-compiling-c-for-armv7-kindle-5-touch) gives a hint.


`gcc -Wl,--dynamic-linker -Wl,/lib/ld-linux.so.3 gmplay.c -o gmplay`

Whereas raw2gmv is run on the pi on OpenWRT so 

`gcc raw2gmv.c -o raw2gmv`
`mv raw2gmv /usr/bin/`


