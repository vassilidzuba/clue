#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=wheel-0.46.3
SOURCE=wheel-0.46.3.tar.gz
URL=https://pypi.org/packages/source/w/wheel/wheel-0.46.3.tar.gz
MD5=61fb0c9633fe7492933a8f338db23508


run_build () {
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

}

run_test () {
    echo -n
}

run_install () {
    pip3 install --no-index --find-links dist wheel
}

run_all
