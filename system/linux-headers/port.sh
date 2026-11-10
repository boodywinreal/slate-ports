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
curl -LO https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.18.60.tar.xz
tar -xf linux-6.18.60.tar.xz
cd "$(tar -tf linux-6.18.60.tar.xz | head -1 | cut -d/ -f1)"

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

make mrproper -j"${MAKETHREADS:-$(nproc)}"

make headers_install \
    ARCH=x86 \
    INSTALL_HDR_PATH=/usr \
    DESTDIR="$DESTDIR"

