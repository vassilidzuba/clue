#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=gmp-6.3.0
SOURCE=gmp-6.3.0.tar.xz
URL=https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
MD5=956dc04e864001a9c22429f761f2c283

run_build () {
    sed -i '/long long t1;/,+1s/()/(...)/' configure &&

    ./configure --prefix=/usr    \
                --enable-cxx     \
                --disable-static \
                --docdir=/usr/share/doc/gmp-6.3.0 &&

    make &&
    make html
}

run_test () {
    make check 2>&1 | tee gmp-check-log

    awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
}

run_install () {
    make install &&
    make install-html
}

run_all
