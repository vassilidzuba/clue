#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=glibc-2.43
SOURCE=glibc-2.43.tar.xz
URL=https://ftpmirror.gnu.org/glibc/glibc-2.43.tar.xz
MD5=7ec2588300b299215a65aec7e6afa04f

load_patch https://www.linuxfromscratch.org/patches/downloads/glibc/glibc-fhs-1.patch

run_build () {
    case $(uname -m) in
        i?86)   ln -sfv ld-linux.so.2 $XLFS/lib/ld-lsb.so.3
        ;;
        x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $XLFS/lib64
                ln -sfv ../lib/ld-linux-x86-64.so.2 $XLFS/lib64/ld-lsb-x86-64.so.3
        ;;
    esac

    patch -Np1 -i ../glibc-fhs-1.patch &&

    mkdir -v build &&
    cd       build &&

    echo "rootsbindir=/usr/sbin" > configparms &&

    ../configure                             \
          --prefix=/usr                      \
          --host=$LFS_TGT                    \
          --build=$(../scripts/config.guess) \
          --disable-nscd                     \
          --disable-werror                   \
          libc_cv_slibdir=/usr/lib           \
          --enable-kernel=5.4 &&

    make
}

run_test () {
    echo -n
}

run_install () {
    make DESTDIR=$XLFS install &&

    sed '/RTLDLIST=/s@/usr@@g' -i $XLFS/usr/bin/ldd &&

    echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log &&
    readelf -l a.out | grep ': /lib' &&

    grep -E -o "$XLFS/lib.*/S?crt[1in].*succeeded" dummy.log &&

    grep -B3 "^ $XLFS/usr/include" dummy.log
}

run_all
