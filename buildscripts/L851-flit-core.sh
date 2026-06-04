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

PACKAGE=flit_core-3.12.0
SOURCE=flit_core-3.12.0.tar.gz
URL=https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz
MD5=c538415c1f27bd69cbbbf3cdd5135d39

run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist flit_core
}

run_all
