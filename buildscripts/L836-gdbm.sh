#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=gdbm-1.26
SOURCE=gdbm-1.26.tar.gz
URL=https://ftpmirror.gnu.org/gdbm/gdbm-1.26.tar.gz
MD5=aaa600665bc89e2febb3c7bd90679115

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --enable-libgdbm-compat &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
