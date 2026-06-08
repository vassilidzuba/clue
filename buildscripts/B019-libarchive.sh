#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libarchive-3.8.5
SOURCE=libarchive-3.8.5.tar.xz
URL=https://github.com/libarchive/libarchive/releases/download/v3.8.5/libarchive-3.8.5.tar.xz
MD5=2cd5a73ed7fe7f9da22d34ac1048534e

depends-on B005-libxml2
depends-on B009-lzo
depends-on B018-nettle

run_build () {
    ./configure --prefix=/usr --disable-static &&
    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    ln -sfv bsdunzip /usr/bin/unzip
}

run_all
