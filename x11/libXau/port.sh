#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXau

curl -LO https://xorg.freedesktop.org/releases/individual/lib/libXau-1.0.12.tar.xz
tar -xf libXau-1.0.12.tar.xz
cd libXau-1.0.12
./autogen.sh

./configure --prefix=/usr

make -j"$MAKETHREADS"

make DESTDIR="$DESTDIR" install
