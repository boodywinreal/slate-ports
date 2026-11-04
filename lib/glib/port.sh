#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/glib
curl -LO https://download.gnome.org/sources/glib/2.90/glib-2.90.1.tar.xz
tar -xf glib-2.90.1.tar.xz
cd glib-2.90.1
meson setup build --prefix=/usr -Dtests=false
meson compile -C build -j"$(nproc)"
DESTDIR="$DESTDIR" meson install -C build
