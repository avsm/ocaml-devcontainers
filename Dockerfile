# just hardcoding 4.14 for the moment
FROM ocaml/opam:debian-11-ocaml-4.14 as opam
# need to avoid conflict between odoc-parser/ocamlformat/odoc until next odoc release
RUN opam-2.1 pin add -n odoc --dev
# no utop as its bytecode so has wrong interpreter baked in for relocation
RUN opam-2.1 install --confirm-level=unsafe-yes dune ocaml-lsp-server opam-monorepo ocamlformat.0.24.1 dune-release odoc mdx
FROM debian:11
RUN apt-get -y update && apt-get -y install build-essential curl
RUN cd /root && curl -OL https://github.com/ocaml/ocaml/archive/refs/tags/4.14.0.tar.gz && tar -xf 4.14.0.tar.gz && cd ocaml-4.14.0 && ./configure --prefix=/usr && make -j world.opt && make install && cd / && rm -f /root/4.14.0.tar.gz && rm -rf /root/ocaml-4.14.0
COPY --from=opam /usr/bin/opam-2.1 /usr/bin/opam
COPY --from=opam /home/opam/.opam/4.14/bin/dune /usr/bin/dune
COPY --from=opam /home/opam/.opam/4.14/bin/ocamllsp /usr/bin/ocamllsp
COPY --from=opam /home/opam/.opam/4.14/bin/opam-monorepo /usr/bin/opam-monorepo
COPY --from=opam /home/opam/.opam/4.14/bin/odoc /usr/bin/odoc
COPY --from=opam /home/opam/.opam/4.14/bin/ocaml-mdx /usr/bin/ocaml-mdx
