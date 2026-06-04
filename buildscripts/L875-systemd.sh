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


#PACKAGE=systemd-259.1
#SOURCE=systemd-259.1.tar.gz
#URL=https://github.com/systemd/systemd/archive/v259.1/systemd-259.1.tar.gz
#MD5=623f73826e7702ac08c57febb9d20431

#PACKAGE=systemd-260.1
#SOURCE=systemd-260.1.tar.gz
#URL=https://github.com/systemd/systemd/archive/v260.1/systemd-260.1.tar.gz
#MD5=8a54e8e7736f5a047c990ab570dae7f7

PACKAGE=systemd-260.2
SOURCE=systemd-260.2.tar.gz
URL=https://codeload.github.com/systemd/systemd/tar.gz/refs/tags/v260.2
MD5=9f066cdb9c32177830add1e21d13c4f6

# load_patch https://www.linuxfromscratch.org/patches/downloads/systemd/systemd-260.1-buildfix-1.patch

load_archive https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-260.2.tar.xz

run_build () {
    # patch -Np1 -i ../systemd-260.1-buildfix-1.patch

    sed -e 's/GROUP="render"/GROUP="video"/' \
        -e 's/GROUP="sgx", //'               \
        -i rules.d/50-udev-default.rules.in

    mkdir -p build
    cd       build

    meson setup ..                \
          --prefix=/usr           \
          --buildtype=release     \
          -D default-dnssec=no    \
          -D firstboot=false      \
          -D install-tests=false  \
          -D ldconfig=false       \
          -D sysusers=false       \
          -D rpmmacrosdir=no      \
          -D homed=disabled       \
          -D man=disabled         \
          -D mode=release         \
          -D pamconfdir=no        \
          -D dev-kvm-mode=0660    \
          -D nobody-group=nogroup \
          -D sysupdate=disabled   \
          -D ukify=disabled       \
          -D docdir=/usr/share/doc/systemd-260.2 &&

    ninja
}

run_test () {
    echo 'NAME="Linux From Scratch"' > /etc/os-release &&
    unshare -m ninja test

    true
}

run_install () {
    ninja install &&

    tar -xf ../../systemd-man-pages-260.2.tar.xz \
        --no-same-owner --strip-components=1     \
        -C /usr/share/man &&

    systemd-machine-id-setup &&

    systemctl preset-all
}

run_all
