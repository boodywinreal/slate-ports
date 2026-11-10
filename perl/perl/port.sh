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

curl -LO https://www.cpan.org/src/5.0/perl-5.42.0.tar.gz

tar -xf perl-5.42.0.tar.gz
cd "$(tar -tf perl-5.42.0.tar.gz | head -1 | cut -d/ -f1)"

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
sh Configure -des -Dprefix=/usr
sed -i 's/eaccess((p), (f))/faccessat(AT_FDCWD, (p), (f), AT_EACCESS)/' pp_sys.c
sed -i '1i#include <fcntl.h>\n#include <unistd.h>' pp_sys.c
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

