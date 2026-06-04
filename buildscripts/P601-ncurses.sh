#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=ncurses-6.6
SOURCE=ncurses-6.6.tar.gz
URL=https://invisible-mirror.net/archives/ncurses/ncurses-6.6.tar.gz
MD5=dd45bf6854430af403452a7a6a40652c

run_build () {
    mkdir build  &&
    pushd build  &&
      ../configure --prefix=$XLFS/tools AWK=gawk &&
      make -C include &&
      make -C progs tic &&
      install progs/tic $XLFS/tools/bin &&
    popd &&

    ./configure --prefix=/usr                \
                --host=$LFS_TGT              \
                --build=$(./config.guess)    \
                --mandir=/usr/share/man      \
                --with-manpage-format=normal \
                --with-shared                \
                --without-normal             \
                --with-cxx-shared            \
                --without-debug              \
                --without-ada                \
                --disable-stripping          \
                AWK=gawk &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install
    ln -sv libncursesw.so $XLFS/usr/lib/libncurses.so
    sed -e 's/^#if.*XOPEN.*$/#if 1/' \
        -i $XLFS/usr/include/curses.h
}

run_all
