#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=file-5.46
SOURCE=file-5.46.tar.gz
URL=https://astron.com/pub/file/file-5.46.tar.gz
MD5=459da2d4b534801e2e2861611d823864

run_build () {
    mkdir build
    pushd build
      ../configure --disable-bzlib      \
                   --disable-libseccomp \
                   --disable-xzlib      \
                   --disable-zlib
      make
    popd

    ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess) &&

    make FILE_COMPILE=$(pwd)/build/src/file
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&

    rm -v $XLFS/usr/lib/libmagic.la
}

run_all
