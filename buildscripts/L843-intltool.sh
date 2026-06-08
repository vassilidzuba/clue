#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=intltool-0.51.0
SOURCE=intltool-0.51.0.tar.gz
URL=https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz
MD5=12e517cac2b57a0121cda351570f1e63

run_build () {
    sed -i 's:\\\${:\\\$\\{:' intltool-update.in &&
    ./configure --prefix=/usr &&
    make
}

run_test () {
    make check
}

run_install () {
    make install &&
    install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO
}

run_all
