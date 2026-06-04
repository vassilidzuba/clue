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

PACKAGE=s6-linux-init-1.2.0.1
SOURCE=s6-linux-init-1.2.0.1.tar.gz
URL=https://skarnet.org/software/s6-linux-init/s6-linux-init-1.2.0.1.tar.gz
SHA256=72d59b13683d1390f7df9a286be467e73293416021af9fa1023c9293ec5c7d7c

run_build () {
    ./configure --prefix=/usr \
                --enable-shared \
                --disable-static \
                --disable-allstatic \
                --with-dynlib=/usr/lib \
                --with-pkgconfig \
                --sysconfdir=/etc \
                --skeldir=/etc/s6-linux-init/skel \
                --enable-pkgconfig &&
    make

}

run_test () {
    echo -n
}

run_install () {
    make install
    cp /mnt/shared/stage1/config/s6-linux-init/skel/* \
        /etc/s6-linux-init/skel
    s6-linux-init-maker tempdir
    s6-hiercopy tempdir /etc/s6-linux-init/current
    cp /etc/s6-linux-init/current/bin/{halt,reboot,shutdown,poweroff,telinit} \
        /usr/sbin
    rm -vf /usr/sbin/init
    ln -s /etc/s6-linux-init/current/bin/init /usr/sbin
}

run_all
