#include <sys/types.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480


/*************************************************************
 *  <<Julia set相關資料>>
 *  https://en.wikipedia.org/wiki/Julia_set
 *
 *  cX 為 Julia set數學式中複數 "c" 的實部
 *  cY 為 Julia set數學式中複數 "c" 的虛部
 *  調整cX(值域:-1.0~1.0)與cY(值域:0.0~1.0)可得到不同的圖形
 *
*************************************************************/



void drawJuliaSet( int cX, int cY, int width, int height, int16_t (*frame)[FRAME_WIDTH] ) {

	int16_t color;
	//RGB16 color;
 
	int maxIter = 255;

	int zx, zy;
	int tmp;
	int i;
	int x, y;

	for (x = 0; x < width; x++) {
		for (y = 0; y < height; y++) {
			zx = 1500 * (x - (width>>1)) / (width>>1);
            zy = 1000 * (y - (height>>1)) / (height>>1);
			i = maxIter;

			while (zx * zx + zy * zy < 4000000 && i > 0) {
                    int tmp = (zx * zx - zy * zy)/1000 + cX;
                    zy = (2 * zx * zy)/1000 + cY;
                    zx = tmp;
                    i--;
            }
          

			color = ((i&0xff)<<8) | (i&0xff);
			color = (~color)&0xffff;

			frame[y][x] = color;
		}
	}
}