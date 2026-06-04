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

PACKAGE=dracut-111
SOURCE=dracut-111.tar.gz
URL=https://github.com/dracut-ng/dracut/archive/refs/tags/111.tar.gz
MD5=

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    cp -pv $ROOT/stage1/config/etc/dracut-i18n.conf /etc/dracut.conf.d/i18n.conf

    INITRAMFS=/boot/initramfs-7.0.10-xlfs
    rm -f $INITRAMFS
    dracut --kver 7.0.10-xlfs $INITRAMFS
}

run_all
