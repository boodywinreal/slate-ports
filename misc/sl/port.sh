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
curl -LO https://github.com/mtoyoda/sl/archive/refs/tags/5.02.tar.gz
tar -xf 5.02.tar.gz
cd "$(tar -tf 5.02.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

make CC="${CC:-gcc}" \ -j"${MAKETHREADS:-$(nproc)}"
    CFLAGS="${CFLAGS:--O2}" \
    LDFLAGS="-lncurses"

install -Dm755 sl "$DESTDIR/usr/bin/sl"
