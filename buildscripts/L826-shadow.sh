#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=shadow-4.19.3
SOURCE=shadow-4.19.3.tar.xz
URL=https://github.com/shadow-maint/shadow/releases/download/4.19.3/shadow-4.19.3.tar.xz
MD5=c56d98c09e5dbae816250ba5c2285a37

run_build () {
    sed -i 's/groups$(EXEEXT) //' src/Makefile.in &&
    find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \; &&
    find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \; &&
    find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \; &&

    sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
        -e 's:/var/spool/mail:/var/mail:'                   \
        -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
        -i etc/login.defs &&

    if [ "$(get-value '.options.simple' config.yaml)" = "true"  ] ; then
        WITHOUTPAM="--without-pam"
    fi

    touch /usr/bin/passwd &&
    ./configure --sysconfdir=/etc   \
                --disable-static    \
                --with-{b,yes}crypt \
                --without-libbsd    \
                --disable-logind    \
                $WITHOUTPAM         \
                --with-group-name-max-length=32 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make exec_prefix=/usr install

    make -C man install-man

    pwconv
    grpconv

    mkdir -p /etc/default
    useradd -D --gid 999

    sed -i '/MAIL/s/yes/no/' /etc/default/useradd
}

run_all
