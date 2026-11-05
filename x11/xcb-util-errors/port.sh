#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xcb-util-errors

curl -LO https://xorg.freedesktop.org/archive/individual/lib/xcb-util-errors-1.0.1.tar.xz
tar -xf xcb-util-errors-1.0.1.tar.xz
cd xcb-util-errors-1.0.1

./configure --prefix=/usr --disable-static

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
