#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

PACKAGE=btrfs-progs-v6.17.1
SOURCE=btrfs-progs-v6.17.1.tar.xz
URL=https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-v6.17.1.tar.xz
MD5=c52275337b5682c24ed0ccf5cc8a7b9a


run_build () {
    ./configure --prefix=/usr           \
                --disable-static        \
                --disable-documentation &&
    make
}

run_test () {
    make fssum &&
    rm -rf tests/convert-tests/024-ntfs-basic                &&
    rm -rf tests/misc-tests/041-subvolume-delete-during-send &&
    rm -rf tests/fuzz-tests/010-simple-sb &&
    pushd tests
       ./fsck-tests.sh
       ./mkfs-tests.sh
       ./cli-tests.sh
       ./convert-tests.sh
       ./misc-tests.sh
       ./fuzz-tests.sh
    popd
}

run_install () {
    make install
    for i in 5 8; do
       install Documentation/*.$i /usr/share/man/man$i
    done
}

run_all
