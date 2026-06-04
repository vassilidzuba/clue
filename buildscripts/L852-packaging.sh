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

PACKAGE=packaging-26.0
SOURCE=packaging-26.0.tar.gz
URL=https://files.pythonhosted.org/packages/source/p/packaging/packaging-26.0.tar.gz
MD5=2cbdbb5754f038736c3c361826c6872a


run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist packaging
}

run_all
