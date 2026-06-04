#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=binutils-2.46.0
SOURCE=binutils-2.46.0.tar.xz
URL=https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
MD5=81bb6810bcd1119819dc0804956e1c92


run_build () {
    sed '6031s/$add_dir//' -i ltmain.sh &&

    rm -rf   build &&
    mkdir -v build &&
    cd       build &&

    ../configure                   \
        --prefix=/usr              \
        --build=$(../config.guess) \
        --host=$LFS_TGT            \
        --disable-nls              \
        --enable-shared            \
        --enable-gprofng=no        \
        --disable-werror           \
        --enable-64-bit-bfd        \
        --enable-new-dtags         \
        --enable-default-hash-style=gnu &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&

    rm -v $XLFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
}

run_all
