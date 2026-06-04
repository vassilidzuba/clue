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

PACKAGE=expat-2.7.4
SOURCE=expat-2.7.4.tar.xz
URL=https://github.com/libexpat/libexpat/releases/download/R_2_7_4/expat-2.7.4.tar.xz
MD5=5d3d1e1c829f8fb6f42b8e3e2371afa3

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/expat-2.7.4 &&

    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.7.4
}

run_all
