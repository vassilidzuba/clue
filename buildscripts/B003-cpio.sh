#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=cpio-2.15
SOURCE=cpio-2.15.tar.bz2
URL=https://ftpmirror.gnu.org/cpio/cpio-2.15.tar.bz2
MD5=3394d444ca1905ea56c94b628b706a0b

run_build () {
    sed -e "/^extern int (\*xstat)/s/()/(const char * restrict,  struct stat * restrict)/" \
        -i src/extern.h
    sed -e "/^int (\*xstat)/s/()/(const char * restrict,  struct stat * restrict)/" \
        -i src/global.c

    ./configure --prefix=/usr \
                --enable-mt   \
                --with-rmt=/usr/libexec/rmt &&
    make &&
    makeinfo --html            -o doc/html      doc/cpio.texi &&
    makeinfo --html --no-split -o doc/cpio.html doc/cpio.texi &&
    makeinfo --plaintext       -o doc/cpio.txt  doc/cpio.texi
}

run_test () {
    make check
}

run_install () {
    make install &&
    install -v -m755 -d /usr/share/doc/cpio-2.15/html &&
    install -v -m644    doc/html/* \
                        /usr/share/doc/cpio-2.15/html &&
    install -v -m644    doc/cpio.{html,txt} \
                        /usr/share/doc/cpio-2.15
}

run_all
