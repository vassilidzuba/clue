#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=libtool-2.5.4
SOURCE=libtool-2.5.4.tar.xz
URL=https://ftpmirror.gnu.org/libtool/libtool-2.5.4.tar.xz
MD5=22e0a29df8af5fdde276ea3a7d351d30

run_build () {
    ./configure --prefix=/usr &&

    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    rm -fv /usr/lib/libltdl.a
}

run_all
