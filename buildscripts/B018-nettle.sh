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

PACKAGE=nettle-3.10.2
SOURCE=nettle-3.10.2.tar.gz
URL=ttps://ftpmirror.gnu.org/nettle/nettle-3.10.2.tar.gz
MD5=b28bcbf6f045ff007940a9401673600d

run_build () {
    ./configure --prefix=/usr --disable-static &&
    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    chmod   -v   755 /usr/lib/lib{hogweed,nettle}.so &&
    install -v -m755 -d /usr/share/doc/nettle-3.10.2 &&
    install -v -m644 nettle.{html,pdf} /usr/share/doc/nettle-3.10.2
}

run_all
