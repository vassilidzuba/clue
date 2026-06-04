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

PACKAGE=diffutils-3.12
SOURCE=diffutils-3.12.tar.xz
URL=https://ftpmirror.gnu.org/diffutils/diffutils-3.12.tar.xz
MD5=d1b18b20868fb561f77861cd90b05de4

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
