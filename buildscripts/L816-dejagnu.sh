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

PACKAGE=dejagnu-1.6.3
SOURCE=dejagnu-1.6.3.tar.gz
URL=https://ftpmirror.gnu.org/dejagnu/dejagnu-1.6.3.tar.gz
MD5=68c5208c58236eba447d7d6d1326b821

load_patch https://www.linuxfromscratch.org/patches/downloads/expect/expect-5.45.4-gcc15-1.patch

run_build () {
    mkdir -v build &&
    cd       build &&

    ../configure --prefix=/usr &&
    makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi &&
    makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi
}

run_test () {
    make check
}

run_install () {
    make install &&
    install -v -dm755  /usr/share/doc/dejagnu-1.6.3 &&
    install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3
}

run_all
