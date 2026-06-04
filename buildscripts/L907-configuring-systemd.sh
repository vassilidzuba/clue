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

PACKAGE=
SOURCE=
URL=
MD5=

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    mkdir -pv /etc/systemd/system/getty@tty1.service.d/  &&
    cp -pv $ROOT/config/etc/systemd/system/getty@tty1.service.d/noclear.conf \
           /etc/systemd/system/getty@tty1.service.d/noclear.conf  &&

    ln -sfv /dev/null /etc/systemd/system/tmp.mount
}

run_all
