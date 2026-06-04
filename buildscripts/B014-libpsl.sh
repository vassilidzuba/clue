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

PACKAGE=libpsl-0.21.5
SOURCE=libpsl-0.21.5.tar.gz
URL=https://github.com/rockdaboot/libpsl/releases/download/0.21.5/libpsl-0.21.5.tar.gz
MD5=870a798ee9860b6e77896548428dba7b

dependends-on B016-libidn2
dependends-on B015-libpsl

run_build () {
    mkdir build &&
    cd    build &&

    meson setup --prefix=/usr --buildtype=release &&

    ninja
}

run_test () {
    ninja test
}

run_install () {
    ninja install
}

run_all
