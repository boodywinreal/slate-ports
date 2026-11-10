#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
VERSION=5.4.1
NAME=gawk

curl -LO https://ftp.gnu.org/gnu/gawk/gawk-$VERSION.tar.xz
tar -xf gawk-$VERSION.tar.xz
cd gawk-$VERSION

./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --libexecdir=/usr/lib \
    --sysconfdir=/etc \
    --disable-nls

make
make DESTDIR="$DESTDIR" install
