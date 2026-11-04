#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11

git clone --depth 1 https://github.com/anholt/libepoxy.git
cd libepoxy

meson setup build --prefix=/usr -Dtests=false
meson compile -C build -j"$(nproc)"
DESTDIR="$DESTDIR" meson install -C build
