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
curl -LO https://www.kernel.org/pub/software/network/iw/iw-6.17.tar.xz
tar -xf iw-6.17.tar.xz
cd "$(tar -tf iw-6.17.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
make -j"${MAKETHREADS:-$(nproc)}"
make PREFIX=/usr DESTDIR="$DESTDIR" install
