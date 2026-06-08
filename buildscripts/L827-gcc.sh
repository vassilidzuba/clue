#!/bin/bash

if [ ! -f i_am_at_root ]; then
    echo "/mnt/shared has probably not been mounted to the root of the repo"
    exit 255
fi


source scripts/_utilities_build.sh

PACKAGE=gcc-16.1.0
SOURCE=gcc-16.1.0.tar.xz
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
MD5=

load_archive https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.24.tar.bz2

run_build () {
    if [ ! -d isl ]; then
        tar -xf ../isl-0.24.tar.bz2
        mv -v isl-0.24 isl
    fi

    # sed -i 's/char [*]q/&/' libgomp/affinity-fmt.c

    case $(uname -m) in
      x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
      ;;
    esac

    mkdir -v build
    cd       build

    ../configure --prefix=/usr        \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --enable-host-pie        \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-fixincludes    \
             --with-system-zlib &&

    make
}

run_test () {
    ulimit -s -H unlimited &&
    sed -e '/cpython/d' -i ../gcc/testsuite/gcc.dg/plugin/plugin.exp &&
    chown -R tester . &&
    su tester -c "PATH=$PATH make -k check" &&
    ../contrib/test_summary | tee /tmp/gcc.log
}

run_install () {
    make install &&

    chown -v -R root:root \
        /usr/lib/gcc/$(gcc -dumpmachine)/16.1.0/include{,-fixed} &&

    ln -svr /usr/bin/cpp /usr/lib &&

    ln -sv gcc.1 /usr/share/man/man1/cc.1 &&

    ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/16.1.0/liblto_plugin.so \
            /usr/lib/bfd-plugins/

    echo 'int main(){}' | cc -x c - -v -Wl,--verbose &> dummy.log
    readelf -l a.out | grep ': /lib' | tee -a /tmp/gcc.log

    grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log  | tee -a /tmp/gcc.log

    grep -B4 '^ /usr/include' dummy.log | tee -a /tmp/gcc.log

    grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'  | tee -a /tmp/gcc.log

    grep "/lib.*/libc.so.6 " dummy.log | tee -a /tmp/gcc.log

    grep found dummy.log | tee -a /tmp/gcc.log

    rm -v a.out dummy.log

    mkdir -pv /usr/share/gdb/auto-load/usr/lib
    mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
}

run_all
