#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh


PACKAGE=man-db-2.13.1
SOURCE=man-db-2.13.1.tar.xz
URL=https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz
MD5=b6335533cbeac3b24cd7be31fdee8c83

run_build () {
    key=".options.with_systemd"
    if [ "$(/mnt/shared/bin/yq $key /mnt/shared/config.yaml)" != "true" ]; then
       excludesystemdoptions="--with-systemdtmpfilesdir=no --with-systemdsystemunitdir=no"
    fi

    echo "excludesystemdoptions=$excludesystemdoptions"

   ./configure --prefix=/usr                         \
                --docdir=/usr/share/doc/man-db-2.13.1 \
                --sysconfdir=/etc                     \
                --disable-setuid                      \
                --enable-cache-owner=bin              \
                --with-browser=/usr/bin/lynx          \
                --with-vgrind=/usr/bin/vgrind         \
                --with-grap=/usr/bin/grap             \
                $excludesystemdoptions      &&

    make
}

run_test () {
    make check
}

run_install () {
    make -n install
}

run_all
