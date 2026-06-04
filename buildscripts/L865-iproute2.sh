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


PACKAGE=iproute2-6.18.0
SOURCE=iproute2-6.18.0.tar.xz
URL=https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.18.0.tar.xz
MD5=9e3f70620db43fe0ecab29b36a47914d

run_build () {
    sed -i /ARPD/d Makefile &&
    rm -fv man/man8/arpd.8 &&

    make NETNS_RUN_DIR=/run/netns
}

run_test () {
    echo -n
}

run_install () {
    make SBINDIR=/usr/sbin install &&
    install -vDm644 COPYING README* -t /usr/share/doc/iproute2-6.18.0
}

run_all
