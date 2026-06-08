#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=grep-3.12
SOURCE=grep-3.12.tar.xz
URL=https://ftpmirror.gnu.org/grep/grep-3.12.tar.xz
MD5=5d9301ed9d209c4a88c8d3a6fd08b9ac

run_build () {
    sed -i "s/echo/#echo/" src/egrep.sh &&

    ./configure --prefix=/usr &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
