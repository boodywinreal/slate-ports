#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXdmcp

curl -LO https://www.x.org/pub/individual/lib/libXdmcp-1.1.5.tar.xz 
tar -xf libXdmcp-1.1.5.tar.xz

cd libXdmcp-1.1.5
./autogen.sh --prefix=/usr

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
