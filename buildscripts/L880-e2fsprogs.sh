#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh


PACKAGE=e2fsprogs-1.47.3
SOURCE=e2fsprogs-1.47.3.tar.gz
URL=https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz
MD5=113d7a7ee0710d2a670a44692a35fd2e

run_build () {
    mkdir -v build
    cd       build

    ../configure --prefix=/usr       \
                 --sysconfdir=/etc   \
                 --enable-elf-shlibs \
                 --disable-libblkid  \
                 --disable-libuuid   \
                 --disable-uuidd     \
                 --disable-fsck &&

    make
}

run_test () {
    make check

    true
}

run_install () {
    make install &&
    rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a &&
    gunzip -v /usr/share/info/libext2fs.info.gz &&
    install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info &&
    makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo &&
    install -v -m644 doc/com_err.info /usr/share/info &&
    install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
}

run_all
