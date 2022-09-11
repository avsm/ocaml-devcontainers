#!/bin/sh
set -e

do_hash() {
    HASH_NAME=$1
    HASH_CMD=$2
    echo "${HASH_NAME}:"
    for f in `find -type f`; do
        f=`echo $f | cut -c3-`
        if [ "$f" = "Release" ]; then
            continue
        fi
        echo " `${HASH_CMD} ${f}  | cut -d" " -f1` `wc -c $f`"
    done
}

cat << EOF
Origin: OCaml Development Tools Repository
Label: OCaml
Suite: stable
Codename: stable
Version: 1.0
Architectures: amd64 arm64
Components: main
Description: OCaml development tools for devcontainers
Date: `date -Ru`
EOF
do_hash "MD5Sum" "md5sum"
do_hash "SHA1" "sha1sum"
do_hash "SHA256" "sha256sum"

