#!/bin/bash

if [ "$INCHROOT" != "1" ]; then
    echo "Not in chroot"
    exit 255
fi
cd /mnt/shared
if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libxslt-1.1.45
SOURCE=libxslt-1.1.45.tar.xz
URL=https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.45.tar.xz
MD5=84bb3f6ba7f5ee98af5dcd72e828c73e

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --without-python \
                --docdir=/usr/share/doc/libxslt-1.1.45 &&
    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
