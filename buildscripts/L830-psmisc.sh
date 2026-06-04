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

PACKAGE=psmisc-23.7
SOURCE=psmisc-23.7.tar.xz
URL=https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz
MD5=53eae841735189a896d614cba440eb10

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
