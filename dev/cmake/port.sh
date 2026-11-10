
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

curl -LO https://github.com/Kitware/CMake/releases/download/v4.4.5/cmake-4.4.5.tar.gz
tar -xf cmake-4.4.5.tar.gz
cd "$(tar -tf cmake-4.4.5.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

./bootstrap \
    --prefix=/usr \
    --parallel="$(nproc)" \
    -- -DCMAKE_USE_OPENSSL=OFF

make  -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

