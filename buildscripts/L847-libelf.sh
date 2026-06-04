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

PACKAGE=elfutils-0.194
SOURCE=elfutils-0.194.tar.bz2
URL=https://sourceware.org/ftp/elfutils/0.194/elfutils-0.194.tar.bz2
MD5=1137792ea10e9194637d7344439a5955

run_build () {
    ./configure --prefix=/usr        \
                --disable-debuginfod \
                --enable-libdebuginfod=dummy &&

    make -C lib &&
    make -C libelf
}

run_test () {
    echo -n
}

run_install () {
    make -C libelf install &&
    install -vm644 config/libelf.pc /usr/lib/pkgconfig &&
    rm /usr/lib/libelf.a
}

run_all
