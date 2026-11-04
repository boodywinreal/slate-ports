#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xcb-util-renderutil

curl -LO https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.10.tar.xz
tar -xf xcb-util-renderutil-0.3.10.tar.xz
cd xcb-util-renderutil-0.3.10

./configure --prefix=/usr --disable-static

make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
