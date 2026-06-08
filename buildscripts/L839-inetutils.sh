#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=inetutils-2.8
SOURCE=inetutils-2.8.tar.gz
URL=https://ftpmirror.gnu.org/inetutils/inetutils-2.8.tar.gz
MD5=

run_build () {
    sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c &&

    ./configure --prefix=/usr        \
                --bindir=/usr/bin    \
                --localstatedir=/var \
                --disable-logger     \
                --disable-whois      \
                --disable-rcp        \
                --disable-rexec      \
                --disable-rlogin     \
                --disable-rsh        \
                --disable-servers &&

    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    mv -v /usr/{,s}bin/ifconfig
}

run_all
