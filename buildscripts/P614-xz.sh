#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=xz-5.8.2
SOURCE=xz-5.8.2.tar.xz
URL=https://github.com//tukaani-project/xz/releases/download/v5.8.2/xz-5.8.2.tar.xz
MD5=87c8bb8addf7189d3a51f6a5f03163fc

run_build () {
    ./configure --prefix=/usr                     \
                --host=$LFS_TGT                   \
                --build=$(build-aux/config.guess) \
                --disable-static                  \
                --docdir=/usr/share/doc/xz-5.8.2 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&

    rm -v $XLFS/usr/lib/liblzma.la
}

run_all
