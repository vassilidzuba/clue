#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=gettext-1.0
SOURCE=gettext-1.0.tar.xz
URL=https://ftpmirror.gnu.org/gettext/gettext-1.0.tar.xz
MD5=dc8b2911535929cec1e263706b0a13a1

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/gettext-1.0  &&

    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    chmod -v 0755 /usr/lib/preloadable_libintl.so
}

run_all
