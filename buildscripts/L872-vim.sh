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


PACKAGE=vim-9.2.0078
SOURCE=vim-9.2.0078.tar.gz
URL=https://github.com/vim/vim/archive/v9.2.0078/vim-9.2.0078.tar.gz
MD5=592819d17a5f76d39ddba5651912afe0

run_build () {
    echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h &&

    ./configure --prefix=/usr &&

    make
}

run_test () {
    chown -R tester .
    sed '/test_plugin_glvs/d' -i src/testdir/Make_all.mak

    su tester -c "TERM=xterm-256color LANG=en_US.UTF-8 make -j1 test" \
       &> vim-test.log
}

run_install () {
    make install &&
    ln -sv vim /usr/bin/vi
    for L in  /usr/share/man/{,*/}man1/vim.1; do
        ln -sv vim.1 $(dirname $L)/vi.1
    done
    ln -sv ../vim/vim92/doc /usr/share/doc/vim-9.2.0078
}

run_all
