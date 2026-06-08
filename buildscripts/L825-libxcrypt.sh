#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=libxcrypt-4.5.2
SOURCE=libxcrypt-4.5.2.tar.xz
URL=https://github.com/besser82/libxcrypt/releases/download/v4.5.2/libxcrypt-4.5.2.tar.xz
MD5=25e888919ddcd153a07daa95224fa436

run_build () {
    sed -i '/strchr/s/const//' lib/crypt-{sm3,gost}-yescrypt.c  &&

    ./configure --prefix=/usr                \
                --enable-hashes=strong,glibc \
                --enable-obsolete-api=no     \
                --disable-static             \
                --disable-failure-tokens &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
