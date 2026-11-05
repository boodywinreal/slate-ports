#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/system/kmod

curl -LO https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz
tar -xf kmod-34.2.tar.xz
cd kmod-34.2

./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --with-rootlibdir=/lib \
    --with-zlib \
    --with-xz \
    --with-zstd \
    --disable-manpages

make -j"$MAKETHREADS"
make DESTDIR="$DESTDIR" install
