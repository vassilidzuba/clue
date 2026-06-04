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


PACKAGE=markupsafe-3.0.3
SOURCE=markupsafe-3.0.3.tar.gz
URL=https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.3.tar.gz
MD5=13a73126d25afa72a1ff0daed072f5fe

run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist Markupsafe
}

run_all
