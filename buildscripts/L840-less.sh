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

PACKAGE=less-692
SOURCE=less-692.tar.gz
URL=https://www.greenwoodsoftware.com/less/less-692.tar.gz
MD5=4efd31e34ecf7682a6c62a3c53007600

run_build () {
    ./configure --prefix=/usr --sysconfdir=/etc &&

    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
