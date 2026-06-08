#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=acl-2.3.2
SOURCE=acl-2.3.2.tar.xz
URL=https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz
MD5=590765dee95907dbc3c856f7255bd669

run_build () {
    ./configure --prefix=/usr    \
                --disable-static \
                --docdir=/usr/share/doc/acl-2.3.2  &&

    make
}

run_test () {
    make check

    true
}

run_install () {
    make install
}

run_all
