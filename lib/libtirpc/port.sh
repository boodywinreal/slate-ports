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

curl -LO https://downloads.sourceforge.net/project/libtirpc/libtirpc/1.3.8/libtirpc-1.3.8.tar.bz2
tar -xf libtirpc-1.3.8.tar.bz2
cd "$(tar -tf libtirpc-1.3.8.tar.bz2 | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
sed -i 's|#include <sys/queue.h>|#include <bsd/sys/queue.h>|' $(grep -rl '#include <sys/queue.h>' .)
./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --sysconfdir=/etc \
    --disable-gssapi \
    --disable-authdes

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
