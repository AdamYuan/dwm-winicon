winicon
========

Description
-----------
**dwm-winicon** is a patch that enables dwm to show window icons.

![](https://raw.githubusercontent.com/AdamYuan/dwm-winicon/master/screenshots.png)

It is recommended to enable the compiler optimization flags: **-O3** and **-march=native** to enable auto loop vectorize, which leads to better performance.

If you discover any bugs or have any idea to optimize it, feel free to create an issue there.

Dependency
----------
The patch depends on Imlib2 for icon scaling, which can be easily installed in most distros.

Arch Linux:
	sudo pacman -S imlib2
Debian:
	sudo apt install libimlib2-dev

Configuration
-------------
```c
#define ICONSIZE 20   /* icon size in pixels */
#define ICONSPACING 5 /* space (pixels) between icon and title */
```

Alpha Patch
-----------
If you also use [alpha patch](https://dwm.suckless.org/patches/alpha/), some changes are needed to make this patch work properly.

After applying both patches,
* change the last return statement in **geticonprop** function (dwm.c) to

```c
	return XCreateImage(drw->dpy, drw->visual, drw->depth, ZPixmap, 0, (char *)icbuf, icw, ich, 32, 0);
```

* change **drw_img** and **blend** function (drw.c) to

```c
inline static uint8_t div255(uint16_t x) { return (x*0x8081u) >> 23u; }
inline static uint32_t blend(uint32_t p1rb, uint32_t p1g, uint8_t p1a, uint32_t p2) {
	uint8_t a = p2 >> 24u;
	uint32_t rb = (p2 & 0xFF00FFu) + ( (a * p1rb) >> 8u );
	uint32_t g = (p2 & 0x00FF00u) + ( (a * p1g) >> 8u );
	return (rb & 0xFF00FFu) | (g & 0x00FF00u) | div255(~a * 255u + a * p1a) << 24u;
}
	
void
drw_img(Drw *drw, int x, int y, XImage *img, uint32_t *tmp) 
{
	if (!drw || !drw->scheme)
		return;
	uint32_t *data = (uint32_t *)img->data, p = drw->scheme[ColBg].pixel,
			 prb = p & 0xFF00FFu, pg = p & 0x00FF00u;
	uint8_t pa = p >> 24u;
	int icsz = img->width * img->height, i;
	for (i = 0; i < icsz; ++i) tmp[i] = blend(prb, pg, pa, data[i]);

	img->data = (char *) tmp;
	XPutImage(drw->dpy, drw->drawable, drw->gc, img, 0, 0, x, y, img->width, img->height);
	img->data = (char *) data;
}
```
