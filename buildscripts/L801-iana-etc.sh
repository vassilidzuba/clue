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

PACKAGE=iana-etc-20260202
SOURCE=iana-etc-20260202.tar.gz
URL=https://github.com/Mic92/iana-etc/releases/download/20260202/iana-etc-20260202.tar.gz
MD5=fe91258a0760912f61f1d6b200a1d885

SUPPORTBINARY=true

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    mkdir -pv $DISTDIR/etc
    cp -v services protocols $DISTDIR/etc
}

run_all
