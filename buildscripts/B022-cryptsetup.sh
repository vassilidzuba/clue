#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=cryptsetup-2.8.4
SOURCE=cryptsetup-2.8.4.tar.xz
URL=https://www.kernel.org/pub/linux/utils/cryptsetup/v2.8/cryptsetup-2.8.4.tar.xz
MD5=f157bc9287e422b0ec036e11d14611eb

depends-on B011-json-c
depends-on B025-lvm2
depends-on B023-popt

run_build () {
    ./configure --prefix=/usr     \
            --disable-static  \
            --enable-lib-only \
            --disable-asciidoc \
libssh            --docdir=/usr/share/doc/nghttp2-1.69.0 &&
            make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
