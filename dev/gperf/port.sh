#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/dev/gperf

curl -LO http://ftp.gnu.org/pub/gnu/gperf/gperf-3.3.tar.gz 
tar -xf gperf-3.3.tar.gz

cd gperf-3.3
./configure --prefix=/usr
make -j"$(nproc)"
make install DESTDIR="${DESTDIR:-}"
