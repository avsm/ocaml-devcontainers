#!/usr/bin/env bash
set -e

DESTDIR=${DESTDIR:-/tmp/installdir}
PREFIX=${PREFIX:-/usr/local/ocaml}
export PATH=$PATH:$PREFIX/bin
cd /root

OCAML_VERSION=$1

opam init -ya --disable-sandboxing -c ocaml.${OCAML_VERSION}
case ${OCAML_VERSION} in
5.2.0)
  TRUNK=1
  ;;
5.1.0)
  TRUNK=1
  ;;
*)
  TRUNK=0
  ;;
esac

if [ "$TRUNK" = "0" ]; then
  opam install --confirm-level=unsafe-yes dune ocaml-lsp-server opam-monorepo ocamlformat dune-release odoc mdx
  mv /root/.opam/ocaml.${OCAML_VERSION}/bin/{dune,ocamllsp,opam-monorepo,ocamlformat,dune-release,odoc,ocaml-mdx} ${DESTDIR}/${PREFIX}/bin
else
  opam install --confirm-level=unsafe-yes dune
  mv /root/.opam/ocaml.${OCAML_VERSION}/bin/dune ${DESTDIR}/${PREFIX}/bin
fi
