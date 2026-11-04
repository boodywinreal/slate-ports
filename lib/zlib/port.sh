#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/zlib

curl -LO https://www.zlib.net/zlib-1.3.2.tar.xz
tar -xf zlib-1.3.2.tar.xz
cd zlib-1.3.2

./configure --prefix=/usr

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
