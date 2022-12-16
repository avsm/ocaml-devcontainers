#!/usr/bin/env bash
set -e

# TODO: switch to patricoferris/opam-sysinstall when it supports OCaml 5.0
cd /root

OCAML_VERSION=$1

opam init -ya --disable-sandboxing -c ocaml.${OCAML_VERSION}
case ${OCAML_VERSION} in
5.0.0)
  opam repo add alpha https://github.com/kit-ty-kate/opam-alpha-repository.git
  ;;
5.1.0)
  opam repo add alpha https://github.com/kit-ty-kate/opam-alpha-repository.git
  ;;
*)
  ;;
esac

opam pin add -n odoc --dev
opam pin add -n opam-monorepo --dev
opam install --confirm-level=unsafe-yes dune ocaml-lsp-server opam-monorepo ocamlformat dune-release odoc mdx
mv /root/.opam/ocaml.${OCAML_VERSION}/bin/{dune,ocamllsp,opam-monorepo,ocamlformat,dune-release,odoc,ocaml-mdx} /tmp/installdir/usr/bin
