#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=curl-8.18.0
SOURCE=curl-8.18.0.tar.xz
URL=https://curl.se/download/curl-8.18.0.tar.xz
MD5=dae6088bf7af69d3b0a87c762de92248

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --with-openssl   \
                --with-ca-path=/etc/ssl/certs &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make install &&

    rm -rf docs/examples/.deps &&

    find docs \( -name Makefile\* -o  \
                 -name \*.1       -o  \
                 -name \*.3       -o  \
                 -name CMakeLists.txt \) -delete &&

    cp -v -R docs -T /usr/share/doc/curl-8.18.0
}

run_all
