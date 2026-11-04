#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/utils/tree

git clone --depth=1 https://gitlab.com/OldManProgrammer/unix-tree.git

cd unix-tree

make -j"$(nproc)"

make DESTDIR="$DESTDIR" install
