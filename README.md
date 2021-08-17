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
```sh
sudo pacman -S imlib2
```
Debian:
```sh
sudo apt install libimlib2-dev
```

Configuration
-------------
```c
#define ICONSIZE 20   /* icon size in pixels */
#define ICONSPACING 5 /* space (pixels) between icon and title */
```

Alpha Patch
-----------
If you also use [alpha patch](https://dwm.suckless.org/patches/alpha/), some modifications are needed to make dwm work correctly.
* Replace (in drw.c, drw_create function)
```c
	drw->picture = XRenderCreatePicture(dpy, drw->drawable, XRenderFindVisualFormat(dpy, DefaultVisual(dpy, screen)), 0, NULL);
```
with 
```c
	drw->picture = XRenderCreatePicture(dpy, drw->drawable, XRenderFindVisualFormat(dpy, visual), 0, NULL);
```

* Replace (in drw.c, drw_resize function)
```c
	drw->picture = XRenderCreatePicture(drw->dpy, drw->drawable, XRenderFindVisualFormat(drw->dpy, DefaultVisual(drw->dpy, drw->screen)), 0, NULL);
```
with 
```c
	drw->picture = XRenderCreatePicture(drw->dpy, drw->drawable, XRenderFindVisualFormat(drw->dpy, drw->visual), 0, NULL);
```
