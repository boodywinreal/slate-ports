#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd "/$PORTS_DIR"

VERSION=1.53.0

curl -LO https://github.com/libuv/libuv/archive/refs/tags/v$VERSION\.tar.gz
tar -xf v$VERSION\.tar.gz

cd libuv-$VERSION
make distclean
export CPPFLAGS="-I/usr/include"
export LDFLAGS="-L/usr/lib64 -L/usr/lib"
export LD_LIBRARY_PATH=/usr/lib64:/usr/lib

sh autogen.sh
./configure \
    --prefix=/usr
make -j"${MAKETHREADS:-$(nproc)}"
make check
make DESTDIR="$DESTDIR" install