#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=linux-7.0.11
SOURCE=linux-7.0.11.tar.xz
URL=https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.11.tar.xz
MD5=


run_build () {
    make mrproper
    make headers
    find usr/include -type f ! -name '*.h' -delete
}

run_test () {
    echo -n
}

run_install () {
    cp -rv usr/include $XLFS/usr
}

run_all
