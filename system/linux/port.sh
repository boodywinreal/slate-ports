#!/bin/sh
#!!!!!!!!! Experimental
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
curl -LO https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.18.55.tar.xz
tar -xf linux-6.18.55.tar.xz
cd "$(tar -tf linux-6.18.55.tar.xz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cp /boot/slate-kernel.config .
make olddefconfig -j"${MAKETHREADS:-$(nproc)}"
make -j"${MAKETHREADS:-$(nproc)}"
cp arch/x86/boot/bzImage /boot/slate-kernel
