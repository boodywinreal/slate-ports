#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXcursor

curl -LO https://xorg.freedesktop.org/releases/individual/lib/libXcursor-1.2.3.tar.xz
tar -xf libXcursor-1.2.3.tar.xz
cd libXcursor-1.2.3

./autogen.sh

./configure --prefix=/usr

make -j"$MAKETHREADS"

make DESTDIR="$DESTDIR" install
