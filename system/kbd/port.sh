#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/system/kbd
curl -LO https://www.kernel.org/pub/linux/utils/kbd/kbd-2.10.0.tar.xz
tar -xf kbd-2.10.0.tar.xz
cd kbd-2.10.0
./configure --prefix=/usr
make
make DESTDIR="$DESTDIR" install
