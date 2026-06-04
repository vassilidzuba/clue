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


PACKAGE=sysklogd-2.7.2
SOURCE=sysklogd-2.7.2.tar.gz
URL=https://github.com/troglobit/sysklogd/releases/download/v2.7.2/sysklogd-2.7.2.tar.gz
MD5=

run_build () {
    ./configure --prefix=/usr      \
                --sysconfdir=/etc  \
                --runstatedir=/run \
                --without-logger   \
                --disable-static   \
                --docdir=/usr/share/doc/sysklogd-2.7.2 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make install &&
    cp /mnt/shared/stage1/config/etc/syslog.conf  /etc/syslog.conf
}

run_all
