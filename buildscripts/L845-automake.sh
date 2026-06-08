#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh
PACKAGE=automake-1.18.1
SOURCE=automake-1.18.1.tar.xz
URL=https://ftpmirror.gnu.org/automake/automake-1.18.1.tar.xz
MD5=cea31dbf1120f890cbf2a3032cfb9a68

run_build () {
    ./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.18.1 &&

    make
}

run_test () {
    make -j$(($(nproc)>4?$(nproc):4)) check


}

run_install () {
    make install
}

run_all
