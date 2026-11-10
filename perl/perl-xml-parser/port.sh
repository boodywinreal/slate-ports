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
curl -LO https://www.cpan.org/authors/id/T/TO/TODDR/XML-Parser-2.59.tar.gz
tar -xf XML-Parser-2.59.tar.gz
cd "$(tar -tf XML-Parser-2.59.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

perl Makefile.PL PREFIX=/usr

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
