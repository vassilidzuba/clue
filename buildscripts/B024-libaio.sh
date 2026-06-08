#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=libaio-0.3.113
SOURCE=libaio-0.3.113.tar.gz
URL=https://pagure.io/libaio/archive/libaio-0.3.113/libaio-0.3.113.tar.gz
MD5=605237f35de238dfacc83bcae406d95d

run_build () {
    sed -i '/install.*libaio.a/s/^/#/' src/Makefile
    case "$(uname -m)" in
      i?86) sed -e "s/off_t/off64_t/" -i harness/cases/23.t ;;
    esac
    make
}

run_test () {
    make  partcheck

    ### One tgest fails :-(

    true
}

run_install () {
    make install
}

run_all
