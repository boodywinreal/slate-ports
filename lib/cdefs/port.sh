#!/bin/bash
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd "/$PORTS_DIR"
git clone https://github.com/berkeley-linux/heritage.git
cd heritage
cp musl-include/sys/* /usr/include/sys/
