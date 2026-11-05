#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXxf86vm

git clone --depth 1 https://gitlab.freedesktop.org/xorg/lib/libXxf86vm.git
cd libXxf86vm

./autogen.sh --prefix=/usr
make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
