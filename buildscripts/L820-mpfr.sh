#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=mpfr-4.2.2
SOURCE=mpfr-4.2.2.tar.xz
URL=https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
MD5=7c32c39b8b6e3ae85f25156228156061

run_build () {
    ./configure --prefix=/usr        \
                --disable-static     \
                --enable-thread-safe \
                --docdir=/usr/share/doc/mpfr-4.2.2  &&

    make &&
    make html
}

run_test () {
    make check
}

run_install () {
    make install &&
    make install-html
}

run_all
