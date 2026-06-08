#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=XML-Parser-2.47
SOURCE=XML-Parser-2.47.tar.gz
URL=https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz
MD5=89a8e82cfd2ad948b349c0a69c494463

run_build () {
    perl Makefile.PL &&

    make
}

run_test () {
    make test
}

run_install () {
    make install
}

run_all
