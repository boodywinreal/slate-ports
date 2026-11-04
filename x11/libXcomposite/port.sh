#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXcomposite

curl -LO https://xorg.freedesktop.org/releases/individual/lib/libXcomposite-0.4.7.tar.xz
tar -xf libXcomposite-0.4.7.tar.xz
cd libXcomposite-0.4.7

./configure --prefix=/usr

make
make DESTDIR="$DESTDIR" install
