#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libpciaccess

git clone --depth 1 https://gitlab.freedesktop.org/xorg/lib/libpciaccess.git

cd libpciaccess
meson setup build --prefix=/usr
meson compile -C build -j"$MAKETHREADS"
DESTDIR="$DESTDIR" meson install -C build
