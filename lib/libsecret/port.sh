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
curl -LO https://download.gnome.org/sources/libsecret/0.21/libsecret-0.21.8.2.tar.xz
tar -xf libsecret-0.21.8.2.tar.xz
cd "$(tar -tf libsecret-0.21.8.2.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
meson setup build --prefix=/usr \
    -Dgtk_doc=false -Dmanpage=false \
    -Dintrospection=false -Dvapi=false -Dtests=false
ninja -C build -j"${MAKETHREADS:-$(nproc)}"
DESTDIR="$DESTDIR" ninja -C build install
