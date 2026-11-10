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
curl -LO https://github.com/ninja-build/ninja/archive/refs/tags/v1.13.2.tar.gz
tar -xf v1.13.2.tar.gz
cd "$(tar -tf v1.13.2.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

python3 configure.py --bootstrap

install -Dm755 ninja ${DESTDIR:-}/usr/bin/ninja
