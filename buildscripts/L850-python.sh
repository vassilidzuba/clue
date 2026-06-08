#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=Python-3.14.3
SOURCE=Python-3.14.3.tar.xz
URL=https://www.python.org/ftp/python/3.14.3/Python-3.14.3.tar.xz
MD5=ef513dcb836d219ae0e2b16ac9c87d0f

load_archive https://www.python.org/ftp/python/doc/3.14.3/python-3.14.3-docs-html.tar.bz2 \
             MD5 005159be74cf46222d6399fbc0fb0ada

run_build () {
    ./configure --prefix=/usr          \
                --enable-shared        \
                --with-system-expat    \
                --enable-optimizations \
                --without-static-libpython &&

    make
}

run_test () {
    make test TESTOPTS="--timeout 240"

    true
}

run_install () {
    make install
}

run_all
