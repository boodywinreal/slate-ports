#!/bin/sh

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/utils/neofetch

git clone --depth=1 https://github.com/dylanaraps/neofetch.git

cd neofetch

make DESTDIR="$DESTDIR" install
