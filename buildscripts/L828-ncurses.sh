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

PACKAGE=ncurses-6.6
SOURCE=ncurses-6.6.tar.gz
URL=https://invisible-mirror.net/archives/ncurses/ncurses-6.6.tar.gz
MD5=dd45bf6854430af403452a7a6a40652c

run_build () {
    ./configure --prefix=/usr           \
                --mandir=/usr/share/man \
                --with-shared           \
                --without-debug         \
                --without-normal        \
                --with-cxx-shared       \
                --enable-pc-files       \
                --with-pkg-config-libdir=/usr/lib/pkgconfig  &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$PWD/dest install
    sed -e 's/^#if.*XOPEN.*$/#if 1/' \
        -i dest/usr/include/curses.h
    cp --remove-destination -av dest/* /

    for lib in ncurses form panel menu ; do
        ln -sfv lib${lib}w.so /usr/lib/lib${lib}.so
        ln -sfv ${lib}w.pc    /usr/lib/pkgconfig/${lib}.pc
    done

    ln -sfv libncursesw.so /usr/lib/libcurses.so

    cp -v -R doc -T /usr/share/doc/ncurses-6.6

    cp -pv $ROOT/config/usr/share/terminfo/x/xterm-kitty \
           /usr/share/terminfo/x/
}

run_all
