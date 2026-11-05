#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xcb-util-wm

curl -LO https://xorg.freedesktop.org/archive/individual/lib/xcb-util-wm-0.4.2.tar.xz
tar -xf xcb-util-wm-0.4.2.tar.xz
cd xcb-util-wm-0.4.2

./configure --prefix=/usr --disable-static

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
