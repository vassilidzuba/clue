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

PACKAGE=s6-rc-0.6.1.1
SOURCE=s6-rc-0.6.1.1.tar.gz
URL=https://skarnet.org/software/s6-rc/s6-rc-0.6.1.1.tar.gz
SHA256=b54f226a35be1ee56a228bf1a4c39437f072bc64e69dbf356e733e606a86402d

run_build () {
#958    sed -e s/-ls6:/-ls6:\\n\\nfoo:/ -i Makefile
    ./configure --prefix=/usr \
                --enable-shared \
                --disable-static \
                --disable-allstatic \
                --with-dynlib=/usr/lib \
                --with-pkgconfig \
                --sysconfdir=/etc \
                --enable-pkgconfig &&
    make -n

}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
