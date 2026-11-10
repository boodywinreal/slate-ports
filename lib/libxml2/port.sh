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

curl -LO https://download.gnome.org/sources/libxml2/2.15/libxml2-2.15.4.tar.xz
tar -xf libxml2-2.15.4.tar.xz
cd "$(tar -tf libxml2-2.15.4.tar.xz | head -1 | cut -d/ -f1)"

./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --disable-static \
    --without-python \
    --without-readline \
    --without-zlib \
    --without-lzma \
    --without-icu \
    --without-modules \
    --without-docs

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
