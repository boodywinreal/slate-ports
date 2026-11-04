#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/net/wget

git clone --depth=1 https://git.savannah.gnu.org/git/wget.git

cd wget

./bootstrap

./configure \
    --prefix=/usr \
    --with-ssl=openssl

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
