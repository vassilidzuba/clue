#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=diffutils-3.12
SOURCE=diffutils-3.12.tar.xz
URL=https://ftpmirror.gnu.org/diffutils/diffutils-3.12.tar.xz
MD5=d1b18b20868fb561f77861cd90b05de4

run_build () {
    ./configure --prefix=/usr   \
                --host=$LFS_TGT \
                gl_cv_func_strcasecmp_works=y \
                --build=$(./build-aux/config.guess) &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install
}

run_all
