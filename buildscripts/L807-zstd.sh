#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh
PACKAGE=zstd-1.5.7
SOURCE=zstd-1.5.7.tar.gz
URL=https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz
MD5=780fc1896922b1bc52a4e90980cdda48

run_build () {
    make prefix=/usr
}

run_test () {
    make check
}

run_install () {
    make prefix=/usr install &&

    rm -v /usr/lib/libzstd.a
}

run_all
