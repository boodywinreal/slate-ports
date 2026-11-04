#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/dev/meson

curl -LO https://github.com/mesonbuild/meson/archive/refs/tags/1.12.1.tar.gz
tar -xf 1.12.1.tar.gz
cd meson-1.12.1

python3 -m pip install .

