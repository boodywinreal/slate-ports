#!/bin/sh
set -e

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
curl -LO https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.15.0.tar.xz
tar -xf pciutils-3.15.0.tar.xz
cd "$(tar -tf pciutils-3.15.0.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

make PREFIX=/usr SHARED=yes ZLIB=no DNS=no LIBKMOD=no HWDB=no -j"${MAKETHREADS:-$(nproc)}"
make PREFIX=/usr SHARED=yes ZLIB=no DNS=no LIBKMOD=no HWDB=no \ -j"${MAKETHREADS:-$(nproc)}"
    DESTDIR="$DESTDIR" install install-lib
