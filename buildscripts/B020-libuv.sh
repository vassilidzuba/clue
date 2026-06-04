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

PACKAGE=libuv-v1.52.0
SOURCE=libuv-v1.52.0.tar.gz
URL=https://dist.libuv.org/dist/v1.52.0/libuv-v1.52.0.tar.gz
MD5=fc5065a74649e94ea84a06beb8a7e42f

run_build () {
    sh autogen.sh                              &&
    ./configure --prefix=/usr --disable-static &&
    make
}

run_test () {
    chown -R john:john .
    su john -c "PATH=$PATH make check"
}

run_install () {
    make install
}

run_all
