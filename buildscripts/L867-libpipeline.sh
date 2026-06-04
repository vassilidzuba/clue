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


PACKAGE=libpipeline-1.5.8
SOURCE=libpipeline-1.5.8.tar.gz
URL=https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz
MD5=17ac6969b2015386bcb5d278a08a40b5

run_build () {
    ./configure --prefix=/usr &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
