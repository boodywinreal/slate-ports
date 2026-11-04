#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/font-util
curl -LO https://xorg.freedesktop.org/releases/individual/font/font-util-1.4.2.tar.xz
tar -xf font-util-1.4.2.tar.xz
cd font-util-1.4.2

./configure --prefix=/usr

make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
