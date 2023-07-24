#!/bin/sh -ex

sed -e "s,%OCAML_VERSION%,${OCAML_VERSION},g" \
    -e "s,%OCAML_DATE%,`date +%Y%m%d`,g" \
    -e "s,%OCAML_ARCH%,`arch`,g" < $1 > $2
