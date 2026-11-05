#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/doc/xmlto

curl -LO https://anduin.linuxfromscratch.org/BLFS/xmlto/xmlto-0.0.29.tar.gz

tar -xf xmlto-0.0.29.tar.gz
cd xmlto-0.0.29

autoreconf -fiv

./configure \
    --prefix=/usr

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install

