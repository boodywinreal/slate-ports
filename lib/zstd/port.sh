#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/zstd

curl -LO https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz

tar -xf zstd-1.5.7.tar.gz

cd zstd-1.5.7
make -j"$(nproc)" PREFIX=/usr
make DESTDIR="$DESTDIR" install PREFIX=/usr

