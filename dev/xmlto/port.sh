#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd "/$PORTS_DIR"
if command -v gcc >/dev/null 2>&1; then
    C="gcc"
else
    C="cc"
fi
if command -v g++ >/dev/null 2>&1; then
    CXX="g++"
else
    CXX="c++"
fi

if command -v ccache >/dev/null 2>&1; then
    C="ccache $C"
    CXX="ccache $CXX"
fi

curl -LO https://anduin.linuxfromscratch.org/BLFS/xmlto/xmlto-0.0.29.tar.gz

tar -xf xmlto-0.0.29.tar.gz
cd "$(tar -tf xmlto-0.0.29.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

autoreconf -fiv

./configure C="$C" CXX="$CXX" \
    --prefix=/usr

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

