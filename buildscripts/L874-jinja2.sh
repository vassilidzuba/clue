#!/bin/bash

if [ "$INCHROOT" != "1" ]; then
    echo "Not in chroot"
    exit 255
fi
cd /mnt/shared
if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_stage1.sh


PACKAGE=jinja2-3.1.6
SOURCE=jinja2-3.1.6.tar.gz
URL=https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz
MD5=66d4c25ff43d1deaf9637ccda523dec8

run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist Jinja2
}

run_all
