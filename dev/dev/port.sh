#!/bin/sh
set -euo pipefail
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd "/$PORTS_DIR"
curl -LO https://github.com/slate-linux/slate/releases/download/0.4/dev.tar.gz
tar -xf dev.tar.gz
cd "$(tar -tf dev.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
DESTDIR=""
cp -a usr "$DESTDIR"/
