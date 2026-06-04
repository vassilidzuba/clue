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

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=skalibs-2.15.0.0
SOURCE=skalibs-2.15.0.0.tar.gz
URL=https://skarnet.org/software/skalibs/skalibs-2.15.0.0.tar.gz
SHA256=7fde96e8afb4191593a15328883e9c7726c96891cf071222146821e8c87f8007

run_build () {
    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --enable-shared \
                --disable-static \
                --enable-pkgconfig &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
