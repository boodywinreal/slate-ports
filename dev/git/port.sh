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

curl -LO https://www.kernel.org/pub/software/scm/git/git-2.51.0.tar.xz

tar -xf git-2.51.0.tar.xz
cd "$(tar -tf git-2.51.0.tar.xz | head -1 | cut -d/ -f1)"

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
make prefix=/usr NO_TCLTK=1 NO_GETTEXT=1 -j"${MAKETHREADS:-$(nproc)}"
make install prefix=/usr NO_TCLTK=1 NO_GETTEXT=1

