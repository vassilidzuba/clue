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

PACKAGE=LVM2.2.03.38
SOURCE=LVM2.2.03.38.tgz
URL=https://sourceware.org/ftp/lvm2/LVM2.2.03.38.tgz
MD5=a661c55b5a1fcaa068b9e4a561c35f36

depends-on B024-libaio

run_build () {
    PATH+=:/usr/sbin                \
    ./configure --prefix=/usr       \
                --enable-cmdlib     \
                --enable-pkgconfig  \
                --enable-udev_sync  &&
    make
}

run_test () {
#    make -C tools install_tools_dynamic &&
#    make -C udev  install               &&
#    make -C libdm install               &&
#    mount -o remount,dev /tmp           &&
#    LC_ALL=en_US.UTF-8 make check_local
    echo -n
}

run_install () {
    make install &&
    make install_systemd_units &&
    sed -e '/locking_dir =/{s/#//;s/var/run/}' \
        -i /etc/lvm/lvm.conf
}

run_all
