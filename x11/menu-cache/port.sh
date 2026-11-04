#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/menu-cache

curl -LO https://downloads.sourceforge.net/lxde/menu-cache-1.1.0.tar.xz
tar -xf menu-cache-1.1.0.tar.xz
cd menu-cache-1.1.0

./configure --prefix=/usr --disable-static

make
make DESTDIR="$DESTDIR" install
