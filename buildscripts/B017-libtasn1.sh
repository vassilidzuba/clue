#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libtasn1-4.21.0
SOURCE=libtasn1-4.21.0.tar.gz
URL=https://ftpmirror.gnu.org/libtasn1/libtasn1-4.21.0.tar.gz
MD5=2ee1d9f3aa66f1e308c46a283aa9a8c2

run_build () {
    ./configure --prefix=/usr --disable-static &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make install &&
    make -C doc/reference install-data-local
}

run_all
