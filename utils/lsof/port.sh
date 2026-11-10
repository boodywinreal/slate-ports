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
curl -LO https://github.com/lsof-org/lsof/releases/download/4.99.5/lsof-4.99.5.tar.gz
tar -xf lsof-4.99.5.tar.gz
cd "$(tar -tf lsof-4.99.5.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
./configure C="$C" CXX="$CXX" --prefix=/usr --disable-static
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
