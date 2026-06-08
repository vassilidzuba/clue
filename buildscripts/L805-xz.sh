#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=xz-5.8.2
SOURCE=xz-5.8.2.tar.xz
URL=https://github.com//tukaani-project/xz/releases/download/v5.8.2/xz-5.8.2.tar.xz
MD5=87c8bb8addf7189d3a51f6a5f03163fc

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/xz-5.8.2 &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
