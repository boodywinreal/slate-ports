#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/lib/libudev-zero
git clone --depth 1 https://github.com/illiliti/libudev-zero.git
cd libudev-zero
meson setup build --prefix=/usr
meson compile -C build -j"$(nproc)"
DESTDIR="$DESTDIR" meson install -C build
