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

PACKAGE=kbd-2.9.0
SOURCE=kbd-2.9.0.tar.xz
URL=https://www.kernel.org/pub/linux/utils/kbd/kbd-2.9.0.tar.xz
MD5=7be7c6f658f5fb9512e2c490349a8eeb

load_patch https://www.linuxfromscratch.org/patches/downloads/kbd/kbd-2.9.0-backspace-1.patch

run_build () {
    patch -Np1 -i ../kbd-2.9.0-backspace-1.patch &&

    sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure &&
    sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in &&

    ./configure --prefix=/usr --disable-vlock &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
