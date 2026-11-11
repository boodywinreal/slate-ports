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

VERSION=4.14.3
curl -LO https://github.com/ccache/ccache/archive/refs/tags/v$VERSION\.tar.gz
tar -xf v$VERSION\.tar.gz

cd ccache-$VERSION
make distclean
export CPPFLAGS="-I/usr/include"
export LDFLAGS="-L/usr/lib64 -L/usr/lib"
export LD_LIBRARY_PATH=/usr/lib64:/usr/lib

sh autogen.sh
./configure C="$C" CXX="$CXX" \
    --prefix=/usr
make -j"${MAKETHREADS:-$(nproc)}"
make check
make DESTDIR="$DESTDIR" install