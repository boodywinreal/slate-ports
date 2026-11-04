#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xclip

curl -LO https://github.com/astrand/xclip/archive/0.13.tar.gz
tar -xf 0.13.tar.gz
cd xclip-0.13

autoreconf -fi
./configure --prefix=/usr

make -j"$(nproc)"
make DESTDIR="$DESTDIR" install install.man
