//====================================================
// raw2gmv 1.0a - raw to geekmaster video transcoder
// Copyright (C) 2012 by geekmaster, with MIT license:
// http://www.opensource.org/licenses/mit-license.php
//----------------------------------------------------
#include <stdio.h>  // stdin,stdout
typedef unsigned char u8; typedef unsigned int u32;
int main(void) {
    u8 o,to,tb,wb0[800*600]; u32 x,y,xi,yi,c=250,b=120; // c=contrast, b=brightness
    while (fread(wb0,800*600,1,stdin)) for (y=0;y<800;y++) { xi=y; tb=0;
        for (x=0;x<600;x++) { yi=599-x; o=x^y;
            to=(y>>2&1|o>>1&2|y<<1&4|o<<2&8|y<<4&16|o<<5&32)-(wb0[yi*800+xi]*63+b)/c>>8;
            tb=(tb>>1)|(to&128); if (7==(x&7)) { fwrite(&tb,1,1,stdout); tb=0; }
        }
    } return 0;
}  
