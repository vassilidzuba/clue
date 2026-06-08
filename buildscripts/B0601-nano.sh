#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities_build.sh

PACKAGE=nano-8.7.1
SOURCE=nano-8.7.1.tar.xz
URL=https://www.nano-editor.org/dist/v8/nano-8.7.1.tar.xz
MD5=d873085c342e3670d108c08a0c3ebe2f

run_build () {
    ./configure --prefix=/usr     \
                --sysconfdir=/etc \
                --enable-utf8     \
                --docdir=/usr/share/doc/nano-8.7.1 &&
    make
}

run_test () {
    echo -n
}

run_install () {
    make install &&
    install -v -m644 doc/{nano.html,sample.nanorc} /usr/share/doc/nano-8.7.1
}

run_all
