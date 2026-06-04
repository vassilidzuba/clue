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

PACKAGE=gettext-1.0
SOURCE=gettext-1.0.tar.xz
URL=https://ftpmirror.gnu.org/gettext/gettext-1.0.tar.xz
MD5=dc8b2911535929cec1e263706b0a13a1

run_build () {
    ./configure --disable-shared &&

    make
}

run_test () {
    echo -n
}

run_install () {
    cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} $DISTDIR/usr/bin
}

run_all
