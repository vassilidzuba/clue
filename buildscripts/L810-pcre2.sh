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

PACKAGE=pcre2-10.47
SOURCE=pcre2-10.47.tar.bz2
URL=https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.47/pcre2-10.47.tar.bz2
MD5=aded5840ab5a7d772dd4e16fc294b665

run_build () {
    ./configure --prefix=/usr                       \
                --docdir=/usr/share/doc/pcre2-10.47 \
                --enable-unicode                    \
                --enable-jit                        \
                --enable-pcre2-16                   \
                --enable-pcre2-32                   \
                --enable-pcre2grep-libz             \
                --enable-pcre2grep-libbz2           \
                --enable-pcre2test-libreadline      \
                --disable-static &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
