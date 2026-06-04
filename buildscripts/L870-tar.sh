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


PACKAGE=tar-1.35
SOURCE=tar-1.35.tar.xz
URL=https://ftpmirror.gnu.org/tar/tar-1.35.tar.xz
MD5=a2d8042658cfd8ea939e6d911eaf4152

run_build () {
    FORCE_UNSAFE_CONFIGURE=1  \
    ./configure --prefix=/usr &&

    make
}

run_test () {
    make check
    # one test fails (capabilities)
    true
}

run_install () {
    make install &&
    make -C doc install-html docdir=/usr/share/doc/tar-1.35
}

run_all
