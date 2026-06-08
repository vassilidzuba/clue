#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=perl-5.42.0
SOURCE=perl-5.42.0.tar.xz
URL=https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz
MD5=7a6950a9f12d01eb96a9d2ed2f4e0072

run_build () {
    export BUILD_ZLIB=False
    export BUILD_BZIP2=0

    sh Configure -des                                          \
                 -D prefix=/usr                                \
                 -D vendorprefix=/usr                          \
                 -D privlib=/usr/lib/perl5/5.42/core_perl      \
                 -D archlib=/usr/lib/perl5/5.42/core_perl      \
                 -D sitelib=/usr/lib/perl5/5.42/site_perl      \
                 -D sitearch=/usr/lib/perl5/5.42/site_perl     \
                 -D vendorlib=/usr/lib/perl5/5.42/vendor_perl  \
                 -D vendorarch=/usr/lib/perl5/5.42/vendor_perl \
                 -D man1dir=/usr/share/man/man1                \
                 -D man3dir=/usr/share/man/man3                \
                 -D pager="/usr/bin/less -isR"                 \
                 -D useshrplib                                 \
                 -D usethreads &&


    make
}

run_test () {
    TEST_JOBS=$(nproc) make test_harness
}

run_install () {
    make install &&
    unset BUILD_ZLIB BUILD_BZIP2
}

run_all
