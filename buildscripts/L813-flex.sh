#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=flex-2.6.4
SOURCE=flex-2.6.4.tar.gz
URL=https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
MD5=2882e3179748cc9f9c23ec593d6adc8d


run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/flex-2.6.4 &&
    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
