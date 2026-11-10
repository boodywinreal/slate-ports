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
curl -LO https://ftp.gnu.org/gnu/grub/grub-2.14.tar.xz
tar -xf grub-2.14.tar.xz
cd "$(tar -tf grub-2.14.tar.xz | head -1 | cut -d/ -f1)"
./configure C="$C" CXX="$CXX" --prefix=/usr --sysconfdir=/etc --disable-werror --disable-nls --with-platform=pc --target=i386
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
make install DESTDIR="$DESTDIR"
