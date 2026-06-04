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

PACKAGE=libxml2-2.15.1
SOURCE=libxml2-2.15.1.tar.xz
URL= https://download.gnome.org/sources/libxml2/2.15/libxml2-2.15.1.tar.xz
MD5=fcf38f534bb8996984dba978ee3e27f4

depends-on B004-icu

run_build () {
    sed -i "/'git'/,+3d" meson.build

    mkdir build &&
    cd    build &&

    meson setup ..           \
        --prefix=/usr      \
        -D history=enabled \
        -D icu=enabled     &&
    ninja
}

run_test () {
    echo -n
}

run_install () {
    ninja install &&

    sed "s/--static/--shared/" -i /usr/bin/xml2-config
}

run_all
