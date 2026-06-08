#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=lz4-1.10.0
SOURCE=lz4-1.10.0.tar.gz
URL=https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz
MD5=dead9f5f1966d9ae56e1e32761e4e675

run_build () {
    make BUILD_STATIC=no PREFIX=/usr
}

run_test () {
    make -j1 check
}

run_install () {
    make BUILD_STATIC=no PREFIX=/usr install
}

run_all
