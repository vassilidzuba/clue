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

PACKAGE=Python-3.14.3
SOURCE=Python-3.14.3.tar.xz
URL=https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tar.xz
MD5=ef513dcb836d219ae0e2b16ac9c87d0f

run_build () {
    ./configure --prefix=/usr       \
                --enable-shared     \
                --without-ensurepip \
                --without-static-libpython &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
