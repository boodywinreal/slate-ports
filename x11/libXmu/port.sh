#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXmu

git clone --depth 1 https://gitlab.freedesktop.org/xorg/lib/libXmu.git

cd libXmu

./autogen.sh

./configure --prefix=/usr

make -j"$MAKETHREADS"

make DESTDIR="$DESTDIR" install
