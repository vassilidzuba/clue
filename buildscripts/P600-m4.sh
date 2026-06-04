#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=m4-1.4.21
SOURCE=m4-1.4.21.tar.xz
URL=https://ftpmirror.gnu.org/m4/m4-1.4.21.tar.xz
MD5=8051eef7239b2f187791f2ab0034d6b7

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
