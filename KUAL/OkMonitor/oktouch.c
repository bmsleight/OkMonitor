/* Name: main.c
 * Author: JoppyFurr
 * Description: My first play with Kindle code.
 * MIT License - "Yes, it is fine to use this under an MIT / BSD license"
 *    Email of the 2020-12-25
 * Update by Brendan Sleight 
 */

// https://www.mobileread.com/forums/showthread.php?t=178513


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#define WIDTH 758
#define HEIGHT 1024

#define TOUCH_SCREEN "/dev/input/event0"

#define UP 0
#define DOWN 1


int main(int argc, char **argv) {
    int frame_buffer_fd = 0;
    int touch_screen_fd = 0;
    unsigned char *frame_buffer = NULL;
    unsigned char event_buffer[16];
    int x = 0; 
    int y = 0;
    int i = 0;
    int j = 0;
    int finger = UP;

    /* Open files related to the screen */
    touch_screen_fd = open(TOUCH_SCREEN, O_RDONLY);   
    if(touch_screen_fd == -1) {
        fprintf(stderr, "Error: Could not open touch screen.\n");
        exit(EXIT_FAILURE);
    }

    
    /* Loop through touch screen input, writing pretty things to the screen */    
    while(1) {
        read(touch_screen_fd, event_buffer, 16);
        if(event_buffer[0x08] == 0x03) {
            switch(event_buffer[0x0A]) {
                case 0x35:
                    /* X Coordinate change */
                    x = (WIDTH * (event_buffer[0x0C] + (event_buffer[0x0D] << 8))) / 0x1000;
                    break;
                case 0x36:
                    /* Y Coordinate change */
                    y = (HEIGHT * (event_buffer[0x0C] + (event_buffer[0x0D] << 8))) / 0x1000;
                    break;
                case 0x39:
                    /* Finger up / down */
                    if(event_buffer[0x0C] == 0x00) {
                        printf("Finger 1 down.\n");
                        finger = DOWN;
                    }
                    else if(event_buffer[0x0C] == 0x01) {
                        printf("Finger 2 down.\n");
                        finger = DOWN;
                    }
                    else {
                        printf("Finger up.\n");
                        printf("X %d, Y %d  ...\n",x,y);
                        if ( (x < 15) && (y < 15) )  {
							exit(EXIT_FAILURE);
						}
						else {
							system("/usr/sbin/eips -f -c");
						}
                         
                        finger = UP;
                    }
                    break;
                default:
                    break;
            }
        }
    }

    return EXIT_SUCCESS;
}

