#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=attr-2.5.2
SOURCE=attr-2.5.2.tar.gz
URL=https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz
MD5=227043ec2f6ca03c0948df5517f9c927

run_build () {
    ./configure --prefix=/usr     \
                --disable-static  \
                --sysconfdir=/etc \
                --docdir=/usr/share/doc/attr-2.5.2  &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
