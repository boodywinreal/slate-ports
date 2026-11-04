#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/fribidi

VERSION=1.0.16

curl -LO https://github.com/fribidi/fribidi/releases/download/v${VERSION}/fribidi-${VERSION}.tar.xz
tar -xf fribidi-${VERSION}.tar.xz
cd fribidi-${VERSION}

./configure --prefix=/usr

make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
