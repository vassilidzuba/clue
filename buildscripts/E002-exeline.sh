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

PACKAGE=execline-2.9.9.1
SOURCE=execline-2.9.9.1.tar.gz
URL=https://skarnet.org/software/execline/execline-2.9.9.1.tar.gz
SHA256=be63533297a93c36fd267195117b4e668687a526f834517a8db47d85b6c7ec6a

run_build () {
    ./configure --prefix=/usr \
                --disable-static \
                --disable-allstatic \
                --enable-shared \
                --with-dynlib=/usr/lib \
                --with-pkgconfig \
                --enable-pkgconfig  &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
