#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=make-4.4.1
SOURCE=make-4.4.1.tar.gz
URL=https://ftpmirror.gnu.org/make/make-4.4.1.tar.gz
MD5=c8469a3713cbbe04d955d4ae4be23eeb

run_build () {
    ./configure --prefix=/usr   \
                --host=$LFS_TGT \
                --build=$(build-aux/config.guess) &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install
}

run_all
