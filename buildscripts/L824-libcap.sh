#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=libcap-2.77
SOURCE=libcap-2.77.tar.xz
URL=https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.77.tar.xz
MD5=58048c92f90ef8513c17fb9c24c2c1bd

run_build () {
    sed -i '/install -m.*STA/d' libcap/Makefile  &&

    make prefix=/usr lib=lib
}

run_test () {
    make test
}

run_install () {
    make prefix=/usr lib=lib install
}

run_all
