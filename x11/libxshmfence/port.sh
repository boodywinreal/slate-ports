#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libxshmfence
curl -LO https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-1.3.tar.gz
tar -xf libxshmfence-1.3.tar.gz
cd libxshmfence-1.3
./configure --prefix=/usr
make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
