#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/libXaw

git clone --depth 1 https://gitlab.freedesktop.org/xorg/lib/libXaw.git

cd libXaw

./autogen.sh

./configure 
    --prefix=/usr/local 
    --enable-shared 
    --enable-static

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
