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

PACKAGE=
SOURCE=
URL=
MD5=


run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    if [ -d /boot ]; then
        echo "The directories are already created"
    else
        mkdir -pv /{boot,mnt,opt,srv}

        mkdir -pv /etc/{opt,sysconfig}
        mkdir -pv /lib/firmware
        mkdir -pv /media/{floppy,cdrom}
        mkdir -pv /usr/{,local/}{include,src}
        mkdir -pv /usr/lib/locale
        mkdir -pv /usr/local/{bin,lib,sbin}
        mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
        mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
        mkdir -pv /usr/{,local/}share/man/man{1..8}
        mkdir -pv /var/{cache,local,log,mail,opt,spool}
        mkdir -pv /var/lib/{color,misc,locate}

        ln -sfv /run /var/run
        ln -sfv /run/lock /var/lock

        install -dv -m 0750 /root
        install -dv -m 1777 /tmp /var/tmp
    fi
}

run_all
