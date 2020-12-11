//====================================================
// raw2gmv 1.0a - raw to geekmaster video transcoder
// Copyright (C) 2012 by geekmaster, with MIT license:
// http://www.opensource.org/licenses/mit-license.php
//----------------------------------------------------
#include <stdio.h> // stdin,stdout
typedef unsigned char u8;
typedef unsigned int u32;
#define XVID 758
#define YVID 1024
int main(void) {
  u8 o, to, tb, wb0[YVID * XVID];
  u32 x, y, xi, yi, c = 250, b = 120; // c=contrast, b=brightness
  while (fread(wb0, YVID * XVID, 1, stdin))
    for (y = 0; y < YVID; y++) {
      xi = y;
      tb = 0;
      for (x = 0; x < XVID; x++) {
        yi = XVID - 1 - x;
        o = x ^ y;
        to = (y >> 2 & 1 | o >> 1 & 2 | y << 1 & 4 | o << 2 & 8 | y << 4 & 16 |
              o << 5 & 32) -
                 (wb0[yi * YVID + xi] * 63 + b) / c >>
             8;
        tb = (tb >> 1) | (to & 128);
        if (7 == (x & 7)) {
          fwrite(&tb, 1, 1, stdout);
          tb = 0;
        }
      }
    }
  return 0;
}
