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

PACKAGE=perl-5.42.0
SOURCE=perl-5.42.0.tar.xz
URL=https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
MD5=7a6950a9f12d01eb96a9d2ed2f4e0072

run_build () {
    sh Configure -des                                         \
                 -D prefix=/usr                               \
                 -D vendorprefix=/usr                         \
                 -D useshrplib                                \
                 -D privlib=/usr/lib/perl5/5.42/core_perl     \
                 -D archlib=/usr/lib/perl5/5.42/core_perl     \
                 -D sitelib=/usr/lib/perl5/5.42/site_perl     \
                 -D sitearch=/usr/lib/perl5/5.42/site_perl    \
                 -D vendorlib=/usr/lib/perl5/5.42/vendor_perl \
                 -D vendorarch=/usr/lib/perl5/5.42/vendor_perl &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make install
}

run_all
