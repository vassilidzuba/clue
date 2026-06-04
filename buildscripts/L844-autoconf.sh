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
PACKAGE=autoconf-2.72
SOURCE=autoconf-2.72.tar.xz
URL=https://ftpmirror.gnu.org/autoconf/autoconf-2.72.tar.xz
MD5=1be79f7106ab6767f18391c5e22be701

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
