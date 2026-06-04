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

PACKAGE=s6-2.15.0.0
SOURCE=s6-2.15.0.0.tar.gz
URL=https://skarnet.org/software/s6/s6-2.15.0.0.tar.gz
SHA256=27dff73d626285540133e075e75887087f5117fd51de59503ef7d29e96f69e4c

run_build () {
    sed -e s/-lskarnet:/-lskarnet:\\n\\nfoo:/ -i Makefile
    ./configure --prefix=/usr \
                --enable-shared \
                --disable-static \
                --with-dynlib=/usr/lib \
                --with-pkgconfig \
                --sysconfdir=/etc \
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
