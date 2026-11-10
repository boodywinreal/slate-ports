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
curl -LO https://mirror.csclub.uwaterloo.ca/x.org/individual/lib/libfontenc-1.1.7.tar.xz
tar -xf libfontenc-1.1.7.tar.xz
cd "$(tar -tf libfontenc-1.1.7.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
./configure C="$C" CXX="$CXX" --prefix=/usr
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
