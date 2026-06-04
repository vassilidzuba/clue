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

PACKAGE=gawk-5.3.2
SOURCE=gawk-5.3.2.tar.xz
URL=https://ftpmirror.gnu.org/gawk/gawk-5.3.2.tar.xz
MD5=b7014650c5f45e5d4837c31209dc0037

run_build () {
    sed -i 's/extras//' Makefile.in &&

    ./configure --prefix=/usr &&

    make
}

run_test () {
    chown -R tester .
    su tester -c "PATH=$PATH make check"
}

run_install () {
    rm -f /usr/bin/gawk-5.3.2 &&
    make install
}

run_all
