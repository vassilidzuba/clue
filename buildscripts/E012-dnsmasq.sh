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

PACKAGE=dnsmasq-2.92rel2
SOURCE=dnsmasq-2.92rel2.tar.xz
URL=https://thekelleys.org.uk/dnsmasq/dnsmasq-2.92rel2.tar.xz
MD5=

run_build () {
    make
}

run_test () {
    echo -n
}

run_install () {
    make install PREFIX=/usr &&
    cp -pv /mnt/shared/stage1/config/etc/dnsmasq-dns.conf /etc &&
    echo "nameserver 1.1.1.1" > /etc/resolv.conf
}

run_all
