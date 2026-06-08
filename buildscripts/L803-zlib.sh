#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=zlib-1.3.2
SOURCE=zlib-1.3.2.tar.gz
URL=https://zlib.net/fossils/zlib-1.3.2.tar.gz
MD5=a1e6c958597af3c67d162995a342138a

run_build () {
    ./configure --prefix=/usr &&

    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    rm -fv /usr/lib/libz.a
}

run_all
