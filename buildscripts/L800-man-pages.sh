#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=man-pages-6.17
SOURCE=man-pages-6.17.tar.xz
URL=https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.17.tar.xz
MD5=4327b009d63a6e0fc27df3e4c9e7369b

run_build () {
    rm -v man3/crypt*
}

run_test () {
    echo -n
}

run_install () {
    make -R GIT=false prefix=/usr install
}

run_all
