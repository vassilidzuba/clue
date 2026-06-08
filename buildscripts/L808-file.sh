#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=file-5.46
SOURCE=file-5.46.tar.gz
URL=https://astron.com/pub/file/file-5.46.tar.gz
MD5=459da2d4b534801e2e2861611d823864

run_build () {
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
