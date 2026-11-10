#!/bin/sh
python3 -m pip install pytest evdev pyudev
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
curl -LO https://github.com/linuxwacom/libwacom/releases/download/libwacom-2.14.0/libwacom-2.14.0.tar.xz
tar -xf libwacom-2.14.0.tar.xz
cd "$(tar -tf libwacom-2.14.0.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/share/pkgconfig
python3 -m pip install libevdev pyudev pytest evdev
sed -i "s/if get_option('b_sanitize') == 'none'/if false/" meson.build
meson setup build --prefix=/usr -Dtests=disabled
meson compile -C build -j"${MAKETHREADS:-$(nproc)}"
DESTDIR="$DESTDIR" meson install -C build
