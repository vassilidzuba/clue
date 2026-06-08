#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=nghttp2-1.69.0
SOURCE=nghttp2-1.69.0.tar.xz
URL=https://github.com/nghttp2/nghttp2/releases/download/v1.69.0/nghttp2-1.69.0.tar.xz
MD5=7015bee1f5a24012b848a98bfe4864b1

depends-on B005-libxml2.sh

run_build () {
    ./configure --prefix=/usr     \
            --disable-static  \
            --enable-lib-only \
            --docdir=/usr/share/doc/nghttp2-1.69.0 &&
            make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
