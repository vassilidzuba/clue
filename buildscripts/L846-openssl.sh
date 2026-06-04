#!/bin/bash

if [ "$INCHROOT" != "1" ]; then
    echo "Not in chroot"
    exit 255
fi
cd /mnt/shared
if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_stage1.sh
PACKAGE=openssl-3.6.1
SOURCE=openssl-3.6.1.tar.gz
URL=https://github.com/openssl/openssl/releases/download/openssl-3.6.1/openssl-3.6.1.tar.gz
MD5=589777dc85ebbfeca70161c0c384d572

run_build () {
    ./config --prefix=/usr         \
             --openssldir=/etc/ssl \
             --libdir=lib          \
             shared                \
             zlib-dynamic &&

    make
}

run_test () {
    HARNESS_JOBS=$(nproc) make test
}

run_install () {
    sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
    make MANSUFFIX=ssl install &&
    mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.6.1 &&
    cp -vfr doc/* /usr/share/doc/openssl-3.6.1
}

run_all
