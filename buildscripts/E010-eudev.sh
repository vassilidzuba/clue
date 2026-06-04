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

PACKAGE=eudev-3.2.14
SOURCE=eudev-3.2.14.tar.gz
URL=https://github.com/eudev-project/eudev/archive/refs/tags/v3.2.14.tar.gz
MD5=

run_build () {
    sed "s/.\/make.sh//" -i autogen.sh
    ./autogen.sh &&

 ./configure --prefix=/usr           \
             --bindir=/sbin          \
             --sbindir=/sbin         \
             --libdir=/usr/lib       \
             --sysconfdir=/etc       \
             --libexecdir=/lib       \
             --with-rootprefix=      \
             --with-rootlibdir=/lib  \
             --enable-manpages       \
             --disable-static &&

    make
}

run_test () {
    mkdir -pv /lib/udev/rules.d &&
    mkdir -pv /etc/udev/rules.d &&

    make check
}

run_install () {
    make install

    #tar -xvf ../udev-lfs-20171102.tar.xz
    #make -f udev-lfs-20171102/Makefile.lfs install

    udevadm hwdb --update
}

run_all
