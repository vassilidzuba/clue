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


PACKAGE=gzip-1.14
SOURCE=gzip-1.14.tar.xz
URL=https://ftpmirror.gnu.org/gzip/gzip-1.14.tar.xz
MD5=4bf5a10f287501ee8e8ebe00ef62b2c2

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
