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

PACKAGE=findutils-4.10.0
SOURCE=findutils-4.10.0.tar.xz
URL=https://ftpmirror.gnu.org/findutils/findutils-4.10.0.tar.xz
MD5=870cfd71c07d37ebe56f9f4aaf4ad872

run_build () {
    ./configure --prefix=/usr --localstatedir=/var/lib/locate &&

    make
}

run_test () {
    chown -R tester .
    su tester -c "PATH=$PATH make check"
}

run_install () {
    make install
}

run_all
