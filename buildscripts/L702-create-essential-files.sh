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
    if [ ! -L /etc/mtab ]; then
        ln -sv /proc/self/mounts /etc/mtab
    fi

    cp /mnt/shared/config/etc/group /etc/group
    cp /mnt/shared/config/etc/hosts /etc/hosts
    cp /mnt/shared/config/etc/passwd /etc/passwd

    touch /var/log/{btmp,lastlog,faillog,wtmp}
    chgrp -v utmp /var/log/lastlog
    chmod -v 664  /var/log/lastlog
    chmod -v 600  /var/log/btmp

    echo "tester:x:101:101::/home/tester:/bin/bash" >> /etc/passwd
    echo "tester:x:101:" >> /etc/group
    install -o tester -d /home/tester
}

run_all
