#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=patch-2.8
SOURCE=patch-2.8.tar.xz
URL=https://ftpmirror.gnu.org/patch/patch-2.8.tar.xz
MD5=149327a021d41c8f88d034eab41c039f

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
