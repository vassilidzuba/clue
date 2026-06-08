#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=readline-8.3
SOURCE=readline-8.3.tar.gz
URL=https://ftpmirror.gnu.org/readline/readline-8.3.tar.gz
MD5=25a73bfb2a3ad7146c5e9d4408d9f6cd

run_build () {
    sed -i '/MV.*old/d' Makefile.in &&
    sed -i '/{OLDSUFF}/c:' support/shlib-install &&
    sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf &&
    sed -e '270a\
         else\
           chars_avail = 1;'      \
        -e '288i\   result = -1;' \
        -i.orig input.c &&
    ./configure --prefix=/usr    \
                --disable-static \
                --with-curses    \
                --docdir=/usr/share/doc/readline-8.3 &&

    make SHLIB_LIBS="-lncursesw"
}

run_test () {
    echo -n
}

run_install () {
    make install &&
    install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.3
}

run_all
