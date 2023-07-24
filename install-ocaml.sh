#!/usr/bin/env bash
set -e

DESTDIR=${DESTDIR:-/tmp/installdir}
PREFIX=${PREFIX:-/usr/local/ocaml}
cd /root
OCAML_VERSION=$1
MODE=tags
case ${OCAML_VERSION} in
5.2.0)
  OCAML_VERSION=trunk
  MODE=heads
  ;;
5.1.0)
  OCAML_VERSION=5.1
  MODE=heads
  ;;
*)
  ;;
esac
curl -OL https://github.com/ocaml/ocaml/archive/refs/${MODE}/${OCAML_VERSION}.tar.gz
tar -xf ${OCAML_VERSION}.tar.gz
cd ocaml-${OCAML_VERSION}
./configure --prefix=${PREFIX}
make -j world.opt >/dev/null
make install DESTDIR=${DESTDIR}
make install
rm -f /root/${OCAML_VERSION}.tar.gz
rm -rf /root/ocaml-${OCAML_VERSION}
