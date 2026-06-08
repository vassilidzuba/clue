#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libidn2-2.3.8
SOURCE=libidn2-2.3.8.tar.gz
URL=https://ftpmirror.gnu.org/libidn/libidn2-2.3.8.tar.gz
MD5=a8e113e040d57a523684e141970eea7a

depends-on B015-libunistring

run_build () {
    ./configure --prefix=/usr --disable-static &&
    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
