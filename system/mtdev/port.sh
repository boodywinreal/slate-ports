#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/system/mtdev
git clone https://bitmath.se/org/git/mtdev.git/ 
cd mtdev
./autogen.sh
./configure --prefix=/usr
make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
