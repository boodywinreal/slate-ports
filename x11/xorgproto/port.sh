#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/xorgproto
git clone --depth 1 https://gitlab.freedesktop.org/xorg/proto/xorgproto.git
cd xorgproto
meson setup build --prefix=/usr
meson compile -C build -j"$(nproc)"
DESTDIR="$DESTDIR" meson install -C build
