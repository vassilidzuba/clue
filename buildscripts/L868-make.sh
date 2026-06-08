#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh


PACKAGE=make-4.4.1
SOURCE=make-4.4.1.tar.gz
URL=https://ftpmirror.gnu.org/make/make-4.4.1.tar.gz
MD5=c8469a3713cbbe04d955d4ae4be23eeb

run_build () {
    ./configure --prefix=/usr &&

    make
}

run_test () {
    chown -R tester . &&
    su tester -c "PATH=$PATH make check"
}

run_install () {
    make install
}

run_all
