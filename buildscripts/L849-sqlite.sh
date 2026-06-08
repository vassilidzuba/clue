#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=sqlite-autoconf-3510200
SOURCE=sqlite-autoconf-3510200.tar.gz
URL=https://sqlite.org/2026/sqlite-autoconf-3510200.tar.gz
MD5=49600a5739d382c648b1a317e4b57446

load_archive https://anduin.linuxfromscratch.org/LFS/sqlite-doc-3510200.tar.xz \
             MD5 6f798c5dcd409ee563684c70be7e16fe

run_build () {
    tar -xf ../sqlite-doc-3510200.tar.xz

    ./configure --prefix=/usr     \
                --disable-static  \
                --enable-fts{4,5} \
                CPPFLAGS="-D SQLITE_ENABLE_COLUMN_METADATA=1 \
                          -D SQLITE_ENABLE_UNLOCK_NOTIFY=1   \
                          -D SQLITE_ENABLE_DBSTAT_VTAB=1     \
                          -D SQLITE_SECURE_DELETE=1" &&

    make LDFLAGS.rpath=""
}

run_test () {
    echo -n
}

run_install () {
    make install &&
    install -v -m755 -d /usr/share/doc/sqlite-3.51.2 &&
    cp -v -R sqlite-doc-3510200/* /usr/share/doc/sqlite-3.51.2
}

run_all
