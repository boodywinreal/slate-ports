
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

curl -LO https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz
tar -xf dbus-1.16.2.tar.xz
cd "$(tar -tf dbus-1.16.2.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

meson setup build \
    --prefix=/usr \
    --libdir=lib \
    --buildtype=release \
    -Dsystemd=disabled \
    -Dapparmor=disabled \
    -Dselinux=disabled \
    -Daudit=disabled \
    -Ddocs=disabled \
    -Dman=enabled \
    -Dembedded_tests=false

ninja -C build -j"${MAKETHREADS:-$(nproc)}"
DESTDIR="$DESTDIR" ninja -C build install

