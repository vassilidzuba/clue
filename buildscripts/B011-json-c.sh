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


PACKAGE=json-c-0.18
SOURCE=json-c-0.18.tar.gz
URL=https://s3.amazonaws.com/json-c_releases/releases/json-c-0.18.tar.gz
MD5=e6593766de7d8aa6e3a7e67ebf1e522f

run_build () {
    sed -i 's/VERSION 2.8/VERSION 4.0/' apps/CMakeLists.txt  &&
    sed -i 's/VERSION 3.9/VERSION 4.0/' tests/CMakeLists.txt

    mkdir build &&
    cd    build &&

    cmake -D CMAKE_INSTALL_PREFIX=/usr \
          -D CMAKE_BUILD_TYPE=Release  \
          -D BUILD_STATIC_LIBS=OFF     \
          .. &&
    make
}

run_test () {
    make test
}

run_install () {
    make install
}

run_all
