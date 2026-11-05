#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11
curl -LO https://mirror.csclub.uwaterloo.ca/x.org/individual/lib/libfontenc-1.1.7.tar.xz
tar -xf libfontenc-1.1.7.tar.xz
cd libfontenc-1.1.7
./configure --prefix=/usr
make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
