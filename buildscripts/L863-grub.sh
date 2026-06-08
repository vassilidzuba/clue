#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=gzip-1.14
SOURCE=gzip-1.14.tar.xz
URL=https://ftpmirror.gnu.org/gzip/gzip-1.14.tar.xz
MD5=4bf5a10f287501ee8e8ebe00ef62b2c2

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    echo '----------------------------'
    echo '--- GRUB is not used by this project'
    echo '----------------------------'
}

run_all
