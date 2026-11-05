#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/pkgconf

curl -LO https://distfiles.dereferenced.org/pkgconf/pkgconf-2.5.1.tar.xz

tar -xf pkgconf-2.5.1.tar.xz

cd pkgconf-2.5.1
./configure --prefix=/usr --disable-static
make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install

