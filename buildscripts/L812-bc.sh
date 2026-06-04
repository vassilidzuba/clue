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

PACKAGE=bc-7.0.3
SOURCE=bc-7.0.3.tar.xz
URL=https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz
MD5=ad4db5a0eb4fdbb3f6813be4b6b3da74


run_build () {
    CC='gcc -std=c99' ./configure --prefix=/usr -G -O3 -r &&
    make
}

run_test () {
    make test
}

run_install () {
    make install
}

run_all
