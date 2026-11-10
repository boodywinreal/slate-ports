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

curl -LO https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz

tar -xf ncurses-6.5.tar.gz
cd "$(tar -tf ncurses-6.5.tar.gz | head -1 | cut -d/ -f1)"

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
./configure C="$C" CXX="$CXX" --prefix=/usr --with-shared --enable-widec --with-termlib --enable-pc-files --with-pkg-config-libdir=/usr/lib/pkgconfig
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

