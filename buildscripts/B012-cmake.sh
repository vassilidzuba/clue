#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=cmake-4.2.3
SOURCE=cmake-4.2.3.tar.gz
URL=https://cmake.org/files/v4.2/cmake-4.2.3.tar.gz
MD5=803a1720ec822a8660118a38ca51fc1b

depends-on B013-curl
depends-on B019-libarchive
depends-on B020-libuv
# depends-on nghhttp2

run_build () {
    sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake &&

    ./bootstrap --prefix=/usr        \
                --system-libs        \
                --mandir=/share/man  \
                --no-system-jsoncpp  \
                --no-system-cppdap   \
                --no-system-librhash \
                --docdir=/share/doc/cmake-4.2.3 &&
    make
}

run_test () {
    bin/ctest -j8
}

run_install () {
    make install
}

run_all
