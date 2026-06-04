#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=gawk-5.3.2
SOURCE=gawk-5.3.2.tar.xz
URL=https://ftpmirror.gnu.org/gawk/gawk-5.3.2.tar.xz
MD5=b7014650c5f45e5d4837c31209dc0037

run_build () {
    sed -i 's/extras//' Makefile.in  &&

    ./configure --prefix=/usr   \
                --host=$LFS_TGT \
                --build=$(build-aux/config.guess) &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install
}

run_all
