#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/gdk-pixbuf

curl -LO https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.12.tar.xz
tar -xf gdk-pixbuf-2.42.12.tar.xz
cd gdk-pixbuf-2.42.12

meson setup build \
    --prefix=/usr \
    --buildtype=release \
    -Dintrospection=disabled \
    -Ddocumentation=false \
    -Dman=false \
    -Dtests=false \
    -Dinstalled_tests=false \
    -Dpng=enabled \
    -Djpeg=enabled \
    -Dgif=enabled \
    -Dtiff=disabled \
    -Dthumbnailer=disabled

ninja -C build -j"$(nproc)"
DESTDIR="$DESTDIR" ninja -C build install
