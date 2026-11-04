#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/x11/dmenu
curl -LO https://dl.suckless.org/tools/dmenu-5.4.tar.gz
tar -xf dmenu-5.4.tar.gz
cd dmenu-5.4
make
make DESTDIR="$DESTDIR" install
