#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi

source scripts/_utilities_build.sh

# tests must not run in /tmp
TMPDIR=tmp

PACKAGE=openssh-10.2p1
SOURCE=openssh-10.2p1.tar.gz
URL=https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz
MD5=801b5ad6da38e0045de20dd5dd2f6a80

load_archive https://www.linuxfromscratch.org/blfs/downloads/systemd/blfs-systemd-units-20251204.tar.xz

run_build () {
    if [ ! -d /var/lib/sshd ]; then
        install -v -g sys -m700 -d /var/lib/sshd &&

        groupadd -g 50 sshd        &&
        useradd  -c 'sshd PrivSep' \
                 -d /var/lib/sshd  \
                 -g sshd           \
                 -s /bin/false     \
                 -u 50 sshd
    fi

    ./configure --prefix=/usr                            \
                --sysconfdir=/etc/ssh                    \
                --with-privsep-path=/var/lib/sshd        \
                --with-default-path=/usr/bin             \
                --with-superuser-path=/usr/sbin:/usr/bin \
                --with-pid-dir=/run                      &&
    make
}

run_test () {
    make -j1 tests
}

run_install () {
    $sudo make install &&
    $sudo install -v -m755    contrib/ssh-copy-id /usr/bin     &&


    $sudo install -v -m644    contrib/ssh-copy-id.1 \
                        /usr/share/man/man1              &&
    $sudo install -v -m755 -d /usr/share/doc/openssh-10.2p1    &&
    $sudo install -v -m644    INSTALL LICENCE OVERVIEW README* \
                        /usr/share/doc/openssh-10.2p1

    pushd ..

    tar xvf blfs-systemd-units-20251204.tar.xz
    cd blfs-systemd-units-20251204
    $sudo make install-sshd
    popd
}

run_all
