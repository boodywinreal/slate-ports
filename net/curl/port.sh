
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

curl -LO https://curl.se/download/curl-8.23.0.tar.xz
tar -xf curl-8.23.0.tar.xz
cd "$(tar -tf curl-8.23.0.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

./configure C="$C" CXX="$CXX" \
    --prefix=/usr \
    --with-openssl \
    --with-zlib \
    --disable-ldap \
    --disable-ldaps \
    --disable-rtsp \
    --disable-dict \
    --disable-telnet \
    --disable-tftp \
    --disable-pop3 \
    --disable-imap \
    --disable-smtp \
    --disable-gopher \
    --disable-mqtt \
    --without-libpsl \
    --without-libidn2 \
    --without-brotli \
    --without-zstd \
    --without-libssh2 \
    --without-nghttp2 \
    --without-nghttp3

make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

