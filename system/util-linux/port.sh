
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

curl -LO https://cdn.kernel.org/pub/linux/utils/util-linux/v2.42/util-linux-2.42.4.tar.xz
tar -xf util-linux-2.42.4.tar.xz
cd "$(tar -tf util-linux-2.42.4.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --libdir=/usr/lib \
    --runstatedir=/run \
    --disable-nls \
    --disable-makeinstall-chown \
    --without-systemd \
    --without-udev \
    --without-python \
    --without-tinfo \
    --without-ncurses \
    --without-readline \
    --without-audit \
    --without-selinux \
    --without-cryptsetup \
    --without-libuser \
    --without-slang \
    --without-utempter

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

