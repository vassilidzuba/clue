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

PACKAGE=pkgconf-2.5.1
SOURCE=pkgconf-2.5.1.tar.xz
URL=https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz
MD5=3291128c917fdb8fccd8c9e7784b643b

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/pkgconf-2.5.1 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make install &&
    ln -sv pkgconf   /usr/bin/pkg-config &&
    ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1
}

run_all
