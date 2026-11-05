#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/bdftopcf
curl -LO https://xorg.freedesktop.org/releases/individual/util/bdftopcf-1.1.2.tar.xz
tar -xf bdftopcf-1.1.2.tar.xz
cd bdftopcf-1.1.2

./configure --prefix=/usr

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
