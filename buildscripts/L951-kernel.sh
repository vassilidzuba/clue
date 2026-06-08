#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

VERSION=7.0.11

PACKAGE=linux-$VERSION
SOURCE=linux-$VERSION.tar.xz
URL=https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-$VERSION.tar.xz
SHA256=

run_build () {
    make mrproper
    cp /mnt/shared/config/linux/config_${VERSION} .config
    make
}

run_test () {
    echo -n
}

run_install () {
    make modules_install
    cp -v arch/x86/boot/bzImage /boot/vmlinuz-$VERSION-xlfs
    cp -v System.map /boot/System.map-$VERSION-xlfs
    cp -v arch/x86/boot/bzImage /mnt/shared/boot/vmlinuz-$VERSION-xlfs
    cp -v System.map /mnt/shared//boot/System.map-$VERSION-xlfs
}

run_all
