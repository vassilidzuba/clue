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


PACKAGE=dbus-1.16.2
SOURCE=dbus-1.16.2.tar.xz
URL=https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz
MD5=97832e6f0a260936d28536e5349c22e5

run_build () {
    mkdir build
    cd    build

    meson setup --prefix=/usr --buildtype=release --wrap-mode=nofallback .. &&

    ninja
}

run_test () {
    ninja test
}

run_install () {
    ninja install &&

    ln -sfv /etc/machine-id /var/lib/dbus
}

run_all
