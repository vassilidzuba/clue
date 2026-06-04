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

source scripts/_utilities.sh
source stage1/scripts/_utilities_stage1.sh

TMPDIR=tmp

PACKAGE=openssh-10.2p1
SOURCE=openssh-10.2p1.tar.gz
URL=https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz
MD5=801b5ad6da38e0045de20dd5dd2f6a80

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
    make install &&
    install -v -m755    contrib/ssh-copy-id /usr/bin     &&


    install -v -m644    contrib/ssh-copy-id.1 \
                        /usr/share/man/man1              &&
    install -v -m755 -d /usr/share/doc/openssh-10.2p1     &&
    install -v -m644    INSTALL LICENCE OVERVIEW README* \
                        /usr/share/doc/openssh-10.2p1
}

run_all
