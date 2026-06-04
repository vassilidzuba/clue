#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_root
check_mount
check_xlfs

run_build () {
    echo -n
}

run_test () {
    echo -n
}

run_install () {
    if [ "$(getent group xlfs)" == "" ]; then
        groupadd xlfs
    fi

    if [ "$(getent passwd xlfs)" == "" ]; then
        useradd -s /bin/bash -g xlfs -m -k /dev/null xlfs
    fi

    chown -v xlfs $XLFS/{usr{,/*},var,etc,tools,flags,flags/stage0/*}
    case $(uname -m) in
      x86_64) chown -v xlfs $XLFS/lib64 ;;
    esac

    cp config/user_config/bash_profile ~xlfs/.bash_profile
    echo "XLFS=$XLFS" > ~xlfs/.bashrc
    cat config/user_config/bashrc >> ~xlfs/.bashrc
    chown -v xlfs:xlfs ~xlfs/.*
    chown -R xlfs:xlfs $XLFS
}

run_all
