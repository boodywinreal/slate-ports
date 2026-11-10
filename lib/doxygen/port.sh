#!/bin/sh
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
curl -LO https://www.doxygen.nl/files/doxygen-1.14.0.src.tar.gz
tar -xf doxygen-1.14.0.src.tar.gz
cd "$(tar -tf doxygen-1.14.0.src.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
mkdir build
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
