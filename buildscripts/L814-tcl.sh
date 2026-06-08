#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=tcl8.6.17
SOURCE=tcl8.6.17-src.tar.gz
URL=https://downloads.sourceforge.net/tcl/tcl8.6.17-src.tar.gz
MD5=1ec3444533f54d0f86cd120058e15e48

load_archive https://downloads.sourceforge.net/tcl/tcl8.6.17-html.tar.gz \
             MD5 60c71044e723b0db5f21be82929f3534

run_build () {
    SRCDIR2=$(pwd)
    cd unix
    ./configure --prefix=/usr           \
                --mandir=/usr/share/man \
                --disable-rpath &&

    make &&

    sed -e "s|$SRCDIR2/unix|/usr/lib|" \
        -e "s|$SRCDIR2|/usr/include|"  \
        -i tclConfig.sh &&

    sed -e "s|$SRCDIR2/unix/pkgs/tdbc1.1.12|/usr/lib/tdbc1.1.12|" \
        -e "s|$SRCDIR2/pkgs/tdbc1.1.12/generic|/usr/include|"     \
        -e "s|$SRCDIR2/pkgs/tdbc1.1.12/library|/usr/lib/tcl8.6|"  \
        -e "s|$SRCDIR2/pkgs/tdbc1.1.12|/usr/include|"             \
        -i pkgs/tdbc1.1.12/tdbcConfig.sh &&

    sed -e "s|$SRCDIR2/unix/pkgs/itcl4.3.4|/usr/lib/itcl4.3.4|" \
        -e "s|$SRCDIR2/pkgs/itcl4.3.4/generic|/usr/include|"    \
        -e "s|$SRCDIR2/pkgs/itcl4.3.4|/usr/include|"            \
        -i pkgs/itcl4.3.4/itclConfig.sh &&

    unset SRCDIR2
}

run_test () {
    LC_ALL=C.UTF-8 make test
}

run_install () {
    make install &&
    chmod 644 /usr/lib/libtclstub8.6.a &&
    chmod -v u+w /usr/lib/libtcl8.6.so &&
    make install-private-headers &&
    ln -sfv tclsh8.6 /usr/bin/tclsh &&
    mv -v /usr/share/man/man3/{Thread,Tcl_Thread}.3 &&
    cd .. &&
    tar -xf ../tcl8.6.17-html.tar.gz --strip-components=1 &&
    mkdir -v -p /usr/share/doc/tcl-8.6.17 &&
    cp -v -r  ./html/* /usr/share/doc/tcl-8.6.17
}

run_all
