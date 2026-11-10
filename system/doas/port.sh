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
curl -LO https://github.com/Duncaen/OpenDoas/releases/download/v6.8.2/opendoas-6.8.2.tar.gz
tar -xf opendoas-6.8.2.tar.gz
cd "$(tar -tf opendoas-6.8.2.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
./configure C="$C" CXX="$CXX" --prefix=/usr --sysconfdir=/etc --with-shadow --without-pam
make clean -j"${MAKETHREADS:-$(nproc)}"
make nproc)" -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
echo "Doas install completed"
