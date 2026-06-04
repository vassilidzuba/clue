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

PACKAGE=coreutils-9.11
SOURCE=coreutils-9.11.tar.xz
URL=https://ftpmirror.gnu.org/coreutils/coreutils-9.11.tar.xz
MD5=e52e9857e4aa9ae38ef32f8ed6a27604

load_patch https://www.linuxfromscratch.org/patches/downloads/coreutils/coreutils-9.11-i18n-1.patch

run_build () {
    patch -Np1 -i ../coreutils-9.11-i18n-1.patch &&

    autoreconf -fv &&
    automake -af &&
    FORCE_UNSAFE_CONFIGURE=1 ./configure \
               --prefix=/usr &&

    make
}

run_test () {
    make NON_ROOT_USERNAME=tester check-root
    groupadd -g 102 dummy -U tester &&
    chown -R tester .  &&
    su tester -c "PATH=$PATH make -k RUN_EXPENSIVE_TESTS=yes check" \
       < /dev/null &&
    groupdel dummy
}

run_install () {
    make install &&

    mv -v /usr/bin/chroot /usr/sbin &&
    mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8 &&
    sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8
}

run_all
