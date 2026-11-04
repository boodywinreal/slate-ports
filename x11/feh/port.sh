#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/feh

git clone --depth 1 https://github.com/derf/feh.git

cd feh

make clean

make -j"$(nproc)" PREFIX=/usr

make DESTDIR="$DESTDIR" install PREFIX=/usr
