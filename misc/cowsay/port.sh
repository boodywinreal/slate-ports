#!/bin/sh
set -euo pipefail

VERSION="3.8.4"
URL="https://github.com/cowsay-org/cowsay/archive/refs/tags/v${VERSION}.tar.gz"

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

curl -fsSL "$URL" -o "$WORK/src.tar.gz"
tar -xzf "$WORK/src.tar.gz" -C "$WORK" --strip-components=1

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
make PREFIX=/usr -j"${MAKETHREADS:-$(nproc)}"

make DESTDIR="$DESTDIR" PREFIX=/usr install
