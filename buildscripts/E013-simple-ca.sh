#!/bin/bash

#  Copied from https://maplecircuit.dev/others/lfn/linux-from-nothing.html#2.-internet-from-scratch

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

PACKAGE=
SOURCE=
URL=
MD5=

load_archive https://curl.se/ca/cacert.pem

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    mkdir -pv /etc/ssl/
    mkdir -pv /etc/ssl/certs/
    cp /tmp/cacert.pem /etc/ssl/certs/ca-certificates.crt
}

run_all
