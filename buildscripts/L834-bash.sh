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

PACKAGE=bash-5.3
SOURCE=bash-5.3.tar.gz
URL=https://ftpmirror.gnu.org/bash/bash-5.3.tar.gz
MD5=977c8c0c5ae6309191e7768e28ebc951

run_build () {
    ./configure --prefix=/usr             \
                --without-bash-malloc     \
                --with-installed-readline \
                --docdir=/usr/share/doc/bash-5.3 &&

    make
}

run_test () {
    chown -R tester .
    LC_ALL=C.UTF-8 su -s /usr/bin/expect tester << "EOF"
    set timeout -1
    spawn make tests
    expect eof
    lassign [wait] _ _ _ value
    exit $value
EOF
}

run_install () {
    make install
}

run_all
