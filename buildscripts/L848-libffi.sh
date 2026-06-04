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


PACKAGE=libffi-3.5.2
SOURCE=libffi-3.5.2.tar.gz
URL=https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz
MD5=92af9efad4ba398995abf44835c5d9e9

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --with-gcc-arch=native &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
