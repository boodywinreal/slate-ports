#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11
curl -LO https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz
tar -xf libxcb-1.17.0.tar.xz
cd libxcb-1.17.0
./configure  --without-doxygen --prefix=/usr
make DESTDIR="$DESTDIR" install

