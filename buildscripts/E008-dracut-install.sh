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

PACKAGE=dracut-111
SOURCE=dracut-111.tar.gz
URL=https://github.com/dracut-ng/dracut/archive/refs/tags/111.tar.gz
MD5=

run_build () {
    ./configure \
         --prefix=/usr \
         --sysconfdir=/etc \
         --disable-asciidoctor \
         --disable-documentation &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
