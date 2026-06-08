#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities_build.sh

PACKAGE=
SOURCE=
URL=
SHA256=

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    install -pvC $ROOT/scripts/neofetch /usr/bin/neofetch
    install -pvC $ROOT/scripts/cntstage1 /usr/bin/cntstage1
    install -pvC $ROOT/scripts/cntstage2 /usr/bin/cntstage2
}

run_all
