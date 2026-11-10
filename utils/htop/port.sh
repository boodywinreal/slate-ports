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
git clone --depth=1 https://github.com/htop-dev/htop.git
cd htop
cd "$(basename "$(echo "$(grep -oE "https?://[^ ]+" <<< "&" | tail -1)" | sed "s/.git$//" | sed "s|.*/||")")"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
./autogen.sh
make clean -j"${MAKETHREADS:-$(nproc)}"
./configure C="$C" CXX="$CXX" --disable-unicode
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
