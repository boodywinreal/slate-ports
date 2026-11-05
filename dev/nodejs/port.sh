#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/dev/nodejs

VERSION="26.13.0"

curl -LO https://github.com/nodejs/node/archive/refs/tags/v$VERSION\.tar.gz
tar -xf v$VERSION\.tar.gz

cd node-$VERSION

make distclean
export CPPFLAGS="-I/usr/include"
export LDFLAGS="-L/usr/lib64 -L/usr/lib"
export LD_LIBRARY_PATH=/usr/lib64:/usr/lib

./configure \
  --prefix=/usr \
  --shared-*
make -j"$(nproc)"
make DESTDIR="$DESTDIR" install