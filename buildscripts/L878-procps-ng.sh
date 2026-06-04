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


PACKAGE=procps-ng-4.0.6
SOURCE=procps-ng-4.0.6.tar.xz
URL=https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.6.tar.xz
MD5=20c23dc3dd1569a2bb1d1fa93de213ed

run_build () {
    ./configure --prefix=/usr                           \
                --docdir=/usr/share/doc/procps-ng-4.0.6 \
                --disable-static                        \
                --disable-kill                          \
                --enable-watch8bit &&

    make
}

run_test () {
    chown -R tester .
    su tester -c "PATH=$PATH make check"

    true
}

run_install () {
    make install
}

run_all
