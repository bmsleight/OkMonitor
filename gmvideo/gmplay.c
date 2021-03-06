//====================================================
// gmplay 1.5a - geekmaster's kindle video player
// Copyright (C) 2012 by geekmaster, with MIT license:
// http://www.opensource.org/licenses/mit-license.php
//----------------------------------------------------
// Tested on DX,DXG,K3,K4main,K4diags,K5main,K5diags.
//----------------------------------------------------
#include <fcntl.h>     // open, close, write
#include <linux/fb.h>  // screeninfo
#include <stdio.h>     // printf
#include <stdlib.h>    // malloc, free
#include <string.h>    // memset, memcpy
#include <sys/ioctl.h> // ioctl
#include <sys/mman.h>  // mmap, munmap
#include <sys/time.h>  // gettimeofday
#include <time.h>      // time
#include <unistd.h>    // usleep
typedef unsigned long u64;
typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;
typedef unsigned int uint;
u32 __invalid_size_argument_for_IOC; // ioctl.h bug fix for tcc
//----- eink definitions from eink_fb.h and mxcfb.h -----
#define EU3 0x46dd
#define EU50 0x4040462e
#define EU51 0x4048462e
// Size
//#define XVID 379
//#define YVID 512
//#define FBSIZE (379 / 8 * 512)
//

#define XVID 758
#define YVID 1024
#define FBSIZE (758 / 8 * 1024)
#define ZOOMFBSIZE (379 / 8 * 512)

struct update_area_t {
  int x1, y1, x2, y2, which_fx;
  u8 *buffer;
};
struct mxcfb_rect {
  u32 top, left, width, height;
};
struct mxcfb_alt_buffer_data {
  u32 phys_addr, width, height;
  struct mxcfb_rect alt_update_region;
};
struct mxcfb_update_data {
  struct mxcfb_rect update_region;
  u32 waveform_mode, update_mode, update_marker;
  int temp;
  uint flags;
  struct mxcfb_alt_buffer_data alt_buffer_data;
};
struct mxcfb_update_data51 {
  struct mxcfb_rect update_region;
  u32 waveform_mode, update_mode, update_marker;
  u32 hist_bw_waveform_mode, hist_gray_waveform_mode;
  int temp;
  uint flags;
  struct mxcfb_alt_buffer_data alt_buffer_data;
};
//----- function prototypes -----
void gmplay4(void);
void gmplay8(void);
int getmsec(void);
int gmlib(int);
//----- gmlib global vars -----
enum GMLIB_op { GMLIB_INIT, GMLIB_CLOSE, GMLIB_UPDATE, GMLIB_VSYNC };
u8 *fb0 = NULL; // framebuffer pointer
int fdFB = 0;   // fb0 file descriptor
int teu = 0;    // eink update time
u32 fs = 0;     // fb0 stride
u32 MX = 0;     // xres (visible)
u32 MY = 0;     // yres (visible)
u32 VY = 0;     // (VY>MY): mxcfb driver
u8 ppb = 0;     // pixels per byte
u32 fc = 0;     // frame counter

//==================================
// gmplay8 - play video on 8-bit fb0
//----------------------------------
void gmplay8(void) {
  u32 i, x, y, b, fbsize = ZOOMFBSIZE;
  u8 fbt[ZOOMFBSIZE];
  // Read from stadard in - FBSIZE f bytes then write to frame buffer
  while (fread(fbt, fbsize, 1, stdin)) {
    // ffmpeg will keep timing correct, need to remove chance of lag
    // if (getmsec()>teu+1000) continue; // drop frame if > 1 sec behind
    gmlib(GMLIB_VSYNC); // wait for fb0 ready
    for (y = 0; y < YVID; y +=2)
      for (x = 0; x < XVID; x += 16) {

        i = y * fs + x;        

        b = fbt[(XVID/2) / 8 * (y/2) + (x/2) / 8];
        fb0[i] = (b & 1) * 255;
        fb0[i + 1] = (b & 1) * 255;
        fb0[i + 0 + fs] = (b & 1) * 255;
        fb0[i + 1 + fs] = (b & 1) * 255;
        
        b >>= 1;
        fb0[i + 2] = (b & 1) * 255;
        fb0[i + 3] = (b & 1) * 255;
        fb0[i + 2 + fs] = (b & 1) * 255;
        fb0[i + 3 + fs] = (b & 1) * 255;

        b >>= 1;
        fb0[i + 4] = (b & 1) * 255;
        fb0[i + 5] = (b & 1) * 255;
        fb0[i + 4 + fs] = (b & 1) * 255;
        fb0[i + 5 + fs] = (b & 1) * 255;

        b >>= 1;        
        fb0[i + 6] = (b & 1) * 255;
        fb0[i + 7] = (b & 1) * 255;
        fb0[i + 6 + fs] = (b & 1) * 255;
        fb0[i + 7 + fs] = (b & 1) * 255;

        b >>= 1;
        fb0[i + 8] = (b & 1) * 255;
        fb0[i + 9] = (b & 1) * 255;
        fb0[i + 8 + fs] = (b & 1) * 255;
        fb0[i + 9 + fs] = (b & 1) * 255;

        b >>= 1;        
        fb0[i + 10] = (b & 1) * 255;
        fb0[i + 11] = (b & 1) * 255;
        fb0[i + 10 + fs] = (b & 1) * 255;
        fb0[i + 11 + fs] = (b & 1) * 255;

        b >>= 1;        
        fb0[i + 12] = (b & 1) * 255;
        fb0[i + 13] = (b & 1) * 255;
        fb0[i + 12 + fs] = (b & 1) * 255;
        fb0[i + 13 + fs] = (b & 1) * 255;

        b >>= 1;
        fb0[i + 14] = (b & 1) * 255;
        fb0[i + 15] = (b & 1) * 255;
        fb0[i + 14 + fs] = (b & 1) * 255;
        fb0[i + 15 + fs] = (b & 1) * 255;
      }
    fc++;
//    teu += 130; // teu: next update time
    gmlib(GMLIB_UPDATE);
  }
}
//====================================
// gmlib - geekmaster function library
// op (init, update, vsync, close)
//------------------------------------
int gmlib(int op) {
  static struct update_area_t ua = {0, 0, XVID, YVID, 21, NULL};
  static struct mxcfb_update_data ur = {
      {0, 0, XVID, YVID}, 257, 0, 1, 0x1001, 0, {0, 0, 0, {0, 0, 0, 0}}};
  static struct mxcfb_update_data51 ur51 = {
      {0, 0, XVID, YVID}, 257, 0, 1, 0, 0, 0x1001, 0, {0, 0, 0, {0, 0, 0, 0}}};
  static int eupcode;
  static void *eupdata = NULL;
  struct fb_var_screeninfo screeninfo;
  if (GMLIB_INIT == op) {
    teu = getmsec();
    fdFB = open("/dev/fb0", O_RDWR);
    ioctl(fdFB, FBIOGET_VSCREENINFO, &screeninfo);
    ppb = 8 / screeninfo.bits_per_pixel;
    fs = screeninfo.xres_virtual / ppb;
    VY = screeninfo.yres_virtual;
    MX = screeninfo.xres;
    MY = screeninfo.yres;
    ua.x2 = MX;
    ua.y2 = MY;
    ur.update_region.width = MX;
    ur.update_region.height = MY;
    fb0 = (u8 *)mmap(0, MY * fs, PROT_READ | PROT_WRITE, MAP_SHARED, fdFB,
                     0); // map fb0
    if (VY > MY) {
      eupcode = EU50;
      eupdata = &ur;
      ur.update_mode = 0;
      if (ioctl(fdFB, eupcode, eupdata) < 0) {
        eupcode = EU51;
        eupdata = &ur51;
      }
    } else {
      eupcode = EU3;
      eupdata = &ua;
    }
    system("eips -f -c;eips -c");
    sleep(1);
  } else if (GMLIB_UPDATE == op) {
    if (ioctl(fdFB, eupcode, eupdata) < 0)
      system("eips ''"); // 5.1.0 fallback
  } else if (GMLIB_VSYNC == op) {
    while (teu > getmsec())
      usleep(1000); // fb0 busy
    // ffmpeg will keep timing correct, need to remove chance of lag
  } else if (GMLIB_CLOSE == op) {
    gmlib(GMLIB_UPDATE);
    system("eips -f -c;eips -c");
    munmap(fb0, MY * fs);
    close(fdFB);
  } else {
    return -1;
  }
  return 0;
}
//====================================
// getmsec - get msec since first call
// (tick counter wraps every 12 days)
//------------------------------------
int getmsec(void) {
  int tc;
  static int ts = 0;
  struct timeval tv;
  gettimeofday(&tv, NULL);
  tc = tv.tv_usec / 1000 + 1000 * (0xFFFFF & tv.tv_sec);
  if (0 == ts)
    ts = tc;
  return tc - ts;
}
//==================
// main - start here
//------------------
int main(void) {
  int i;
  gmlib(GMLIB_INIT);

  printf("ppb, fs, VY, MX, MY, %d %d %d %d  \n", ppb, fs, VY, MX, MY);

  gmplay8();
  i = getmsec() / 100;
  printf("%d frames in %0.1f secs = %2.1f FPS\n", fc, (double)i / 10.0,
         (double)fc * 10.0 / i);
  gmlib(GMLIB_CLOSE);
  return 0;
}
