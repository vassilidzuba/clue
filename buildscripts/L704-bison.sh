#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=bison-3.8.2
SOURCE=bison-3.8.2.tar.xz
URL=https://ftpmirror.gnu.org/bison/bison-3.8.2.tar.xz
MD5=c28f119f405a2304ff0a7ccdcc629713

run_build () {
    ./configure --prefix=/usr \
                --docdir=/usr/share/doc/bison-3.8.2 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
