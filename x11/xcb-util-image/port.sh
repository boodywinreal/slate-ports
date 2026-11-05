#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xcb-util-image

curl -LO https://xcb.freedesktop.org/dist/xcb-util-image-0.4.1.tar.xz
tar -xf xcb-util-image-0.4.1.tar.xz
cd xcb-util-image-0.4.1

./configure --prefix=/usr --disable-static

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
