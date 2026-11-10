
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

curl -LO https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.78.tar.xz
tar -xf libcap-2.78.tar.xz
cd "$(tar -tf libcap-2.78.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

make \ -j"${MAKETHREADS:-$(nproc)}"
    prefix=/usr \
    lib=lib \
    RAISE_SETFCAP=no

make \ -j"${MAKETHREADS:-$(nproc)}"
    prefix=/usr \
    lib=lib \
    RAISE_SETFCAP=no \
    DESTDIR="$DESTDIR" \
    install

