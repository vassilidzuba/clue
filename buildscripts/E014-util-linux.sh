#!/bin/bash

#
# build only login, when using simple init
#


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


PACKAGE=util-linux-2.41.3
SOURCE=util-linux-2.41.3.tar.xz
URL=https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.3.tar.xz
MD5=d2faa85303dea29e7f6ee40a9465e528

run_build () {
    ./configure --bindir=/usr/bin      \
                --libdir=/usr/lib      \
                --runstatedir=/run     \
                --sbindir=/usr/sbin    \
                --disable-all-programs \
                --enable-login         \
                --disable-static       \
                --without-python       \
                --without-udev         \
                --without-systemd      \
                ADJTIME_PATH=/var/lib/hwclock/adjtime \
                --docdir=/usr/share/doc/util-linux-2.41.3 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make -n install
    exit 255
}

run_all
