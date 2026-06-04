#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=coreutils-9.10
SOURCE=coreutils-9.10.tar.xz
URL=https://ftpmirror.gnu.org/coreutils/coreutils-9.10.tar.xz
MD5=b0482ebec42fd48e95cb9187d566b9e4

run_build () {
    ./configure --prefix=/usr             \
        --host=$LFS_TGT                   \
        --build=$(build-aux/config.guess) \
        --enable-install-program=hostname \
        --enable-no-install-program=kill,uptime &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&

    mv -v $XLFS/usr/bin/chroot              $XLFS/usr/sbin &&
    mkdir -pv $XLFS/usr/share/man/man8 &&
    mv -v $XLFS/usr/share/man/man1/chroot.1 $XLFS/usr/share/man/man8/chroot.8 &&
    sed -i 's/"1"/"8"/'                     $XLFS/usr/share/man/man8/chroot.8
}

run_all
