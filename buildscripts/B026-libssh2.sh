#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libssh2-1.11.1
SOURCE=libssh2-1.11.1.tar.gz
URL=https://www.libssh2.org/download/libssh2-1.11.1.tar.gz
MD5=38857d10b5c5deb198d6989dacace2e6

run_build () {
    ./configure --prefix=/usr          \
                --disable-docker-tests \
                --disable-static       &&
    make
}

run_test () {
    make  check
}

run_install () {
    make install
}

run_all
