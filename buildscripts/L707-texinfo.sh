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

PACKAGE=texinfo-7.2
SOURCE=texinfo-7.2.tar.xz
URL=https://ftpmirror.gnu.org/texinfo/texinfo-7.2.tar.xz
MD5=11939a7624572814912a18e76c8d8972

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
