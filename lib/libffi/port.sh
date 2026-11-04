#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/libffi
curl -LO https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz
tar -xf libffi-3.5.2.tar.gz
cd libffi-3.5.2
./configure --prefix=/usr --enable-shared
make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
ln -sf /usr/lib64/libffi.so.8 ${DESTDIR:-}/usr/lib/libffi.so.8
