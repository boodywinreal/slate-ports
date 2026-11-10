#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd "/$PORTS_DIR"
curl -LO https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.49/pcre2-10.49.tar.bz2
tar -xjf pcre2-10.49.tar.bz2
cd "$(tar -tf pcre2-10.49.tar.bz2 | head -1 | cut -d/ -f1)"
./configure --prefix=/usr
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install
