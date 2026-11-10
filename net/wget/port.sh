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

git clone --depth=1 https://git.savannah.gnu.org/git/wget.git
cd "$(basename "$(echo "$(grep -oE "https?://[^ ]+" <<< "&" | tail -1)" | sed "s/.git$//" | sed "s|.*/||")")"

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

./bootstrap

./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --with-ssl=openssl

make -j"${MAKETHREADS:-$(nproc)}"

make DESTDIR="$DESTDIR" install
