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
    if [ -f $XLFS/etc  ]; then
        echo "The directories were already built."
        exit 0
    fi

    # LFS directories
    mkdir -pv $XLFS/{etc,var} $XLFS/usr/{bin,lib,sbin}

    for i in bin lib sbin; do
      ln -sv usr/$i $XLFS/$i
    done

    case $(uname -m) in
      x86_64) mkdir -pv $XLFS/lib64 ;;
    esac

    # directories used fy the XLFS building procedure
    mkdir -pv $XLFS/tools
    mkdir -pv $XLFS/flags/stage{0,1,2}
    mkdir -pv $XLFS/var/log/stage{0,1,2}
    mkdir -pv $XLFS/mnt/shared
}

run_all
