#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXdamage

curl -LO https://xorg.freedesktop.org/releases/individual/lib/libXdamage-1.2.1.tar.xz
tar -xf libXdamage-1.2.1.tar.xz
cd libXdamage-1.2.1

./configure --prefix=/usr

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
