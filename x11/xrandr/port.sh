#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xrandr

curl -LO https://xorg.freedesktop.org/releases/individual/app/xrandr-1.5.4.tar.xz
tar -xf xrandr-1.5.4.tar.xz
cd xrandr-1.5.4

./autogen.sh

./configure --prefix=/usr

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
