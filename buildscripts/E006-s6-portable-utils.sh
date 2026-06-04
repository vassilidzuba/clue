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

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=s6-portable-utils-2.3.1.2
SOURCE=s6-portable-utils-2.3.1.2.tar.gz
URL=https://skarnet.org/software/s6-portable-utils/s6-portable-utils-2.3.1.2.tar.gz
SHA256=cfb90186d0c0eb204e1e5c6f9379e99413c546bccf38bb6e76177f82371aa3aa

run_build () {
    ./configure --prefix=/usr \
                --enable-shared \
                --disable-static \
                --disable-allstatic \
                --with-dynlib=/usr/lib \
                --with-pkgconfig \
                --sysconfdir=/etc \
                --skeldir=/etc/s6-linux-init/skel \
                --enable-pkgconfig &&
    make

}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
