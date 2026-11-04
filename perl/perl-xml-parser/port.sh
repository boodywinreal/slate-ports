#!/bin/sh
set -e

PORTS_DIR=${PORTS_DIR:-"/usr/ports"}
cd $PORTS_DIR/perl/perl-xml-parser
curl -LO https://www.cpan.org/authors/id/T/TO/TODDR/XML-Parser-2.59.tar.gz
tar -xf XML-Parser-2.59.tar.gz
cd XML-Parser-2.59

perl Makefile.PL PREFIX=/usr

make -j"$(nproc)"
make DESTDIR="$DESTDIR" install
