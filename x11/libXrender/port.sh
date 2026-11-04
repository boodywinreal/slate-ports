#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXrender

curl -LO https://xorg.freedesktop.org/releases/individual/lib/libXrender-0.9.13.tar.xz
tar -xf libXrender-0.9.13.tar.xz
cd libXrender-0.9.13

./autogen.sh

./configure --prefix=/usr

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
