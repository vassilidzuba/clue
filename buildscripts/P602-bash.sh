#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=bash-5.3
SOURCE=bash-5.3.tar.gz
URL=https://ftpmirror.gnu.org/bash/bash-5.3.tar.gz
MD5=977c8c0c5ae6309191e7768e28ebc951

run_build () {
    ./configure --prefix=/usr                      \
                --build=$(sh support/config.guess) \
                --host=$LFS_TGT                    \
                --without-bash-malloc &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&
    ln -sv bash $XLFS/bin/sh
}

run_all
