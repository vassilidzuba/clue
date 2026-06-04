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

PACKAGE=expect5.45.4
SOURCE=expect5.45.4.tar.gz
URL=https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz
MD5=00fce8de158422f5ccd2666512329bd2

load_patch https://www.linuxfromscratch.org/patches/downloads/expect/expect-5.45.4-gcc15-1.patch

run_build () {
    python3 -c 'from pty import spawn; spawn(["echo", "ok"])'
    if [ $? != 0 ]; then
        echo "failed to create pty"
        exit 255
    fi

    patch -Np1 -i ../expect-5.45.4-gcc15-1.patch &&

    ./configure --prefix=/usr           \
                --with-tcl=/usr/lib     \
                --enable-shared         \
                --disable-rpath         \
                --mandir=/usr/share/man \
                --with-tclinclude=/usr/include &&

    make
}

run_test () {
    make test
}

run_install () {
    make install &&
    ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
}

run_all
