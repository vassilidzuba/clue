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


PACKAGE=patch-2.8
SOURCE=patch-2.8.tar.xz
URL=https://ftpmirror.gnu.org/patch/patch-2.8.tar.xz
MD5=149327a021d41c8f88d034eab41c039f

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
