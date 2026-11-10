
#!/bin/sh
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd "/$PORTS_DIR"
if command -v gcc >/dev/null 2>&1; then
    C="gcc"
else
    C="cc"
fi
if command -v g++ >/dev/null 2>&1; then
    CXX="g++"
else
    CXX="c++"
fi

if command -v ccache >/dev/null 2>&1; then
    C="ccache $C"
    CXX="ccache $CXX"
fi

curl -LO https://mandoc.bsd.lv/snapshots/mandoc-1.14.6.tar.gz
tar -xf mandoc-1.14.6.tar.gz
cd "$(tar -tf mandoc-1.14.6.tar.gz | head -1 | cut -d/ -f1)"
PORTS_DIR=${PORTS_DIR:-"/usr/ports"}

cat > configure.local <<'EOF'
PREFIX="/usr"
BINDIR="${PREFIX}/bin"
SBINDIR="${PREFIX}/sbin"
MANDIR="${PREFIX}/share/man"
BINM_PAGER="less"
LN="ln -sf"
EOF

./configure C="$C" CXX="$CXX"
make -j"${MAKETHREADS:-$(nproc)}"
make DESTDIR="$DESTDIR" install

