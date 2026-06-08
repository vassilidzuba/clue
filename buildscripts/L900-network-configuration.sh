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
    cp /usr/lib/systemd/network/89-ethernet.network.example \
       /etc/systemd/network/89-ethernet.network
}

run_all
