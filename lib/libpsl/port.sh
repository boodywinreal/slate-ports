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
curl -LO https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz
tar -xf libpsl-0.21.5.tar.gz
cd "$(tar -tf libpsl-0.21.5.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
meson setup build --prefix=/usr --buildtype=release \
    -Ddocs=false -Dman=false -Dgtk_doc=false -Dtests=false
ninja -C build -j"${MAKETHREADS:-$(nproc)}"
DESTDIR="$DESTDIR" ninja -C build install
