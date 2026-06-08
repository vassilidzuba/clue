#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=m4-1.4.21
SOURCE=m4-1.4.21.tar.xz
URL=https://ftpmirror.gnu.org/m4/m4-1.4.21.tar.xz
MD5=8051eef7239b2f187791f2ab0034d6b7

run_build () {
    ./configure --prefix=/usr &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
