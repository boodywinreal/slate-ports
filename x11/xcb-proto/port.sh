#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xcb-proto
curl -LO https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-1.17.0.tar.xz
tar -xf xcb-proto-1.17.0.tar.xz
cd xcb-proto-1.17.0
PYTHON=python3 ./configure --prefix=/usr
make DESTDIR="$DESTDIR" install
