#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libunistring-1.4.1
SOURCE=libunistring-1.4.1.tar.xz
URL=https://ftpmirror.gnu.org/libunistring/libunistring-1.4.1.tar.xz
MD5=7419fcbca7c0b29d3b218a09a15cbc76

run_build () {
    sed -r '/_GL_EXTERN_C/s/w?memchr|bsearch/(&)/' \
        -i $(find -name \*.in.h) &&

    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/libunistring-1.4.1 &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
