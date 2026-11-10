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

curl -LO https://github.com/polkit-org/polkit/archive/refs/tags/127.tar.gz
tar -xf 127.tar.gz
cd "$(tar -tf 127.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

meson setup build \
    --prefix=/usr \
    --sysconfdir=/etc \
    -Dauthfw=shadow \
    -Dsession_tracking=ConsoleKit \
    -Dintrospection=false \
    -Dman=false \
    -Dtests=false

ninja -C build -j"${MAKETHREADS:-$(nproc)}"
DESTDIR="$DESTDIR" ninja -C build install
