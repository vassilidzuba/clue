#!/bin/bash

# Build binutils

if [ ! -f i_am_at_root ]; then
    echo "This script must be run at the root of the repo"
    exit 255
fi

source scripts/_utilities_stage0.sh

check_is_xlfs
check_mount

PACKAGE=gcc-16.1.0
SOURCE=gcc-16.1.0.tar.xz
URL=https://ftpmirror.gnu.org/gcc/gcc-16.1.0/gcc-16.1.0.tar.xz
SHA256=50efb4d94c3397aff3b0d61a5abd748b4dd31d9d3f2ab7be05b171d36a510f79

load_archive https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz \
             7c32c39b8b6e3ae85f25156228156061

load_archive https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz \
             956dc04e864001a9c22429f761f2c283

load_archive https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz \
             5c9bc658c9fd0f940e8e3e0f09530c62

run_build () {
    if [ ! -d mpfr ]; then
        tar -xf ../mpfr-4.2.2.tar.xz
        mv -v mpfr-4.2.2 mpfr
    fi
    if [ ! -d gmp ]; then
        tar -xf ../gmp-6.3.0.tar.xz
        mv -v gmp-6.3.0 gmp
    fi
    if [ ! -d mpc ]; then
        tar -xf ../mpc-1.3.1.tar.gz
        mv -v mpc-1.3.1 mpc
    fi

    case $(uname -m) in
      x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
     ;;
    esac

    rm -rf   build &&
    mkdir -v build &&
    cd       build &&

    echo "=========================================="
    echo "LFS_TGT=$LFS_TGT"
    echo "XLFS=$XLFS"
    pwd
    echo "=========================================="

    ../configure                  \
        --target=$LFS_TGT         \
        --prefix=$XLFS/tools      \
        --with-glibc-version=2.43 \
        --with-sysroot=$XLFS      \
        --with-newlib             \
        --without-headers         \
        --enable-default-pie      \
        --enable-default-ssp      \
        --disable-nls             \
        --disable-shared          \
        --disable-multilib        \
        --disable-threads         \
        --disable-libatomic       \
        --disable-libgomp         \
        --disable-libquadmath     \
        --disable-libssp          \
        --disable-libvtv          \
        --disable-libstdcxx       \
        --enable-languages=c,c++ &&

    make
}

run_test () {
    echo "====================="
    echo "     test"
    echo "====================="

    echo -n
}

run_install () {
    echo "====================="
    echo "     installing"
    echo "====================="

    make install &&

    cd .. &&
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
      `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h
}

run_all
