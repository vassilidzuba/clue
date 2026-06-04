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

PACKAGE=sed-4.9
SOURCE=sed-4.9.tar.xz
URL=https://ftpmirror.gnu.org/sed/sed-4.9.tar.xz
MD5=6aac9b2dbafcd5b7a67a8a9bcb8036c3

run_build () {
    ./configure --prefix=/usr  &&

    make &&
    make html
}

run_test () {
    chown -R tester .
    su tester -c "PATH=$PATH make check"
}

run_install () {
    make install &&
    install -d -m755           /usr/share/doc/sed-4.9 &&
    install -m644 doc/sed.html /usr/share/doc/sed-4.9
}

run_all
