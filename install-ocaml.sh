#!/bin/sh
set -e

# TODO: switch to patricoferris/opam-sysinstall when it supports OCaml 5.0
cd /root
OCAML_VERSION=$1
case ${OCAML_VERSION} in
5.0.0)
  OCAML_VERSION=5.0.0-alpha1
  ;;
*)
  ;;
esac
curl -OL https://github.com/ocaml/ocaml/archive/refs/tags/${OCAML_VERSION}.tar.gz
tar -xf ${OCAML_VERSION}.tar.gz
cd ocaml-${OCAML_VERSION}
./configure --prefix=/usr
make -j world.opt >/dev/null
make install DESTDIR=/tmp/installdir
make install
rm -f /root/${OCAML_VERSION}.tar.gz
rm -rf /root/ocaml-${OCAML_VERSION}
