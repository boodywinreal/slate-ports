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

curl -LO https://dl.suckless.org/tools/ubase-0.1.tar.gz
tar -xf ubase-0.1.tar.gz
cd "$(tar -tf ubase-0.1.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

make -j"${MAKETHREADS:-$(nproc)}"
make PREFIX=/usr DESTDIR="$DESTDIR" install
