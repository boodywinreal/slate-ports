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
curl -LO https://cache.ruby-lang.org/pub/ruby/4.0/ruby-4.0.9.tar.xz
tar -xf ruby-4.0.9.tar.xz
cd "$(tar -tf ruby-4.0.9.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
./configure C="$C" CXX="$CXX" --prefix=/usr --disable-install-doc --enable-shared
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
