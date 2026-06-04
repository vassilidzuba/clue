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

PACKAGE=setuptools-82.0.0
SOURCE=setuptools-82.0.0.tar.gz
URL=https://pypi.org/packages/source/s/setuptools/setuptools-82.0.0.tar.gz
MD5=6e65b88d2466b35e86e5187b99502b1c


run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist setuptools
}

run_all
