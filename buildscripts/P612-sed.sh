#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=sed-4.9
SOURCE=sed-4.9.tar.xz
URL=https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz
MD5=6aac9b2dbafcd5b7a67a8a9bcb8036c3

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
