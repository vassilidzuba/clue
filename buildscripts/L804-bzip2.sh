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

PACKAGE=bzip2-1.0.8
SOURCE=bzip2-1.0.8.tar.gz
URL=https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
MD5=67e051268d0c475ea773822f7500d0e5

load_patch https://www.linuxfromscratch.org/patches/downloads/bzip2/bzip2-1.0.8-install_docs-1.patch

run_build () {
    patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch &&

    sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile &&

    sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile &&

    make -f Makefile-libbz2_so &&
    make clean &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make PREFIX=/usr install &&
    cp -av libbz2.so.* /usr/lib &&
    ln -sfv libbz2.so.1.0.8 /usr/lib/libbz2.so &&
    ln -sfv libbz2.so.1.0.8 /usr/lib/libbz2.so.1
}

run_all
