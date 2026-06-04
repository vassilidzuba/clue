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

PACKAGE=sudo-1.9.17p2
SOURCE=sudo-1.9.17p2.tar.gz
URL=https://www.sudo.ws/dist/sudo-1.9.17p2.tar.gz
MD5=dcbf46f739ae06b076e1a11cbb271a10

run_build () {
    ./configure --prefix=/usr         \
                --libexecdir=/usr/lib \
                --with-secure-path    \
                --with-env-editor     \
                --docdir=/usr/share/doc/sudo-1.9.17p2 \
                --with-passprompt="[sudo] password for %p: " &&
    make
}

run_test () {
    env LC_ALL=C make check |& tee make-check.log
    if [ "$(grep failed make-check/log)" != "" ]; then
        echo "Some test failed"
        cat make-check.log
        exit 255
    fi
}

run_install () {
    make install &&

    if [ ! -f /etc/sudoers.d/00-sudo ]; then
        cp /mnt/shared/config/etc/sudoers.d/00-sudo /etc/sudoers.d
    fi
}

run_all
