#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/utils/htop
git clone --depth=1 https://github.com/htop-dev/htop.git
cd htop
./autogen.sh
make clean
./configure --disable-unicode
make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
