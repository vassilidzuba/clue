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

PACKAGE=mpc-1.3.1
SOURCE=mpc-1.3.1.tar.gz
URL=https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
MD5=5c9bc658c9fd0f940e8e3e0f09530c62

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/mpc-1.3.1  &&

    make &&
    make html
}

run_test () {
    make check
}

run_install () {
    make install &&
    make install-html
}

run_all
