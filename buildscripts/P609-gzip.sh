#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=gzip-1.14
SOURCE=gzip-1.14.tar.xz
URL=https://ftpmirror.gnu.org/gzip/gzip-1.14.tar.xz
MD5=4bf5a10f287501ee8e8ebe00ef62b2c2

run_build () {
    ./configure --prefix=/usr --host=$LFS_TGT &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install
}

run_all
