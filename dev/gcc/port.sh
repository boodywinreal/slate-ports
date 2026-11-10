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

curl -LO https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz
tar -xf gcc-15.2.0.tar.xz
cd "$(tar -tf gcc-15.2.0.tar.xz | head -1 | cut -d/ -f1)"

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

./contrib/download_prerequisites

mkdir -p build
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

TARGET=x86_64-linux-musl
BUILD="$(../config.guess)"

CC=gcc \
CXX=g++ \
../configure C="$C" CXX="$CXX" \
    --build="$BUILD" \
    --host="$BUILD" \
    --target="$TARGET" \
    --prefix=/usr \
    --with-sysroot=/ \
    --with-native-system-header-dir=/usr/include \
    --enable-languages=c,c++ \
    --disable-bootstrap \
    --disable-multilib \
    --disable-nls \
    --disable-werror \
    --disable-libsanitizer \
    --disable-libssp \
    --disable-libvtv \
    --disable-libquadmath \
    --disable-libgomp \
    --disable-libatomic

make  -j"${MAKETHREADS:-$(nproc)}"

make DESTDIR="$DESTDIR" install

