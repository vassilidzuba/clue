#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=gcc-16.1.0
SOURCE=gcc-16.1.0.tar.xz
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
SHA256=50efb4d94c3397aff3b0d61a5abd748b4dd31d9d3f2ab7be05b171d36a510f79

run_build () {
    rm -rf   build &&
    mkdir -v build &&
    cd       build &&

    ../libstdc++-v3/configure      \
        --host=$LFS_TGT            \
        --build=$(../config.guess) \
        --prefix=/usr              \
        --disable-multilib         \
        --disable-nls              \
        --disable-libstdcxx-pch    \
        --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/16.1.0 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&

    rm -v $XLFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
}

run_all
