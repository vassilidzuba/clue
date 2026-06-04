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

PACKAGE=icu
SOURCE=icu4c-78.2-sources.tgz
URL=https://github.com/unicode-org/icu/releases/download/release-78.2/icu4c-78.2-sources.tgz
MD5=

run_build () {
    case $(uname -m) in
      i?86) sed -e "s/U_PLATFORM_IS_LINUX_BASED/__X86_64__ \&\& &/" \
                -i source/test/intltest/ustrtest.cpp ;;
    esac

    cd source                 &&
    ./configure --prefix=/usr &&
    make
}

run_test () {
    make check
}

run_install () {
    make install
}

run_all
