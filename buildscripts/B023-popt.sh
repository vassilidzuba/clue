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

PACKAGE=popt-1.19
SOURCE=popt-1.19.tar.gz
URL=https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-1.19.tar.gz
MD5=eaa2135fddb6eb03f2c87ee1823e5a78

run_build () {
    ./configure --prefix=/usr --disable-static &&
    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
