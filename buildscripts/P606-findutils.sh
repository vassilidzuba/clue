#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=findutils-4.10.0
SOURCE=findutils-4.10.0.tar.xz
URL=https://ftpmirror.gnu.org/findutils/findutils-4.10.0.tar.xz
MD5=870cfd71c07d37ebe56f9f4aaf4ad872

run_build () {
    ./configure --prefix=/usr                   \
                --localstatedir=/var/lib/locate \
                --host=$LFS_TGT                 \
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
