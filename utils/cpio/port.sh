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

curl -LO https://ftp.gnu.org/gnu/cpio/cpio-2.15.tar.gz
tar -xf cpio-2.15.tar.gz
cd "$(tar -tf cpio-2.15.tar.gz | head -1 | cut -d/ -f1)"

./configure C="$C" CXX="$CXX" --prefix=/usr
sed -i \
    '/^extern int (\*xstat)/s/()/(const char * restrict, struct stat * restrict)/' \
    src/extern.h

sed -i \
    '/^int (\*xstat)/s/()/(const char * restrict, struct stat * restrict)/' \
    src/global.c
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
