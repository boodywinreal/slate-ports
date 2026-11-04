#!/bin/sh
set -e
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/system/gptfdisk
curl -LO https://downloads.sourceforge.net/project/gptfdisk/gptfdisk/1.0.10/gptfdisk-1.0.10.tar.gz
tar -xf gptfdisk-1.0.10.tar.gz
cd gptfdisk-1.0.10
make
make PREFIX=/usr DESTDIR="$DESTDIR" install
