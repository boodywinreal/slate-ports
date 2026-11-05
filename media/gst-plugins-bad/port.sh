#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/media/gst-plugins-bad
curl -LO https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.28.8.tar.xz
tar -xf gst-plugins-bad-1.28.8.tar.xz
cd gst-plugins-bad-1.28.8
meson setup build --prefix=/usr \
    -Dtests=disabled -Dexamples=disabled \
    -Dgtk_doc=disabled -Dintrospection=disabled \
    -Dopenh264=disabled -Dopenexr=disabled \
    -Dqt6=disabled -Dwayland=disabled
ninja -C build -j"$MAKETHREADS"
DESTDIR="$DESTDIR" ninja -C build install
