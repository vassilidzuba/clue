#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=lzo-2.10
SOURCE=lzo-2.10.tar.gz
URL=https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz
MD5=39d3f3f9c55c87b1e5d6888e1420f4b5


run_build () {
    ./configure --prefix=/usr    \
                --enable-shared  \
                --disable-static \
                --docdir=/usr/share/doc/lzo-2.10 &&
    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
