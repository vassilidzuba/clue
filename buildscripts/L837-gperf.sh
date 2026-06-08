#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=gperf-3.3
SOURCE=gperf-3.3.tar.gz
URL=https://ftpmirror.gnu.org/gperf/gperf-3.3.tar.gz
MD5=31753b021ea78a21f154bf9eecb8b079

run_build () {
    ./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.3 &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
