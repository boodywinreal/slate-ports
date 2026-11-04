#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xeyes

curl -LO https://www.x.org/releases/individual/app/xeyes-1.3.0.tar.xz
tar -xf xeyes-1.3.0.tar.xz
cd xeyes-1.3.0

./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var

make
make DESTDIR="$DESTDIR" install
