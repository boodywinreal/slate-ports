#!/bin/sh

NAME=shadow
VERSION=4.20.3
ARCHIVE="shadow-${VERSION}.tar.xz"
URL="https://github.com/shadow-maint/shadow/releases/download/${VERSION}/${ARCHIVE}"

curl -LO "$URL"
tar -xf "$ARCHIVE"
cd "$(tar -tf "$ARCHIVE" | head -1 | cut -d/ -f1)"
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

./configure C="$C" CXX="$CXX" \
    --build=x86_64-pc-linux-gnu \
    --host=x86_64-linux-musl \
    --prefix=/usr \
    --bindir=/usr/bin \
    --sbindir=/usr/sbin \
    --sysconfdir=/etc \
    --disable-nls \
    --without-libpam \
    --without-selinux \
    --without-acl \
    --without-attr

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

chmod 4755 "$DESTDIR/usr/bin/passwd"
chmod 4755 "$DESTDIR/usr/bin/su"
