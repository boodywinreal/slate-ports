#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/misc/cmatrix
curl -LO https://github.com/abishekvashok/cmatrix/archive/refs/tags/v2.0.tar.gz
tar -xf v2.0.tar.gz
cd cmatrix-2.0

./autogen.sh
./configure --prefix=/usr

make -j"$(nproc)"
DESTDIR="$DESTDIR" make install
