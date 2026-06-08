#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh


PACKAGE=
SOURCE=
URL=
MD5=

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    find /usr/lib /usr/libexec -name \*.la -delete &&
    find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf &&
    userdel -r tester
}

run_all
