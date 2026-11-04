#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/atk

curl -LO https://download.gnome.org/sources/atk/2.38/atk-2.38.0.tar.xz
tar -xf atk-2.38.0.tar.xz
cd atk-2.38.0

meson setup build \
    --prefix=/usr \
    --buildtype=release \
    -Dintrospection=disabled

ninja -C build -j"$(nproc)"
DESTDIR="$DESTDIR" ninja -C build install
