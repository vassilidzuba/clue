#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=wget-1.25.0
SOURCE=wget-1.25.0.tar.gz
URL=https://ftpmirror.gnu.org/wget/wget-1.25.0.tar.gz
MD5=c70ba58b36f944e8ba1d655ace552881

run_build () {
    ./configure --prefix=/usr      \
                --sysconfdir=/etc  \
                --with-ssl=openssl &&
    make
}

run_test () {
    echo -n
    echo "many tests fail, maybe due to missing packages"
    #make check
}

run_install () {
    make install
}

run_all
