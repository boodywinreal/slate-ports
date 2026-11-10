
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

curl -LO https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/1.47.4/e2fsprogs-1.47.4.tar.gz
tar -xf e2fsprogs-1.47.4.tar.gz
cd "$(tar -tf e2fsprogs-1.47.4.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --bindir=/usr/bin \
    --sbindir=/usr/bin \
    --libdir=/usr/lib \
    --enable-elf-shlibs \
    --disable-nls \
    --disable-fuse2fs

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

