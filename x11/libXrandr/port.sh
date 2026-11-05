#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXrandr

git clone --depth 1 https://gitlab.freedesktop.org/xorg/lib/libXrandr.git

cd libXrandr

./autogen.sh

./configure --prefix=/usr

make -j"$MAKETHREADS"

make DESTDIR="$DESTDIR" install
