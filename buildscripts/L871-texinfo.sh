#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh


PACKAGE=texinfo-7.2
SOURCE=texinfo-7.2.tar.xz
URL=https://ftpmirror.gnu.org/texinfo/texinfo-7.2.tar.xz
MD5=11939a7624572814912a18e76c8d8972

run_build () {
    sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm &&

    ./configure --prefix=/usr &&

    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    make -C doc install-html docdir=/usr/share/doc/tar-1.35
}

run_all
