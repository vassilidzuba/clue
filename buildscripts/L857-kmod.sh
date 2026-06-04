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

PACKAGE=kmod-34.2
SOURCE=kmod-34.2.tar.xz
URL=https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz
MD5=36f2cc483745e81ede3406fa55e1065a

run_build () {
    mkdir -p build
    cd       build

    meson setup --prefix=/usr ..    \
                --buildtype=release \
                -D manpages=false &&

    ninja
}

run_test () {
    echo -n
}

run_install () {
    ninja install
}

run_all
