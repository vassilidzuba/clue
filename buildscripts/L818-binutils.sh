#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh
PACKAGE=binutils-2.46.0
SOURCE=binutils-2.46.0.tar.xz
URL=https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
MD5=81bb6810bcd1119819dc0804956e1c92

run_build () {
    mkdir -v build &&
    cd       build &&

    ../configure --prefix=/usr       \
                 --sysconfdir=/etc   \
                 --enable-ld=default \
                 --enable-plugins    \
                 --enable-shared     \
                 --disable-werror    \
                 --enable-64-bit-bfd \
                 --enable-new-dtags  \
                 --with-system-zlib  \
                 --enable-default-hash-style=gnu &&
    make tooldir=/usr
}

run_test () {
    make -k check

    grep '^FAIL:' $(find -name '*.log')

}

run_install () {
    make tooldir=/usr install &&

    rm -rfv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a \
            /usr/share/doc/gprofng/
}

run_all
