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


source scripts/_utilities_stage1.sh

PACKAGE=groff-1.23.0
SOURCE=groff-1.23.0.tar.gz
URL=https://ftpmirror.gnu.org/groff/groff-1.23.0.tar.gz
MD5=5e4f40315a22bb8a158748e7d5094c7d

run_build () {
    ./configure --prefix=/usr  &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
